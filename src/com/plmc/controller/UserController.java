package com.plmc.controller;

import com.plmc.common.Page;
import com.plmc.dto.OrderDto;
import com.plmc.dto.UserDto;
import com.plmc.service.UserLoginService;
import com.plmc.service.UserService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.vo.session.CurrentUser;
import com.plmc.vo.util.UserLogin;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/user")
@Controller
public class UserController extends ControllerConstantUtil {
	
	@Autowired  
	private UserService userService;
	
	@Autowired  
	private UserLoginService userLoginService;

	/**
	 * 登录验证
	 * 访问路径 项目/user/toLogin.do 
	 * @param currentUser
	 * @return
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/toLogin")
	public HashMap<String, Object> toLogin(@ModelAttribute("currentUser") CurrentUser currentUser,
			HttpSession session) throws ParseException{
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		currentUser = userService.login(currentUser);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (currentUser.getCurrentState() > 0) {
			String userNo = currentUser.getCurrentNo();
			String ipAddress = this.getIpAddress(request);
			String[] attrsIp = { "ipAddressOther", "userNo", "loginState" };
			Object[] valuesIp = { ipAddress, userNo, LOGGED_IN };
			List<UserLogin> userLoginlistIp = userLoginService.findUserLogin(attrsIp, valuesIp);
			if (userLoginlistIp.size() == 0) {
				String[] attrs = { "ipAddress", "userNoOther", "loginState" };
				Object[] values = { ipAddress, userNo, LOGGED_IN };
				List<UserLogin> userLoginlist = userLoginService.findUserLogin(attrs, values);
				if (userLoginlist.size() == 0) {
					String[] attrsUser = { "ipAddress", "userNo"};
					Object[] valuesUser = { ipAddress, userNo};
					List<UserLogin> userLoginlistUser = userLoginService.findUserLogin(attrsUser, valuesUser);
					if(userLoginlistUser.size() ==0){
						UserLogin userLogin = new UserLogin(userNo, ipAddress, LOGGED_IN);
						userLoginService.addLoginUser(userLogin);
						map.put("loginMsg", "登录成功，点击跳转！");
						map.put("loginState", 1);
						session.setAttribute(CURRENT_USER, currentUser);
						session.setMaxInactiveInterval(30 * 60 * 60);
					}
					else{
						UserLogin userLogin = userLoginlistUser.get(0);
						if(userLogin.getLoginState() != LOGGED_IN){
							userLogin.setLoginState(LOGGED_IN);
							userLoginService.updateLoginState(userLogin);
						}
						map.put("loginMsg", "登录成功，点击跳转！");
						map.put("loginState", 1);
						session.setAttribute(CURRENT_USER, currentUser);
						session.setMaxInactiveInterval(30 * 60 * 60);
					}
				} else {
					map.put("loginMsg", "请退出本地其他账号！");
					map.put("loginState", 5);
				}
			}
			else{
				map.put("loginMsg", "账号已登录！");
				map.put("loginState", 5);
			}
		}
		else if(currentUser.getCurrentState()==-1||currentUser.getCurrentState()==-2){
			map.put("loginMsg","用户不存在！");
			map.put("loginState",2);
		}
		else if(currentUser.getCurrentState()==-3){
			map.put("loginMsg","用户已过期，请联系管理员！");
			map.put("loginState",3);
		}	
		else if(currentUser.getCurrentState()==-4){
			map.put("loginMsg","密码错误！");
			map.put("loginState",4);
		}	
		return map;
		
	}
	
	
	/**
	 * 登录
	 * 访问路径 项目/user/doLogin.do
	 * @param session
	 * @return
	 */
	@RequestMapping("/doLogin")
	public ModelAndView doLogin(HttpSession session){
		ModelAndView userModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		userModel.addObject(CURRENT_USER, currentUser);
		if(currentUser.getCurrentState()==4||currentUser.getCurrentState()==5){
			userModel.setViewName("page/background/background");
		}
		else{
			userModel.setViewName("index");
			
		}
		return userModel;
		
	}
	
	
	/**
	 * 注销
	 * 访问路径 项目/user/logOff.do
	 * @param session
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("/logOff")
	public ModelAndView logOff(HttpSession session, HttpServletRequest request){
		ModelAndView userModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		if(currentUser != null){
			String[] attrs = {"userNo", "ipAddress", "loginState"};
			Object[] values = {currentUser.getCurrentNo(), this.getIpAddress(request), LOGGED_IN};
			List<UserLogin> list = userLoginService.findUserLogin(attrs, values);
			if(list.size() == 1){
				UserLogin userLogin = list.get(0);
				userLogin.setLoginState(NOT_LOGGED_IN);
				userLoginService.updateLoginState(userLogin);
			}
		}
		session.removeAttribute(CURRENT_USER);
		userModel.setViewName("page/forehead/login");
		return userModel;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/toRegister", method = RequestMethod.POST)
	public HashMap<String, Object> toRegister(@ModelAttribute("userDto") UserDto userDto) throws ParseException{
		boolean result = userService.register(userDto);
		HashMap<String, Object> map = new HashMap<String, Object>();  
		if(result == true){
			map.put("regMsg","注册成功，点击跳转到登录界面！");
			map.put("regState",1);
		}
		else if(result == false){
			map.put("regMsg","注册失败！");
			map.put("regState",2);
		}	
		return map;
		
	}
	
	
	@RequestMapping("/doAlterPwd")
	public ModelAndView doAlterPwd(HttpSession session, @ModelAttribute("currentUser") CurrentUser currentUser) throws ParseException{
		ModelAndView userModel = new ModelAndView();
		CurrentUser currentUserSession = (CurrentUser) session.getAttribute(CURRENT_USER);
		userModel.addObject(CURRENT_USER, currentUserSession);
		
		UserDto userDto = userService.findByUserNo(currentUserSession.getCurrentNo());
		userDto.setUserPwd(currentUser.getCurrentPwd());
		userService.alterUser(userDto);
		if(currentUserSession.getCurrentState()==4||currentUserSession.getCurrentState()==5){
			userModel.setViewName("page/background/background");
		}
		else{
			userModel.setViewName("index");
			
		}
		return userModel;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/checkNameRepeat", method = RequestMethod.POST)
	public HashMap<String, Object> checkNameRepeat(@RequestParam("userName") String userName){
		boolean result = userService.checkNameRepeat(userName);
		HashMap<String, Object> map = new HashMap<String, Object>();  
		if(result == true){
			map.put("checkState",1);
		}
		else if(result == false){
			map.put("checkMsg","该用户已存在！");
			map.put("checkState",2);
		}	
		return map;
		
	}

	
	/**
	 * 转到用户列表页面
	 * 访问路径 项目/user/toGetAllUser.do 
	 * @return
	 */
	@RequestMapping(value = "/toGetAllUser", method = RequestMethod.GET)
	public ModelAndView toGetAllUser(HttpSession session,
			@RequestParam("userState") String userState) {
		ModelAndView userModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute("currentUser");
		userModel.addObject(CURRENT_USER, currentUser);
		userModel.addObject(USER_STATE, userState);
		userModel.setViewName("page/background/user-list");
		
		return userModel;
	}

