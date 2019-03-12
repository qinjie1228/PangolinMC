package com.plmc.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plmc.common.Page;
import com.plmc.dao.CommentDao;
import com.plmc.dao.PostDao;
import com.plmc.dao.UserDao;
import com.plmc.dto.CommentDto;
import com.plmc.dto.PostDto;
import com.plmc.service.CommentService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.entity.Comment;
import com.plmc.vo.entity.Post;
import com.plmc.vo.entity.User;

@Service
public class CommentServiceImpl extends ServiceConstantUtil implements CommentService {

	@Autowired 
	private CommentDao commentDao;
	
	@Autowired 
	private UserDao userDao;
	
	@Autowired 
	private PostDao postDao;
	
	@Override
	public int addComment(CommentDto commentDto) {
		Post post = postDao.getById(Post.class, commentDto.getPostNo());
		post.setPostCommentNum(post.getPostCommentNum() + 1);
		postDao.update(post);
		
		Comment comment = new Comment();
		comment.setPostNo(commentDto.getPostNo());
		comment.setUserNo(commentDto.getUserNo());
		comment.setCommentContent(commentDto.getCommentContent());
		comment.setCommentPubTime(new Date());
		comment.setCommentState(Integer.parseInt(commentDto.getCommentState()));
		return commentDao.save(comment);
	}

	@Override
	public int deleteComment(String commentNo) {
		Post post = postDao.getById(Post.class, commentDao.getById(Comment.class, commentNo).getPostNo());
		post.setPostCommentNum(post.getPostCommentNum() - 1);
		postDao.update(post);
		
		return this.changeState(commentNo, COMMENT_OVERDUE_STATE);
	}

	@Override
	public int deleteCommentReally(String commentNo) {
		return commentDao.deleteById(Comment.class, commentNo);
	}

	@Override
	public int recoverComment(String commentNo) {
		Post post = postDao.getById(Post.class, commentDao.getById(Comment.class, commentNo).getPostNo());
		post.setPostCommentNum(post.getPostCommentNum() + 1);
		postDao.update(post);
		
		return this.changeState(commentNo, COMMENT_PUBLISHED_STATE);
	}

	@Override
	public CommentDto findByCommentNo(String commentNo) throws ParseException {
		return this.entityToDto(commentDao.getById(Comment.class, commentNo));
	}

	@Override
	public Page<CommentDto> findCommentPage(Page<CommentDto> dtoPage, String[] attrs, Object[] values) throws ParseException {
		Page<Comment> commentPage = new Page<Comment>();
		commentPage.setPage(dtoPage.getPage());
		commentPage.setPageSize(dtoPage.getPageSize());
		
		commentPage = commentDao.pageSelect(Comment.class, commentPage, attrs, values);

		Page<CommentDto> page = new Page<CommentDto>();
		page.setPage(commentPage.getPage());
		page.setOrder(commentPage.getOrder());
		page.setPageSize(commentPage.getPageSize());
		page.setSort(commentPage.getSort());
		page.setTotal(commentPage.getTotal());
		page.setPageCount(commentPage.getPageCount());
		List<Comment> commentPageDate = commentPage.getData();
		int pageDateSize = commentPageDate.size();
		if(pageDateSize <= 0){
			return page;
		}
		else{
			List<CommentDto> pageDate = new ArrayList<CommentDto>();
			for(int i=0; i<pageDateSize; i++){
				pageDate.add(this.entityToDto(commentPageDate.get(i)));
			}
			page.setData(pageDate);
			return page;
		}
	}
	

	@Override
	public List<CommentDto> findComment(String[] attrs, Object[] values) throws ParseException {
		List<CommentDto> listDto = new ArrayList<CommentDto>(); 
		List<Comment> listEntity = commentDao.selectList(Comment.class, attrs, values);
		if(listEntity.size() > 0){
			for(int i=0; i<listEntity.size(); i++ ){
				CommentDto dto = this.entityToDto(listEntity.get(i));
				listDto.add(dto);
			}
		}
		return listDto;
	}
	
	//**************私有方法 开始**************//
	private CommentDto entityToDto(Comment comment) throws ParseException{
		CommentDto commentDto = new CommentDto();
		commentDto.setCommentNo(comment.getCommentNo());
		commentDto.setPostNo(comment.getPostNo());
		commentDto.setUserNo(comment.getUserNo());
		commentDto.setCommentContent(comment.getCommentContent());
		commentDto.setCommentPubTime(ThreadLocalDateUtil.formatDate(comment.getCommentPubTime()));
		commentDto.setCommentState(String.valueOf(comment.getCommentState()));
		commentDto.setPostTitle(postDao.getById(Post.class, comment.getPostNo()).getPostTitle());
		commentDto.setUserName(userDao.getUserNameByUserNo(comment.getUserNo()));
		return commentDto;
	}
	
	private Comment clearComment(Comment comment){
		comment.setPostNo("");
		comment.setUserNo("");
		comment.setCommentContent("");
		comment.setCommentPubTime(null);
		comment.setCommentState(-1);
		return comment;
	}
	
	private int changeState(String commentNo, int state){
		Comment comment = commentDao.getById(Comment.class, commentNo);
		if(comment == null){
			return -1;
		}
		else{
			comment = this.clearComment(comment);
			comment.setCommentState(state);
			return commentDao.update(comment);
		}
	}
	//**************私有方法 结束**************//

}
