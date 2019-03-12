package com.plmc.service;

import java.text.ParseException;
import java.util.List;

import com.plmc.common.Page;
import com.plmc.dto.ActDto;
import com.plmc.dto.PostDto;

public interface PostService {
	
	//帖子增删改
	/**
	 * 添加帖子
	 * @param postDto 帖子对象
	 * @return
	 */
	public int addPost(PostDto postDto);
	/**
	 * 删除帖子
	 * @param postNo 帖子编号
	 * @return
	 */
	public int deletePost(String postNo);
	/**
	 * 真正删除帖子
	 * @param postNo 帖子编号
	 * @return
	 */
	public int deletePostReally(String postNo);
	/**
	 * 恢复帖子
	 * @param postNo 帖子编号
	 * @return
	 */
	public int recoverPost(String postNo);
	/**
	 * 修改帖子
	 * @param postDto 帖子对象
	 * @return
	 * @throws ParseException 
	 */
	public int alterPost(PostDto postDto) throws ParseException;

	
	//帖子查询
	/**
	 * 按帖子编号查询帖子
	 * @param postNo 帖子编号
	 * @return 帖子对象
	 * @throws ParseException 
	 */
	public PostDto findByPostNo(String postNo) throws ParseException;

	/**
	 * 查询一页帖子
	 * @param dtoPage
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException
	 */
	public Page<PostDto> findPostPage(Page<PostDto> dtoPage, String[] attrs, Object[] values) throws ParseException;
	
	/**
	 * 统计帖子
	 * @param attrs
	 * @param values
	 * @return
	 */
	public int countPost(String[] attrs, Object[] values);
	
	/**
	 * 取指定条件帖子
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException 
	 */
	public List<PostDto> findPost(String[] attrs, Object[] values) throws ParseException;

	
	//置顶，精品，普通帖管理
	/**
	 * 设置置顶帖
	 * @param postNo 帖子编号
	 * @return
	 */
	public int changePostTop(String postNo);
//	/**
//	 * 设置热门帖
//	 * @param postNo 帖子编号
//	 * @return
//	 */
//	public int changePostHot(String postNo);
	/**
	 * 设置精品贴
	 * @param postNo 帖子编号
	 * @return
	 */
	public int changePostWell(String postNo);
	/**
	 * 设置普通贴
	 * @param postNo
	 * @return
	 */
	public int changePostCommon(String postNo);
	
	
	//帖子审核
	/**
	 * 申精帖子通过审核
	 * @param postNo
	 * @return
	 */
	public int passPost(String postNo);
	/**
	 * 否决申精帖子
	 * @param postNo
	 * @return
	 */
	public int failPost(String postNo);
	
	
	//帖子申精
	/**
	 * 申精帖子通过审核
	 * @param postNo
	 * @return
	 */
	public int wellPostApply(String postNo);
	/**
	 * 否决申精帖子
	 * @param postNo
	 * @return
	 */
	public int cancelWellPostApply(String postNo);
	
}