	/**
	 * 获取所有当前状态下的用户
	 * 访问路径 项目/user/doGetAllUser.do 
	 * @param pageNow
	 * @param userState
	 * @return
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/doGetAllUser")
	public Page<UserDto> doGetAllUser(int pageNow, int pageSize, int userState) throws ParseException {
		Page<UserDto> page =new Page<UserDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"userState"};
		Object[] values = {userState};
		page = userService.findUserPage(page, attrs, values);
		return page;
	}

	@ResponseBody
	@RequestMapping("/getUserCondition")
	public Page<UserDto> getUserCondition(int pageNow, int pageSize, UserDto dto, int userState, String searchStartTime, String searchEndTime) throws ParseException {
		Page<UserDto> page =new Page<UserDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"userName","userRealName","userAge","userSex","userEmail","timeBefore","timeAfter","userState"};
		Object[] values = {dto.getUserName(),dto.getUserRealName(),dto.getUserAge().equals("") ?  null : Integer.parseInt(dto.getUserAge()),dto.getUserSex().equals("") ? null : (dto.getUserSex().equals("男") ? 0: 1),dto.getUserEmail(),searchStartTime,searchEndTime,userState};
		page = userService.findUserPage(page, attrs, values);
		return page;
	}

	
	/**
	 * 提升用户等级
	 * 访问路径 项目/user/promoteUser.do
	 * @param model
	 * @param userNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/promoteUser")
	public Model promoteUser(Model model, String userNo){
		int result = userService.promoteUser(userNo);
		if(1==result){
			model.addAttribute("promoteMsg","用户等级提升成功！");
			model.addAttribute("promoteState",1);
		}
		else{
			model.addAttribute("promoteMsg","用户等级提升失败！");
			model.addAttribute("promoteState",0);
		}
		return model;
		
	}
	
	/**
	 * 用户等级降级
	 * 访问路径 项目/user/degradeUser.do
	 * @param model
	 * @param userNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/degradeUser")
	public Model degradeUser(Model model, String userNo){
		int result = userService.degradeUser(userNo);
		if(1==result){
			model.addAttribute("degradeMsg","用户等级降级成功！");
			model.addAttribute("degradeState",1);
		}
		else{
			model.addAttribute("degradeMsg","用户等级降级失败！");
			model.addAttribute("degradeState",0);
		}
		return model;
		
	}
	
	
	/**
	 * 通过用户编号变更用户状态为过期
	 * 访问路径 项目/user/overdueUser.do
	 * @param model
	 * @param userNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/overdueUser")
	public Model overdueUser(Model model, String userNo){
		int result = userService.deleteUser(userNo);
		if(1==result){
			model.addAttribute("overdueMsg","用户已变更为过期状态！");
			model.addAttribute("overdueState",1);
		}
		else{
			model.addAttribute("overdueMsg","用户过期处理失败！");
			model.addAttribute("overdueState",0);
		}
		return model;
		
	}
	
	/**
	 * 彻底删除用户
	 * 访问路径 项目/user/deleteUser.do
	 * @param model
	 * @param userNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/deleteUser")
	public Model deleteUser(Model model, String userNo){
		int result = userService.deleteUserReally(userNo);
		if(1==result){
			model.addAttribute("deleteMsg","已彻底删除用户！");
			model.addAttribute("deleteState",1);
		}
		else{
			model.addAttribute("deleteMsg","删除用户失败！");
			model.addAttribute("deleteState",0);
		}
		return model;
		
	}
	
	/**
	 * 恢复用户
	 * 访问路径 项目/user/recoverUser.do
	 * @param model
	 * @param userNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/recoverUser")
	public Model recoverUser(Model model, String userNo){
		int result = userService.recoverUser(userNo);
		if(1==result){
			model.addAttribute("recoverMsg","用户已恢复！");
			model.addAttribute("recoverState",1);
		}
		else{
			model.addAttribute("recoverMsg","用户恢复失败！");
			model.addAttribute("recoverState",0);
		}
		return model;
		
	}
	
	/**
	 * 通过用户编号找到用户
	 * 访问路径 项目/user/findUserByUserNo.do
	 * @param userNo
	 * @return
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/findUserByUserNo")
	public UserDto findUserByUserNo(String userNo) throws ParseException{
		UserDto userDto = userService.findByUserNo(userNo);
		return userDto;
	}
	
	/**
	 */
	@ResponseBody
	@RequestMapping("/getUserName")
	public String getUserName(String userNo) throws ParseException{
		String userName = userService.findUserNameByUserNo(userNo);
		return userName;
	}
	
