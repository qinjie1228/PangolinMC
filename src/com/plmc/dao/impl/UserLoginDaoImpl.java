package com.plmc.dao.impl;

import java.io.Serializable;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.plmc.common.CommonDaoImpl;
import com.plmc.dao.UserLoginDao;

@Repository
public class UserLoginDaoImpl extends CommonDaoImpl implements UserLoginDao {

	@SuppressWarnings("finally")
	@Override
	public <T extends Serializable> int update() {
        SqlSession sqlSession = null;
        Integer result = -1;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.update("recoverUserLogin"); 
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return result;
        }
	}

	@SuppressWarnings("finally")
	@Override
	public <T extends Serializable> int updateOne(Serializable id) {
		SqlSession sqlSession = null;
        Integer result = -1;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.update("recoverUserLoginOne", id); 
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
