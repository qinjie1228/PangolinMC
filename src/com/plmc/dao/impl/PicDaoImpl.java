package com.plmc.dao.impl;

import java.io.Serializable;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.plmc.common.CommonDaoImpl;
import com.plmc.dao.PicDao;

@Repository
public class PicDaoImpl extends CommonDaoImpl implements PicDao {

	@SuppressWarnings("finally")
	@Override
	public <T extends Serializable> int addToLove(String picNo) {
		SqlSession sqlSession = null;
        Integer result = -1;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.update("addToLove","\'"+picNo+"\'"); 
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
	public <T extends Serializable> int cancelToLove(String picNo) {
		SqlSession sqlSession = null;
        Integer result = -1;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.update("cancelToLove","\'"+picNo+"\'"); 
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
