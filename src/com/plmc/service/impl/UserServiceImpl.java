package com.plmc.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.plmc.common.Page;
import com.plmc.dao.UserDao;
import com.plmc.dto.ActDto;
import com.plmc.dto.UserDto;
import com.plmc.service.UserService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.entity.Act;
import com.plmc.vo.entity.User;
import com.plmc.vo.session.CurrentUser;
@Service
public class UserServiceImpl extends ServiceConstantUtil implements UserService{
	
	@Resource(name="userDaoImpl")
	private UserDao userDao;
	
	//**************私有方法 开始**************//
	public UserDto entityToDto(User user) throws ParseException{
		UserDto userDto = new UserDto();
		userDto.setUserNo(user.getUserNo());
		userDto.setUserName(user.getUserName());
		userDto.setUserPwd(user.getUserPwd());
		userDto.setUserRealName(user.getUserRealName());
		userDto.setUserAge(String.valueOf(user.getUserAge()));
		userDto.setUserSex(user.getUserSex() ==0 ? "男" : "女");
		userDto.setUserState(String.valueOf(user.getUserState()));
		userDto.setUserAddress(user.getUserAddress());
		userDto.setUserEmail(user.getUserEmail());
		userDto.setUserPic(user.getUserPic());
		userDto.setUserRegTime(ThreadLocalDateUtil.formatDate(user.getUserRegTime()));
		return userDto;
	}
	
	public User dtoToEntity(UserDto userDto) throws ParseException{
		User user = new User();
		user.setUserNo(userDto.getUserNo());
		user.setUserName(userDto.getUserName());
		user.setUserPwd(userDto.getUserPwd());
		user.setUserRealName(userDto.getUserRealName());
		user.setUserAge(Integer.parseInt(userDto.getUserAge()));
		user.setUserSex(userDto.getUserSex().equals("男") ? 0 : 1);
		user.setUserState(Integer.parseInt(userDto.getUserState()));
		user.setUserAddress(userDto.getUserAddress());
		user.setUserEmail(userDto.getUserEmail());
		user.setUserPic(userDto.getUserPic());
		user.setUserRegTime(ThreadLocalDateUtil.parse(userDto.getUserRegTime()));
		return user;
	}
	
	public User clearUser(User user){
		user.setUserName("");
		user.setUserPwd("");
		user.setUserRealName("");
		user.setUserAge(-1);
		user.setUserSex(-1);
		user.setUserAddress("");
		user.setUserEmail("");
		user.setUserPic("");
		user.setUserRegTime(null);
		user.setUserState(-1);
		return user;
	}
	
	public int changeState(String userNo, int state){
		User user = userDao.getById(User.class, userNo);
		if(user == null){
			return -1;
		}
		else{
			user = this.clearUser(user);
			user.setUserState(state);
			return userDao.update(user);
		}
	}
	
	//**************私有方法 结束**************//
	@Override
	public CurrentUser login(CurrentUser currentUser) throws ParseException {
		String[] attrs = {"userName"};
		Object[] values = {currentUser.getCurrentName()};
		List<UserDto> list = this.findUser(attrs, values);
		if(list.size()==0){
			currentUser.setCurrentState(-1);
			return currentUser;
		}
		else{
			User user = this.dtoToEntity(list.get(0));
			if(user.getUserState() == USER_PRIMARY_STATE || user.getUserState() == USER_SECONDARY_STATE || user.getUserState() == USER_SUPERIOR_STATE){
				if(currentUser.getCurrentState() == CURRENTUSER_USER_STATE){
					if(!user.getUserPwd().equals(currentUser.getCurrentPwd())){
						currentUser.setCurrentState(-4);
						return currentUser;
					}
					else{
						currentUser.setCurrentState(user.getUserState());
						currentUser.setCurrentNo(user.getUserNo());
						return currentUser;
					}
				}
				else{
					currentUser.setCurrentState(-2);
					return currentUser;
				}
			}
			else if(user.getUserState() == USER_ADMIN_STATE || user.getUserState() == USER_ADMIN_SYSTEM_STATE){
				if(currentUser.getCurrentState() == CURRENTUSER_ADMIN_STATE){
					if(!user.getUserPwd().equals(currentUser.getCurrentPwd())){
						currentUser.setCurrentState(-4);
						return currentUser;
					}
					else{
						currentUser.setCurrentState(user.getUserState());
						currentUser.setCurrentNo(user.getUserNo());
						return currentUser;
					}
				}
				else{
					currentUser.setCurrentState(-2);
					return currentUser;
				}
			}
			else{
				currentUser.setCurrentState(-3);
			}
		}
		return currentUser;
	}

