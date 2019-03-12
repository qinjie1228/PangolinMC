package com.plmc.controller;

import java.text.ParseException;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.plmc.dto.OrderDto;
import com.plmc.dto.PictureDto;
import com.plmc.service.ActService;
import com.plmc.service.OrderService;
import com.plmc.service.PicService;
import com.plmc.service.PostService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.session.CurrentUser;

@RequestMapping("/index")
@Controller
public class IndexController extends ControllerConstantUtil {
	
	@Autowired
	private ActService actService;
	
	@Autowired
	private PostService postService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private PicService picService;
	/**
	 * 跳转到首页
	 * 访问路径 项目/index/toIndex.do
	 * @return
	 */
	@RequestMapping(value = "/toIndex", method = RequestMethod.GET)
	public ModelAndView toIndex(HttpSession session) {
		ModelAndView userModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser)session.getAttribute(CURRENT_USER);
		if(currentUser != null){
			userModel.addObject(CURRENT_USER, currentUser);
		}
		userModel.setViewName("index");
		return userModel;
	}
	
	/**
	 * 跳转到注册页面
	 * 访问路径 项目/index/toRegister.do
	 * @return
	 */
	@RequestMapping(value = "/toRegister", method = RequestMethod.GET)
	public ModelAndView toRegister(HttpSession session) {
		ModelAndView userModel = new ModelAndView();
		userModel.setViewName("page/forehead/register");
		return userModel;
	}
	
	/**
	 * 跳转到首页公告
	 * 访问路径 项目/index/toIndexNotice.do
	 * @return
	 */
	@RequestMapping(value = "/toIndexNotice", method = RequestMethod.GET)
	public ModelAndView toIndexNotice() {
		ModelAndView model = new ModelAndView();
		model.setViewName("page/forehead/index-notice");
		return model;
	}
	
	/**
	 * 跳转到首页活动
	 * 访问路径 项目/index/toIndexAct.do
	 * @return
	 */
	@RequestMapping(value = "/toIndexAct", method = RequestMethod.GET)
	public ModelAndView toIndexAct() {
		return this.getModelAndView("index-act");
	}
	
	/**
	 * 跳转到首页道具
	 * 访问路径 项目/index/toIndexTool.do
	 * @return
	 */
	@RequestMapping(value = "/toIndexTool", method = RequestMethod.GET)
	public ModelAndView toIndexTool() {
		return this.getModelAndView("index-tool");
	}
	
	/**
	 * 跳转到首页论坛
	 * 访问路径 项目/index/toIndexPost.do
	 * @return
	 */
	@RequestMapping(value = "/toIndexPost", method = RequestMethod.GET)
	public ModelAndView toIndexPost() {
		return this.getModelAndView("index-post");
	}
	
	/**
	 * 跳转到首页图库
	 * 访问路径 项目/index/toIndexPic.do
	 * @return
	 */
	@RequestMapping(value = "/toIndexPic", method = RequestMethod.GET)
	public ModelAndView toIndexPic() {
		return this.getModelAndView("index-pic");
	}
	
	/**
	 * 跳转到首页我的
	 * 访问路径 项目/index/toIndexMy.do
	 * @return
	 */
	@RequestMapping(value = "/toIndexMy", method = RequestMethod.GET)
	public ModelAndView toIndexMy() {
		return this.getModelAndView("index-my");
	}
	
	/**
	 * 跳转到首页关于我们
	 * 访问路径 项目/index/toIndexAboutus.do
	 * @return
	 */
	@RequestMapping(value = "/toIndexAboutus", method = RequestMethod.GET)
	public ModelAndView toIndexAboutus() {
		ModelAndView model = new ModelAndView();
		model.setViewName("page/forehead/index-aboutus");
		return model;
	}
	
	/**
	 * 跳转到首页个人中心主页
	 * @return
	 */
	@RequestMapping(value = "/toMyMain", method = RequestMethod.GET)
	public ModelAndView toMyMain() {
		return this.getModelAndView("mypage/my-main");
	}
	
	/**
	 * 跳转到首页个人中心添加活动
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/toAddAct", method = RequestMethod.GET)
	public ModelAndView toAddAct(@RequestParam(value="actNo", required=false) String actNo) throws ParseException {
		if(actNo ==null){
			return this.getModelAndView("mypage/add-act");
		}
		ModelAndView model = this.getModelAndView("mypage/act-detail");
		model.addObject("act", actService.findByActNo(actNo));
		return model;
	}
	
	/**
	 * 跳转到首页个人中心添加帖子
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/toAddPost", method = RequestMethod.GET)
	public ModelAndView toAddPost(@RequestParam(value="postNo", required=false) String postNo) throws ParseException {
		if(postNo ==null){
			return this.getModelAndView("mypage/add-post");
		}
		ModelAndView model = this.getModelAndView("mypage/post-detail");
		model.addObject("post", postService.findByPostNo(postNo));
		return model;
	}
	
	/**
	 * 跳转到首页个人中心修改照片
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/toAlertPic", method = RequestMethod.GET)
	public ModelAndView toAlertPic(@RequestParam(value="picNo", required=false) String picNo) throws ParseException {
		if(picNo ==null){
			return this.getModelAndView("mypage/add-pic");
		}
		ModelAndView model = this.getModelAndView("mypage/pic-detail");
		model.addObject(PIC_ONE, picService.findByPictureNo(picNo));
		return model;
	}
	
	/**
	 * 跳转到首页个人中心订单编辑
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/toOrderDetail", method = RequestMethod.GET)
	public ModelAndView toOrderDetail(@RequestParam(value="orderNo", required=false) String orderNo) throws ParseException {
		if(orderNo ==null){
			return this.getModelAndView("mypage/order-detail");
		}
		ModelAndView model = this.getModelAndView("mypage/order-detail");
		model.addObject("order", orderService.findByOrderNo(orderNo));
		return model;
	}
	
	@RequestMapping(value = "/toPayOrder", method = RequestMethod.GET)
	public ModelAndView toPayOrder(String orderNo) throws ParseException {
		OrderDto orderDto = orderService.findByOrderNo(orderNo);
		orderDto.setOrderState(String.valueOf(ORDER_CART_CONFIRM_STATE));
		orderDto.setOrderMakeTime(ThreadLocalDateUtil.formatDate(new Date()));
		orderDto.setOrderPrice(String.valueOf(orderService.addOrderPrice(orderNo)));
		orderService.alterOrder(orderDto);
		
		ModelAndView model = this.getModelAndView("mypage/order-detail");
		model.addObject("order", orderDto);
		return model;
	}
	
	/**
	 * 根据路径取得ModelAndView
	 * @param url
	 * @return
	 */
	private ModelAndView getModelAndView(String url){
		HttpSession session =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession(); 
		ModelAndView userModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser)session.getAttribute(CURRENT_USER);
		if(currentUser != null){
			userModel.addObject(CURRENT_USER, currentUser);
			userModel.setViewName("page/forehead/" + url);
		}
		else{
			userModel.setViewName("index");
		}
		return userModel;
	}
}
