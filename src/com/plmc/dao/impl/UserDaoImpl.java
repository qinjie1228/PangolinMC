package com.plmc.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.plmc.common.CommonDaoImpl;
import com.plmc.dao.UserDao;

@Repository
public class UserDaoImpl extends CommonDaoImpl implements UserDao {

	@SuppressWarnings("finally")
	@Override
	public String getUserNameByUserNo(String userNo) {
		SqlSession sqlSession = null;
        String result = "";
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.selectOne("getUserNameByUserNo", userNo); 
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return result;
        }
	}

}