	/**
	 * 修改用户
	 * 访问路径 项目/user/doAlterUser.do
	 * @param user
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/doAlterUser", method = RequestMethod.POST)
	public ModelAndView doAlterUser( 
			@ModelAttribute("userDto") UserDto userDto) throws ParseException{
		ModelAndView userModel = new ModelAndView();
		int result = userService.alterUser(userDto);
		userModel.addObject(USER_STATE, userDto.getUserState());
		if(1 == result){
			userModel.addObject("alterMsg", "用户修改成功！");
			userModel.addObject("alterState", 1);
		}
		else{
			userModel.addObject("alterMsg", "用户修改失败！");
			userModel.addObject("alterState", 0);
		}
		userModel.setViewName("page/background/user-list");
		return userModel;
		
	}
	
	/**
	 * 添加用户
	 * 访问路径 项目/user/addUser.do
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	public ModelAndView addUser(
			@ModelAttribute("userDto") UserDto userDto){
		ModelAndView userModel = new ModelAndView();
		userDto.setUserState(String.valueOf(USER_PRIMARY_STATE));
		userModel.addObject(USER_STATE, Integer.parseInt(userDto.getUserState()));
		userDto.setUserPwd("123456");
		userDto.setUserPic("default-user.jpg");
		int result = userService.addUser(userDto);
		if(1 == result){
			userModel.addObject("addMsg", "用户添加成功！");
			userModel.addObject("addState", 1);
		}
		else{
			userModel.addObject("addMsg", "用户添加失败！");
			userModel.addObject("addState", 0);
		}
		userModel.setViewName("page/background/user-list");
		return userModel;
		
	}
	
	/**
	 * 添加管理员
	 * 访问路径 项目/user/addAdmin.do
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/addAdmin", method = RequestMethod.POST)
	public ModelAndView addAdmin(
			@ModelAttribute("userDto") UserDto userDto){		
		ModelAndView userModel = new ModelAndView();
		userModel.addObject(USER_STATE, USER_ADMIN_STATE);
		
		userDto.setUserAddress("默认管理员地址");
		userDto.setUserRealName("管理员");
		userDto.setUserAge("30");
		userDto.setUserPic("default-admin.jpg");
		userDto.setUserSex("1");
		userDto.setUserState(String.valueOf(USER_ADMIN_STATE));
		
		userService.addUser(userDto);

		userModel.setViewName("page/background/user-list");
		return userModel;
		
	}
	
	
	/**
	 * 获取登录用户IP地址
	 * 
	 * @param request
	 * @return
	 */
	private String getIpAddress(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if (ip.equals("0:0:0:0:0:0:0:1") || ip.equals("127.0.0.1")) {
			ip = "127.0.0.1";
		}
		return ip;
	}
}
