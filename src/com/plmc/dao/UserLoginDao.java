package com.plmc.dao;

import java.io.Serializable;

import com.plmc.common.CommonDao;
public interface UserLoginDao extends CommonDao{
	
    /** 
     *  
     * 修改所有实体 
     * @param pojo 
     * @return 影响的行数 0失败，1成功 
     */  
    public <T extends Serializable> int update();
    
    /** 
     *  
     * 修改指定id实体 
     * @param pojo 
     * @return 影响的行数 0失败，1成功 
     */  
    public <T extends Serializable> int updateOne(Serializable id);

}
