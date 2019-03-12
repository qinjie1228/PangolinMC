package com.plmc.controller;

import java.text.ParseException;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.plmc.common.Page;
import com.plmc.dto.CommentDto;
import com.plmc.dto.NoticeDto;
import com.plmc.dto.PostDto;
import com.plmc.service.CommentService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.vo.session.CurrentUser;

@RequestMapping("/comment")
@Controller
public class CommentController extends ControllerConstantUtil {
	
	@Autowired  
	private CommentService commentService;

	@RequestMapping(value = "/toGetAllComment", method = RequestMethod.GET)
	public ModelAndView toGetAllComment(HttpSession session,
			@RequestParam("commentState") String commentState, String url) {
		ModelAndView commentModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		commentModel.addObject(CURRENT_USER, currentUser);
		commentModel.addObject(COMMENT_STATE, commentState);
		commentModel.setViewName(url);
		return commentModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/doGetAllComment")
	public Page<CommentDto> doGetAllComment(int pageNow, int pageSize, int commentState) throws ParseException {
		Page<CommentDto> page =new Page<CommentDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"commentState"};
		Object[] values = {commentState};
		page = commentService.findCommentPage(page, attrs, values);
		return page;
	}
	
	
	@ResponseBody
	@RequestMapping("/findCommentByCommentNo")
	public CommentDto findCommentByCommentNo(String commentNo) throws ParseException{
		CommentDto commentDto = commentService.findByCommentNo(commentNo);
		return commentDto;
	}

	
	@RequestMapping("/findCommentByCommentNoIndexMy")
	public ModelAndView findCommentByCommentNoIndexMy(String commentNo) throws ParseException{
		ModelAndView model = new ModelAndView();
		CommentDto commentDto = commentService.findByCommentNo(commentNo);
		model.addObject(COMMENT_ONE, commentDto);
		model.setViewName("page/forehead/mypage/comment-look");
		return model;
	}
	
	
	@ResponseBody
	@RequestMapping("/getCommentCondition")
	public Page<CommentDto> getCommentCondition(int pageNow, int pageSize, CommentDto dto, int commentState, String searchStartTime, String searchEndTime) throws ParseException {
		Page<CommentDto> page =new Page<CommentDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"userName","postTitle","commentContent","timeStart","timeEnd","commentState"};
		Object[] values = {dto.getUserName(),dto.getPostTitle(),dto.getCommentContent(),searchStartTime,searchEndTime,commentState};
		page = commentService.findCommentPage(page, attrs, values);
		return page;
	}

	
	@ResponseBody
	@RequestMapping(value = "/addComment", method = RequestMethod.POST)
	public HashMap<String, Object> addUser(
			@ModelAttribute("commentDto") CommentDto commentDto){
		HashMap<String, Object> commentModel =new HashMap<String, Object>();
		commentDto.setCommentState(String.valueOf(COMMENT_PUBLISHED_STATE));
		int result = commentService.addComment(commentDto);
		if(1 == result){
			commentModel.put("addMsg", "评论成功！");
			commentModel.put("addState", 1);
		}
		else{
			commentModel.put("addMsg", "评论失败！");
			commentModel.put("addState", 0);
		}
		return commentModel;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/overdueComment")
	public Model overdueComment(Model model, String commentNo){
		int result = commentService.deleteComment(commentNo);
		if(1==result){
			model.addAttribute("overdueMsg","评语状态已变更为过期状态！");
			model.addAttribute("overdueState",1);
		}
		else{
			model.addAttribute("overdueMsg","评语过期处理失败！");
			model.addAttribute("overdueState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/deleteComment")
	public Model deleteComment(Model model, String commentNo){
		int result = commentService.deleteCommentReally(commentNo);
		if(1==result){
			model.addAttribute("deleteMsg","已彻底删除评语！");
			model.addAttribute("deleteState",1);
		}
		else{
			model.addAttribute("deleteMsg","删除评语失败！");
			model.addAttribute("deleteMsg",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/recoverComment")
	public Model recoverComment(Model model, String commentNo){
		int result = commentService.recoverComment(commentNo);
		if(1==result){
			model.addAttribute("recoverMsg","已恢复评语至已发布状态！");
			model.addAttribute("recoverState",1);
		}
		else{
			model.addAttribute("recoverMsg","恢复评语失败！");
			model.addAttribute("recoverMsg",0);
		}
		return model;
		
	}
	
	
}
