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
import com.plmc.dao.PostDao;
import com.plmc.dao.UserDao;
import com.plmc.dto.ActDto;
import com.plmc.dto.PostDto;
import com.plmc.service.PostService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.entity.Act;
import com.plmc.vo.entity.Post;
import com.plmc.vo.entity.User;

@Service
public class PostServiceImpl extends ServiceConstantUtil implements PostService {

	@Autowired 
	private PostDao postDao;
	
	@Autowired 
	private UserDao userDao;

	@Override
	public int addPost(PostDto postDto) {
		Post post = new Post();
		post.setUserNo(postDto.getUserNo());
		post.setPostCategory(postDto.getPostCategory());
		post.setPostTitle(postDto.getPostTitle());
		post.setPostContent(postDto.getPostContent());
		post.setPostPic(postDto.getPostPic());
		post.setPostPubTime(new Date());
		post.setPostScanNum(Integer.parseInt(postDto.getPostScanNum()));
		post.setPostCommentNum(Integer.parseInt(postDto.getPostCommentNum()));
		post.setPostState(Integer.parseInt(postDto.getPostState()));
		return postDao.save(post);
	}

	@Override
	public int deletePost(String postNo) {
		return this.changeState(postNo, POST_OVERDUE_STATE);
	}

	@Override
	public int deletePostReally(String postNo) {
		return postDao.deleteById(Post.class, postNo);
	}

	@Override
	public int recoverPost(String postNo) {
		return this.changeState(postNo, POST_COMMON_STATE);
	}

	@Override
	public int alterPost(PostDto postDto) throws ParseException {
		Post post = postDao.getById(Post.class, postDto.getPostNo());
		Post postUpdate = this.clearPost(postDao.getById(Post.class, postDto.getPostNo()));
		
		if(postDto.getUserNo() != null && postDto.getUserNo() !=""){
			if(!postDto.getUserNo().equals(post.getUserNo())){
				postUpdate.setUserNo(postDto.getUserNo());
			}
		}
		if(postDto.getPostCategory() != null && postDto.getPostCategory() !=""){
			if(!postDto.getPostCategory().equals(post.getPostCategory())){
				postUpdate.setPostCategory(postDto.getPostCategory());
			}
		}
		if(postDto.getPostTitle() != null && postDto.getPostTitle() !=""){
			if(!postDto.getPostTitle().equals(post.getPostTitle())){
				postUpdate.setPostTitle(postDto.getPostTitle());
			}
		}
		if(postDto.getPostContent() != null && postDto.getPostContent() !=""){
			if(!postDto.getPostContent().equals(post.getPostContent())){
				postUpdate.setPostContent(postDto.getPostContent());
			}
		}
		if(postDto.getPostPic() != null && postDto.getPostPic() !=""){
			if(!postDto.getPostPic().equals(post.getPostPic())){
				postUpdate.setPostPic(postDto.getPostPic());
			}
		}
		if(postDto.getPostPubTime() != null && postDto.getPostPubTime() !=""){
			if(!postDto.getPostPubTime().equals(ThreadLocalDateUtil.formatDate(post.getPostPubTime()))){
				postUpdate.setPostPubTime(ThreadLocalDateUtil.parse(postDto.getPostPubTime()));
			}
		}
		if(postDto.getPostScanNum() != null && postDto.getPostScanNum() !=""){
			if(!postDto.getPostScanNum().equals(String.valueOf(post.getPostScanNum()))){
				postUpdate.setPostScanNum(Integer.parseInt(postDto.getPostScanNum()));
			}
		}
		if(postDto.getPostCommentNum() != null && postDto.getPostCommentNum() !=""){
			if(!postDto.getPostCommentNum().equals(String.valueOf(post.getPostCommentNum()))){
				postUpdate.setPostCommentNum(Integer.parseInt(postDto.getPostCommentNum()));
			}
		}
		if(postDto.getPostState() != null && postDto.getPostState() !=""){
			if(!postDto.getPostState().equals(String.valueOf(post.getPostState()))){
				postUpdate.setPostState(Integer.parseInt(postDto.getPostState()));
			}
		}
		return postDao.update(postUpdate);
	}

	@Override
	public PostDto findByPostNo(String postNo) throws ParseException {
		return this.entityToDto(postDao.getById(Post.class, postNo));
	}

