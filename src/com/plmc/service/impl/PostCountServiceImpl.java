package com.plmc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plmc.dao.PostCountDao;
import com.plmc.dao.PostDao;
import com.plmc.service.PostCountService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.vo.entity.Post;
import com.plmc.vo.util.PostCount;
@Service
public class PostCountServiceImpl extends ServiceConstantUtil implements PostCountService{
	
	@Autowired 
	private PostCountDao postCountDao;
	
	@Autowired 
	private PostDao postDao;

	@Override
	public int addPostScanNum(PostCount postCount) {
		Post post = postDao.getById(Post.class, postCount.getPostNo());
		post.setPostScanNum(post.getPostScanNum() + 1);
		postDao.update(post);
		
		return postCountDao.save(postCount);
	}

	@Override
	public List<PostCount> findPostCount(String[] attrs, Object[] values) {
		return postCountDao.selectList(PostCount.class, attrs, values);
	}

	
}
