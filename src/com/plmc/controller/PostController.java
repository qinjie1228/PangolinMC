package com.plmc.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.plmc.common.Page;
import com.plmc.dto.ActDto;
import com.plmc.dto.CommentDto;
import com.plmc.dto.NoticeDto;
import com.plmc.dto.OrderDto;
import com.plmc.dto.PostDto;
import com.plmc.service.CommentService;
import com.plmc.service.PostCountService;
import com.plmc.service.PostService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.vo.session.CurrentUser;
import com.plmc.vo.util.PostCount;
import com.plmc.vo.util.UserLogin;

@RequestMapping("/post")
@Controller
public class PostController extends ControllerConstantUtil {
	
	@Autowired 
	private PostService postService;
	
	@Autowired 
	private CommentService commentService;
	
	@Autowired 
	private PostCountService postCountService;

	@RequestMapping(value = "/toGetAllPost", method = RequestMethod.GET)
	public ModelAndView toGetAllPost(HttpSession session,
			@RequestParam("postState") String postState, String url) {
		ModelAndView postModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		postModel.addObject(CURRENT_USER, currentUser);
		postModel.addObject(POST_STATE, postState);
		postModel.setViewName(url);
		return postModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/doGetAllPost")
	public Page<PostDto> doGetAllPost(int pageNow, int pageSize, int postState) throws ParseException {
		Page<PostDto> page =new Page<PostDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"postState"};
		Object[] values = {postState};
		page = postService.findPostPage(page, attrs, values);
		return page;
	}
	
	
	@ResponseBody
	@RequestMapping("/doGetAllPostCommon")
	public Page<PostDto> doGetAllPostCommon(int pageNow, int pageSize) throws ParseException {
		Page<PostDto> page =new Page<PostDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"commonFlag"};
		Object[] values = {"true"};
		page = postService.findPostPage(page, attrs, values);
		return page;
	}
	
	
	@ResponseBody
	@RequestMapping("/doGetAllPostWellChosen")
	public Page<PostDto> doGetAllPostWellChosen(int pageNow, int pageSize) throws ParseException {
		Page<PostDto> page =new Page<PostDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"wellChosenFlag"};
		Object[] values = {"true"};
		page = postService.findPostPage(page, attrs, values);
		return page;
	}

	
	@ResponseBody
	@RequestMapping("/postNewIndexShow")
	public List<PostDto> postNewIndexShow(int selectNum) throws ParseException {
		String[] attrs = {"pubTimeOrder", "selectNum"};
		Object[] values = {"true", selectNum};
		return postService.findPost(attrs, values);
	}
	
	
	@ResponseBody
	@RequestMapping("/postWellIndexShow")
	public List<PostDto> postWellIndexShow(int selectNum) throws ParseException {
		String[] attrs = {"pubTimeOrder", "selectNum", "postState"};
		Object[] values = {"true", selectNum, POST_WELLCHOSEN_STATE};
		return postService.findPost(attrs, values);
	}
	
	
	@ResponseBody
	@RequestMapping("/postHotIndexShow")
	public List<PostDto> postHotIndexShow(int selectNum) throws ParseException {
		String[] attrs = {"numOrder", "selectNum"};
		Object[] values = {"true", selectNum};
		return postService.findPost(attrs, values);
	}
	
	
	@ResponseBody
	@RequestMapping("/getPostCondition")
	public Page<PostDto> getPostCondition(int pageNow, int pageSize, PostDto dto, int postState, String searchStartTime, String searchEndTime) throws ParseException {
		Page<PostDto> page =new Page<PostDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"userName","postTitle","postCategory","postScanNum","postCommentNum","timeStart","timeEnd","postState"};
		Object[] values = {dto.getUserName(),dto.getPostTitle(),dto.getPostCategory(),dto.getPostScanNum().equals("") ?  null : Integer.parseInt(dto.getPostScanNum()),dto.getPostCommentNum().equals("") ?  null : Integer.parseInt(dto.getPostCommentNum()),searchStartTime,searchEndTime,postState};
		page = postService.findPostPage(page, attrs, values);
		return page;
	}

	
	@ResponseBody
	@RequestMapping("/findPostByPostNo")
	public PostDto findPostByPostNo(String postNo) throws ParseException{
		PostDto postDto = postService.findByPostNo(postNo);
		return postDto;
	}
	
	
	@RequestMapping("/findPostByPostNoIndexMy")
	public ModelAndView findPostByPostNoIndexMy(String postNo) throws ParseException{
		ModelAndView model = new ModelAndView();
		PostDto postDto = postService.findByPostNo(postNo);
		model.addObject(POST_ONE, postDto);
		model.setViewName("page/forehead/mypage/post-look");
		return model;
	}
	
	
	@RequestMapping("/findPostIndexByPostNo")
	public ModelAndView findPostIndexByPostNo(String postNo) throws ParseException{
		HttpSession session =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		ModelAndView model = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		if(currentUser != null){
			model.addObject(CURRENT_USER, currentUser);
			
			String[] attrs = {"userNo", "postNo"};
			Object[] values = {currentUser.getCurrentNo(), postNo};
			List<PostCount> postCountList = postCountService.findPostCount(attrs, values);
			if(postCountList.size() == 0){
				postCountService.addPostScanNum(new PostCount(currentUser.getCurrentNo(), postNo, this.getIpAddress(request)));
			}
		}
			
		PostDto postDto = postService.findByPostNo(postNo);
		model.addObject(POST_ONE, postDto);

		String[] attrsComment = { "pubTimeOrder", "postNo", "commentState" };
		Object[] valuesComment = { "true", postNo, COMMENT_PUBLISHED_STATE };
		List<CommentDto> commentList = commentService.findComment(attrsComment, valuesComment);
		model.addObject("commentList", commentList);

		model.setViewName("page/forehead/pageone/page-post");

		return model;
	}

	
	public String getUploadFileName(MultipartFile file) throws IOException{	
		String originalName = file.getOriginalFilename();
		int index = originalName.lastIndexOf(".");
		String suffixName = originalName.substring(index+1);		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String prefixName = sdf.format(new Date());
		String fileName = prefixName+"."+suffixName;
		String path = "D:/plmc/img/post";
		String filePath = path+"/"+fileName;
		File serverFile = new File(filePath);
		InputStream inputStream = file.getInputStream();
		if(!serverFile.exists()){
			serverFile.createNewFile();
		}
		FileOutputStream fos = new FileOutputStream(serverFile);
		byte[] b = new byte[1024];
		while(inputStream.read(b)>0){
			fos.write(b);
		}
		fos.flush();
		inputStream.close();
		fos.close();
		return fileName;
	}
	
	
	@RequestMapping(value = "/addPost", method = RequestMethod.POST)
	public ModelAndView addAct(
			@ModelAttribute("postDto") PostDto postDto, @RequestParam(value="url", required=false) String url, HttpServletRequest request) throws IOException{
		MultipartHttpServletRequest mRequest =
				(MultipartHttpServletRequest)request;
		MultipartFile file = mRequest.getFile("file");
		ModelAndView postModel = new ModelAndView();
		postModel.addObject(POST_STATE, postDto.getPostState());
		postDto.setPostPic(getUploadFileName(file));
		int result = postService.addPost(postDto);
		if(url == null){
			if(1 == result){
				postModel.addObject("addMsg", "帖子添加成功！");
				postModel.addObject("addState", 1);
			}
			else{
				postModel.addObject("addMsg", "帖子添加失败！");
				postModel.addObject("addState", 0);
			}
			postModel.setViewName("page/background/post-list");
		}
		else{
			postModel.setViewName("page/forehead/mypage/my-post");
		}
		return postModel;
		
	}
	
	
	@RequestMapping(value = "/doAlterPost", method = RequestMethod.POST)
	public ModelAndView doAlterPost( 
			@ModelAttribute("postDto") PostDto postDto, @RequestParam(value="url", required=false) String url, HttpServletRequest request) throws IOException, ParseException{
		ModelAndView postModel = new ModelAndView();
		
		if(postDto.getPostPic().equals("success")){
			MultipartHttpServletRequest mRequest =
					(MultipartHttpServletRequest)request;
			MultipartFile file = mRequest.getFile("file");
			String flilName = getUploadFileName(file);
			File deleteFile = new File("D:/plmc/img/post/"+postService.findByPostNo(postDto.getPostNo()).getPostPic());
			deleteFile.delete();
			postDto.setPostPic(flilName);
		}
		else{
			postDto.setPostPic(postService.findByPostNo(postDto.getPostNo()).getPostPic());
		}
		
		postDto.setPostPubTime(postService.findByPostNo(postDto.getPostNo()).getPostPubTime());
		int result = postService.alterPost(postDto);
		postModel.addObject(POST_STATE, postDto.getPostState());
		if(url == null){
			if(1 == result){
				postModel.addObject("alterMsg", "帖子修改成功！");
				postModel.addObject("alterState", 1);
			}
			else{
				postModel.addObject("alterMsg", "帖子修改失败！");
				postModel.addObject("alterState", 0);
			}
			postModel.setViewName("page/background/post-list");
		}
		else{
			HttpSession session =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
			CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
			postModel.addObject(CURRENT_USER, currentUser);
			postModel.setViewName("page/forehead/mypage/my-post");
		}
		return postModel;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/wellPostApply")
	public Model wellPostApply(Model model, String postNo){
		int result = postService.wellPostApply(postNo);
		if(1==result){
			model.addAttribute("applyMsg","申精成功，请等待审核！");
			model.addAttribute("applyState",1);
		}
		else{
			model.addAttribute("applyMsg","申精失败！");
			model.addAttribute("applyState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/cancelWellPostApply")
	public Model cancelWellPostApply(Model model, String postNo){
		int result = postService.cancelWellPostApply(postNo);
		if(1==result){
			model.addAttribute("canceApplyMsg","取消申请成功！");
			model.addAttribute("canceApplyState",1);
		}
		else{
			model.addAttribute("canceApplyMsg","取消申请失败！");
			model.addAttribute("canceApply",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/passPost")
	public Model passPost(Model model, String postNo){
		int result = postService.passPost(postNo);
		if(1==result){
			model.addAttribute("passMsg","帖子已变为精品贴！");
			model.addAttribute("passState",1);
		}
		else{
			model.addAttribute("passMsg","精品帖子申请处理失败！");
			model.addAttribute("passState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/failPost")
	public Model failPost(Model model, String postNo){
		int result = postService.failPost(postNo);
		if(1==result){
			model.addAttribute("failMsg","精品帖子申请已否决！");
			model.addAttribute("failState",1);
		}
		else{
			model.addAttribute("failMsg","精品帖子申请处理失败！");
			model.addAttribute("failState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/overduePost")
	public Model overduePost(Model model, String postNo){
		int result = postService.deletePost(postNo);
		if(1==result){
			model.addAttribute("overdueMsg","帖子状态已变更为过期状态！");
			model.addAttribute("overdueState",1);
		}
		else{
			model.addAttribute("overdueMsg","帖子过期处理失败！");
			model.addAttribute("overdueState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/deletePost")
	public Model deletePost(Model model, String postNo){
		int result = postService.deletePostReally(postNo);
		if(1==result){
			model.addAttribute("deleteMsg","已彻底删除帖子！");
			model.addAttribute("deleteState",1);
		}
		else{
			model.addAttribute("deleteMsg","删除帖子失败！");
			model.addAttribute("deleteMsg",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/recoverPost")
	public Model recoverPost(Model model, String postNo){
		int result = postService.recoverPost(postNo);
		if(1==result){
			model.addAttribute("recoverMsg","已恢复帖子至普通帖子状态！");
			model.addAttribute("recoverState",1);
		}
		else{
			model.addAttribute("recoverMsg","恢复帖子失败！");
			model.addAttribute("recoverState",0);
		}
		return model;
		
	}
	
	
	
	@ResponseBody
	@RequestMapping("/commonPost")
	public Model commonPost(Model model, String postNo){
		int result = postService.changePostCommon(postNo);
		if(1==result){
			model.addAttribute("commonMsg","帖子已置为普通帖！");
			model.addAttribute("commonState",1);
		}
		else{
			model.addAttribute("commonMsg","操作失败！");
			model.addAttribute("commonState",0);
		}
		return model;
		
	}
	
	
//	@ResponseBody
//	@RequestMapping("/hotPost")
//	public Model hotPost(Model model, String postNo){
//		int result = postService.changePostHot(postNo);
//		if(1==result){
//			model.addAttribute("hotMsg","帖子已置为热门帖！");
//			model.addAttribute("hotState",1);
//		}
//		else{
//			model.addAttribute("hotMsg","操作失败！");
//			model.addAttribute("hotMsg",0);
//		}
//		return model;
//		
//	}
	
	
	@ResponseBody
	@RequestMapping("/topPost")
	public Model topPost(Model model, String postNo){
		int result = postService.changePostTop(postNo);
		if(1==result){
			model.addAttribute("topMsg","帖子已置为置顶帖！");
			model.addAttribute("topState",1);
		}
		else{
			model.addAttribute("topMsg","操作失败！");
			model.addAttribute("topState",0);
		}
		return model;
		
	}
		
	
	/**
	 * 获取登录用户IP地址
	 * 
	 * @param request
	 * @return
	 */
	private String getIpAddress(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if (ip.equals("0:0:0:0:0:0:0:1") || ip.equals("127.0.0.1")) {
			ip = "127.0.0.1";
		}
		return ip;
	}
}