	@Override
	public Page<PostDto> findPostPage(Page<PostDto> dtoPage, String[] attrs, Object[] values) throws ParseException {
		Page<Post> postPage = new Page<Post>();
		postPage.setPage(dtoPage.getPage());
		postPage.setPageSize(dtoPage.getPageSize());
		
		postPage = postDao.pageSelect(Post.class, postPage, attrs, values);

		Page<PostDto> page = new Page<PostDto>();
		page.setPage(postPage.getPage());
		page.setOrder(postPage.getOrder());
		page.setPageSize(postPage.getPageSize());
		page.setSort(postPage.getSort());
		page.setTotal(postPage.getTotal());
		page.setPageCount(postPage.getPageCount());
		List<Post> postPageDate = postPage.getData();
		int pageDateSize = postPageDate.size();
		if(pageDateSize <= 0){
			return page;
		}
		else{
			List<PostDto> pageDate = new ArrayList<PostDto>();
			for(int i=0; i<pageDateSize; i++){
				pageDate.add(this.entityToDto(postPageDate.get(i)));
			}
			page.setData(pageDate);
			return page;
		}
	}

	@Override
	public int changePostTop(String postNo) {
		return this.changeState(postNo, POST_TOP_STATE);
	}

//	@Override
//	public int changePostHot(String postNo) {
//		return this.changeState(postNo, POST_HOT_STATE);
//	}

	@Override
	public int changePostWell(String postNo) {
		return this.changeState(postNo, POST_WELLCHOSEN_STATE);
	}

	@Override
	public int changePostCommon(String postNo) {
		return this.changeState(postNo, POST_COMMON_STATE);
	}

	@Override
	public int passPost(String postNo) {
		return this.changeState(postNo, POST_WELLCHOSEN_STATE);
	}

	@Override
	public int failPost(String postNo) {
		return this.changeState(postNo, POST_COMMON_STATE);
	}

	@Override
	public int wellPostApply(String postNo) {
		return this.changeState(postNo, POST_WAITINGCHECK_STATE);
	}

	@Override
	public int cancelWellPostApply(String postNo) {
		return this.changeState(postNo, POST_COMMON_STATE);
	}

	@Override
	public int countPost(String[] attrs, Object[] values) {
		return postDao.pageCount(Post.class, attrs, values);
	}

	@Override
	public List<PostDto> findPost(String[] attrs, Object[] values) throws ParseException {
		List<PostDto> listDto = new ArrayList<PostDto>(); 
		List<Post> listEntity = postDao.selectList(Post.class, attrs, values);
		for(int i=0; i<listEntity.size(); i++ ){
			PostDto dto = this.entityToDto(listEntity.get(i));
			listDto.add(dto);
		}
		return listDto;
	}

	
	//**************私有方法 开始**************//
	private PostDto entityToDto(Post post) throws ParseException{
		PostDto postDto = new PostDto();
		postDto.setPostNo(post.getPostNo());
		postDto.setUserNo(post.getUserNo());
		postDto.setPostCategory(post.getPostCategory());
		postDto.setPostTitle(post.getPostTitle());
		postDto.setPostContent(post.getPostContent());
		postDto.setPostPic(post.getPostPic());
		postDto.setPostPubTime(ThreadLocalDateUtil.formatDate(post.getPostPubTime()));
		postDto.setPostScanNum(String.valueOf(post.getPostScanNum()));
		postDto.setPostCommentNum(String.valueOf(post.getPostCommentNum()));
		postDto.setPostState(String.valueOf(post.getPostState()));
		postDto.setUserName(userDao.getById(User.class, post.getUserNo()).getUserName());
		return postDto;
	}
	
	private Post clearPost(Post post){
		post.setUserNo("");
		post.setPostCategory("");
		post.setPostTitle("");
		post.setPostContent("");
		post.setPostPic("");
		post.setPostPubTime(null);
		post.setPostScanNum(-1);
		post.setPostCommentNum(-1);
		post.setPostState(-1);
		return post;
	}
	
	private int changeState(String postNo, int state){
		Post post = postDao.getById(Post.class, postNo);
		if(post == null){
			return -1;
		}
		else{
			post = this.clearPost(post);
			post.setPostState(state);
			return postDao.update(post);
		}
	}
	
	//**************私有方法 结束**************//
}
