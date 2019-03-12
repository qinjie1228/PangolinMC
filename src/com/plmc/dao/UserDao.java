package com.plmc.dao;

import com.plmc.common.CommonDao;
public interface UserDao extends CommonDao{

	public String getUserNameByUserNo(String userNo);
}
