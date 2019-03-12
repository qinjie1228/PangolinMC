package com.plmc.service;

import java.util.List;

import com.plmc.vo.util.PostCount;

public interface PostCountService {
	
	/**
	 * 已登录用户浏览帖子则帖子浏览量加一
	 * @param postCount
	 * @return
	 */
	public int addPostScanNum(PostCount postCount);
	/**
	 * 取指定条件帖子浏览记录
	 * @param attrs
	 * @param values
	 * @return
	 */
	public List<PostCount> findPostCount(String[] attrs, Object[] values);

}
