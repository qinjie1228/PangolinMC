package com.plmc.service;

import java.text.ParseException;
import java.util.List;

import com.plmc.common.Page;
import com.plmc.dto.ActDto;
import com.plmc.dto.UserDto;
import com.plmc.vo.session.CurrentUser;

public interface UserService {
	
	//登录注册
	/**
	 * 用户登录
	 * @param userName 用户名
	 * @param pwd 密码
	 * @return 登录结果
	 * @throws ParseException 
	 */
	public CurrentUser login(CurrentUser currentUser) throws ParseException;
	/**
	 * 用户注册
	 * @param user 用户对象
	 * @return 注册结果
	 * @throws ParseException 
	 */
	public boolean register(UserDto userDto) throws ParseException;
	/**
	 * 检查用户名是否重复
	 * @param userName 用户名
	 * @return 检查结果
	 */
	public boolean checkNameRepeat(String userName);
	
	
	//用户增删改
	/**
	 * 添加用户
	 * @param user 用户对象
	 * @return 受影响行数
	 */
	public int addUser(UserDto userDto);
	/**
	 * 删除用户
	 * @param UserNo 用户编号
	 * @return 受影响行数
	 */
	public int deleteUser(String userNo);
	/**
	 * 真正删除用户
	 * @param UserNo 用户编号
	 * @return 受影响行数
	 */
	public int deleteUserReally(String userNo);
	/**
	 * 恢复用户
	 * @param UserNo 用户编号
	 * @return 受影响行数
	 */
	public int recoverUser(String userNo);
	/**
	 * 修改用户
	 * @param user 用户对象
	 * @return 受影响行数
	 * @throws ParseException 
	 */
	public int alterUser(UserDto userDto) throws ParseException;
	
	
	//用户等级管理
	/**
	 * 等级升级
	 * @param UserNo 用户编号
	 * @return 受影响行数
	 */
	public int promoteUser(String userNo);
	/**
	 * 等级降级
	 * @param UserNo 用户编号
	 * @return 受影响行数
	 */
	public int degradeUser(String userNo);
	
	
	//用户查询
	/**
	 * 按用户编号查询用户
	 * @param UserNo 用户编号
	 * @return 用户对象
	 * @throws ParseException 
	 */
	public UserDto findByUserNo(String userNo) throws ParseException;
	
	/**
	 * 按用户编号查询用户名
	 * @param userNo
	 * @return
	 */
	public String findUserNameByUserNo(String userNo);
	
	/**
	 * 查询一页用户
	 * @param dtoPage 设置参数
	 * @param attrs 参数‘key’
	 * @param values 参数 ‘value’
	 * @return 
	 * @throws ParseException
	 */
	public Page<UserDto> findUserPage(Page<UserDto> dtoPage, String[] attrs, Object[] values) throws ParseException;
	
	/**
	 * 取指定条件用户
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException 
	 */
	public List<UserDto> findUser(String[] attrs, Object[] values) throws ParseException;

}