	@Override
	public boolean register(UserDto userDto) throws ParseException {
		User user = new User();
		user.setUserState(USER_PRIMARY_STATE);
		user.setUserRegTime(new Date());
		user.setUserName(userDto.getUserName());
		user.setUserPwd(userDto.getUserPwd());
		user.setUserRealName(userDto.getUserRealName());
		user.setUserAge(Integer.parseInt(userDto.getUserAge()));
		user.setUserSex(userDto.getUserSex().equals("男") ? 1: 0);
		user.setUserAddress(userDto.getUserAddress());
		user.setUserEmail(userDto.getUserEmail());
		user.setUserPic(userDto.getUserPic());

		int regResult = userDao.save(user);
		if(regResult == 1){
			return true;
		}
		else{
			return false;
		}
	}
	
	@Override
	public boolean checkNameRepeat(String userName){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userName", userName);
		List<Map<String, Object>> list = userDao.selectMap("listMapUser", map);
		if(list.size()==0){
			return true;
		}
		else{
			return false;
		}
	}
	
	@Override
	public int addUser(UserDto userDto) {
		User user = new User();
		user.setUserState(Integer.parseInt(userDto.getUserState()));
		user.setUserName(userDto.getUserName());
		user.setUserPwd(userDto.getUserPwd());
		user.setUserRealName(userDto.getUserRealName());
		user.setUserAge(Integer.parseInt(userDto.getUserAge()));
		user.setUserSex(userDto.getUserSex().equals("男") ? 0: 1);
		user.setUserAddress(userDto.getUserAddress());
		user.setUserEmail(userDto.getUserEmail());
		user.setUserPic(userDto.getUserPic());
		user.setUserRegTime(new Date());
		return userDao.save(user);
	}

	@Override
	public int deleteUser(String userNo) {
		return this.changeState(userNo, USER_OVERDUE_STATE);
	}
	
	@Override
	public int deleteUserReally(String userNo) {
		return userDao.deleteById(User.class, userNo);
	}

	@Override
	public int recoverUser(String userNo) {
		return this.changeState(userNo, USER_PRIMARY_STATE);
	}

