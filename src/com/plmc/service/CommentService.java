package com.plmc.service;

import java.text.ParseException;
import java.util.List;

import com.plmc.common.Page;
import com.plmc.dto.ActDto;
import com.plmc.dto.CommentDto;

public interface CommentService {
	
	//评语增删
	/**
	 * 新增评语（评论帖子）
	 * @param commentDto 评语对象
	 * @return
	 */
	public int addComment(CommentDto commentDto);
	/**
	 * 删除评语
	 * @param commentNo 评语编号
	 * @return
	 */
	public int deleteComment(String commentNo);
	/**
	 * 真正删除评语
	 * @param commentNo 评语编号
	 * @return
	 */
	public int deleteCommentReally(String commentNo);
	/**
	 * 恢复评语
	 * @param commentNo 评语编号
	 * @return
	 */
	public int recoverComment(String commentNo);

	
	
	//评语查询
	/**
	 * 按评语编号查询评语
	 * @param commentNo 评语编号
	 * @return 评语对象
	 * @throws ParseException 
	 */
	public CommentDto findByCommentNo(String commentNo) throws ParseException;
	/**
	 * 查询一页评语
	 * @param dtoPage
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException
	 */
	public Page<CommentDto> findCommentPage(Page<CommentDto> dtoPage, String[] attrs, Object[] values) throws ParseException;
	/**
	 * 取指定条件评语
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException 
	 */
	public List<CommentDto> findComment(String[] attrs, Object[] values) throws ParseException;
}
