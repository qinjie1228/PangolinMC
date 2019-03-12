package com.plmc.dao;

import java.io.Serializable;

import com.plmc.common.CommonDao;
public interface PicDao extends CommonDao{
	  
    public <T extends Serializable> int addToLove(String picNo);
    public <T extends Serializable> int cancelToLove(String picNo);
}