	@Override
	public int alterUser(UserDto userDto) throws ParseException {
		
		User user = userDao.getById(User.class, userDto.getUserNo());
		User userUpdate = this.clearUser(userDao.getById(User.class, userDto.getUserNo()));
		
		if(userDto.getUserName() != null && userDto.getUserName() !=""){
			if(!userDto.getUserName().equals(user.getUserName())){
				userUpdate.setUserName(userDto.getUserName());
			}
		}
		if(userDto.getUserPwd() != null && userDto.getUserPwd() !=""){
			if(!userDto.getUserPwd().equals(user.getUserPwd())){
				userUpdate.setUserPwd(userDto.getUserPwd());
			}
		}
		if(userDto.getUserRealName() != null && userDto.getUserRealName() !=""){
			if(!userDto.getUserRealName().equals(user.getUserRealName())){
				userUpdate.setUserRealName(userDto.getUserRealName());
			}
		}
		if(userDto.getUserSex() != null && userDto.getUserSex() !=""){
			if(!userDto.getUserSex().equals(String.valueOf(user.getUserSex()).equals("0") ? "男" : "女")){
				userUpdate.setUserSex(userDto.getUserSex().equals("男") ? 0: 1);
			}
		}
		if(userDto.getUserAge() != null && userDto.getUserAge() !=""){
			if(!userDto.getUserAge().equals(String.valueOf(user.getUserAge()))){
				userUpdate.setUserAge(Integer.parseInt(userDto.getUserAge()));
			}
		}
		if(userDto.getUserAddress() != null && userDto.getUserAddress() !=""){
			if(!userDto.getUserAddress().equals(user.getUserAddress())){
				userUpdate.setUserAddress(userDto.getUserAddress());
			}
		}
		if(userDto.getUserEmail() != null && userDto.getUserEmail() !=""){
			if(!userDto.getUserEmail().equals(user.getUserEmail())){
				userUpdate.setUserEmail(userDto.getUserEmail());
			}
		}
		if(userDto.getUserPic() != null && userDto.getUserPic() !=""){
			if(!userDto.getUserPic().equals(user.getUserPic())){
				userUpdate.setUserPic(userDto.getUserPic());
			}
		}
		if(userDto.getUserRegTime() != null && userDto.getUserRegTime() !=""){
			if(!userDto.getUserRegTime().equals(ThreadLocalDateUtil.formatDate(user.getUserRegTime()))){
				userUpdate.setUserRegTime(ThreadLocalDateUtil.parse(userDto.getUserRegTime()));
			}
		}
		if(userDto.getUserState() != null && userDto.getUserState() !=""){
			if(!userDto.getUserState().equals(String.valueOf(user.getUserState()))){
				userUpdate.setUserState(Integer.parseInt(userDto.getUserState()));
			}
		}
		
		return userDao.update(userUpdate);
	}

	@Override
	public int promoteUser(String userNo) {
		User user = userDao.getById(User.class, userNo);
		if(user == null){
			return -1;
		}
		else{
			int userState = user.getUserState();
			if (userState > USER_SECONDARY_STATE) {
				return -1;
			} else {
				userState ++;
				user = this.clearUser(user);
				user.setUserState(userState);
				return userDao.update(user);
			}
		}
	}

	@Override
	public int degradeUser(String userNo) {
		User user = userDao.getById(User.class, userNo);
		if(user == null){
			return -1;
		}
		else{
			int userState = user.getUserState();
			if (userState < USER_SECONDARY_STATE) {
				return -1;
			} else {
				userState --;
				user = this.clearUser(user);
				user.setUserState(userState);
				return userDao.update(user);
			}
		}
	}
	
	@Override
	public UserDto findByUserNo(String userNo) throws ParseException{
		return this.entityToDto(userDao.getById(User.class, userNo));
	}
	
	@Override
	public String findUserNameByUserNo(String userNo){
		return userDao.getUserNameByUserNo(userNo);
	}
	
	@Override
	public Page<UserDto> findUserPage(Page<UserDto> dtoPage, String[] attrs, Object[] values) throws ParseException{
		Page<User> userPage = new Page<User>();
		userPage.setPage(dtoPage.getPage());
		userPage.setPageSize(dtoPage.getPageSize());
		
		userPage = userDao.pageSelect(User.class, userPage, attrs, values);

		Page<UserDto> page = new Page<UserDto>();
		page.setPage(userPage.getPage());
		page.setOrder(userPage.getOrder());
		page.setPageSize(userPage.getPageSize());
		page.setSort(userPage.getSort());
		page.setTotal(userPage.getTotal());
		page.setPageCount(userPage.getPageCount());
		List<User> userPageDate = userPage.getData();
		int pageDateSize = userPageDate.size();
		if(pageDateSize <= 0){
			return page;
		}
		else{
			List<UserDto> pageDate = new ArrayList<UserDto>();
			for(int i=0; i<pageDateSize; i++){
				pageDate.add(this.entityToDto(userPageDate.get(i)));
			}
			page.setData(pageDate);
			return page;
		}
		
	}

	@Override
	public List<UserDto> findUser(String[] attrs, Object[] values) throws ParseException {
		List<UserDto> listDto = new ArrayList<UserDto>(); 
		List<User> listEntity = userDao.selectList(User.class, attrs, values);
		for(int i=0; i<listEntity.size(); i++ ){
			UserDto dto = this.entityToDto(listEntity.get(i));
			listDto.add(dto);
		}
		return listDto;
	}

}
