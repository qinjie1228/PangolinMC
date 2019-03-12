package com.plmc.service;

import java.util.List;

import com.plmc.vo.util.UserLogin;

public interface UserLoginService {
	
	/**
	 * 用户登录则数据库记录一条数据
	 * @param userLogin
	 * @return
	 */
	public int addLoginUser(UserLogin userLogin);
	/**
	 * 改变用户登录状态
	 * @param userLogin
	 * @return
	 */
	public int updateLoginState(UserLogin userLogin);
	/**
	 * 修改数据库所有已记录登录用户登录状态为未登录状态
	 * @return
	 */
	public int recoverLogin();
	/**
	 * 修改数据库当前记录登录用户登录状态为未登录状态
	 * @return
	 */
	public int recoverLoginOne(String userNo);
	/**
	 * 取指定条件用户登录记录
	 * @param attrs
	 * @param values
	 * @return
	 */
	public List<UserLogin> findUserLogin(String[] attrs, Object[] values);

}
