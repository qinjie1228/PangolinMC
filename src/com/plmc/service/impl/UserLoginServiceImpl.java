package com.plmc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.plmc.dao.UserLoginDao;
import com.plmc.service.UserLoginService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.vo.util.UserLogin;
@Service
public class UserLoginServiceImpl extends ServiceConstantUtil implements UserLoginService{
	
	@Resource(name="userLoginDaoImpl")
	private UserLoginDao userLoginDao;

	@Override
	public int addLoginUser(UserLogin userLogin) {
		return userLoginDao.save(userLogin);
	}

	@Override
	public int recoverLogin() {
		return userLoginDao.update();
	}

	@Override
	public List<UserLogin> findUserLogin(String[] attrs, Object[] values){
		return userLoginDao.selectList(UserLogin.class, attrs, values);
	}

	@Override
	public int updateLoginState(UserLogin userLogin) {
		return userLoginDao.update(userLogin);
	}

	@Override
	public int recoverLoginOne(String userNo) {
		return userLoginDao.updateOne(userNo);
	}
	
}
