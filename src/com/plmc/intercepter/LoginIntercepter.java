package com.plmc.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.plmc.vo.session.CurrentUser;


/**
 * 登录拦截器
 * @author Administrator
 *
 */
public class LoginIntercepter implements HandlerInterceptor{
	/**
	 * 用户已在登录状态
	 */
	public final static int LOGGED_IN = 1; 
	/**
	 * 用户未登录状态
	 */
	public final static int NOT_LOGGED_IN = 0; 
	
	/**
	 * 注册检查用户名是否重复
	 */
	public final static String TO_CHECKUSERNAME = "/PangolinMC/user/checkNameRepeat.do";
	/**
	 * 注册
	 */
	public final static String TO_REGISTER = "/PangolinMC/index/toRegister.do";
	/**
	 * 登录验证
	 */
	public final static String TO_LOGIN = "/PangolinMC/user/toLogin.do";
	/**
	 * 注销
	 */
	public final static String LOGIN_OFF = "/PangolinMC/user/logOff.do";
	/**
	 * 跳转到首页
	 */
	public final static String TO_INDEX = "/PangolinMC/index/toIndex.do";
	/**
	 * 跳转到首页公告
	 */
	public final static String TO_INDEX_NOTICE = "/PangolinMC/index/toIndexNotice.do";
	/**
	 * 跳转到首页活动
	 */
	public final static String TO_INDEX_ACT = "/PangolinMC/index/toIndexAct.do";
	/**
	 * 跳转到首页道具
	 */
	public final static String TO_INDEX_TOOL = "/PangolinMC/index/toIndexTool.do";
	/**
	 * 跳转到首页论坛
	 */
	public final static String TO_INDEX_POST = "/PangolinMC/index/toIndexPost.do";
	/**
	 * 跳转到首页图库
	 */
	public final static String TO_INDEX_PIC = "/PangolinMC/index/toIndexPic.do";
	/**
	 * 跳转到首页我的
	 */
	public final static String TO_INDEX_MY = "/PangolinMC/index/toIndexMy.do";
	/**
	 * 跳转到首页关于我们
	 */
	public final static String TO_INDEX_ABOUTUS = "/PangolinMC/index/toIndexAboutus.do";
	/**
	 * 首页图片轮播
	 */
	public final static String CAROUSEL = "/PangolinMC/act/actPicCarousel.do";
	/**
	 * 首页活动显示
	 */
	public final static String ACT_INDEX_SHOW = "/PangolinMC/act/actIndexShow.do";
	/**
	 * 首页活动链接
	 */
	public final static String ACT_INDEX_HREF = "/PangolinMC/act/findActIndexByActNo.do";
	/**
	 * 首页点击预约活动时检查是否已预约
	 */
	public final static String CHECK_MACT = "/PangolinMC/mact/checkMact.do";
	/**
	 * 首页公告显示
	 */
	public final static String NOTICE_INDEX_SHOW = "/PangolinMC/notice/noticeIndexShow.do";
	/**
	 * 首页公告链接
	 */
	public final static String NOTICE_INDEX_HREF = "/PangolinMC/notice/findNoticeIndexByNoticeNo.do";
	/**
	 * 首页道具显示
	 */
	public final static String TOOL_INDEX_SHOW = "/PangolinMC/tool/toolIndexShow.do";
	/**
	 * 首页最新帖子显示
	 */
	public final static String POST_NEW_INDEX_SHOW = "/PangolinMC/post/postNewIndexShow.do";
	/**
	 * 首页精品帖子显示
	 */
	public final static String POST_WELL_INDEX_SHOW = "/PangolinMC/post/postWellIndexShow.do";
	/**
	 * 首页热门帖子显示
	 */
	public final static String POST_HOT_INDEX_SHOW = "/PangolinMC/post/postHotIndexShow.do";
	/**
	 * 首页帖子链接
	 */
	public final static String POST_INDEX_HREF = "/PangolinMC/post/findPostIndexByPostNo.do";
	/**
	 * 首页照片显示
	 */
	public final static String PIC_INDEX_SHOW = "/PangolinMC/pic/picIndexShow.do";
	
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		HttpSession session = request.getSession();
		String url = request.getRequestURI();
		CurrentUser user = (CurrentUser) session.getAttribute("currentUser");
		
		if(TO_LOGIN.equals(url)||TO_REGISTER.equals(url)||TO_CHECKUSERNAME.equals(url)||CAROUSEL.equals(url)||NOTICE_INDEX_SHOW.equals(url)
				||NOTICE_INDEX_HREF.equals(url)||LOGIN_OFF.equals(url)||ACT_INDEX_SHOW.equals(url)||CHECK_MACT.equals(url)||TOOL_INDEX_SHOW.equals(url)
				||PIC_INDEX_SHOW.equals(url)||TO_INDEX.equals(url)||POST_NEW_INDEX_SHOW.equals(url)||POST_WELL_INDEX_SHOW.equals(url)||POST_HOT_INDEX_SHOW.equals(url)
				||POST_INDEX_HREF.equals(url)||TO_INDEX_NOTICE.equals(url)||TO_INDEX_ACT.equals(url)||TO_INDEX_TOOL.equals(url)||TO_INDEX_POST.equals(url)
				||TO_INDEX_PIC.equals(url)||TO_INDEX_MY.equals(url)||TO_INDEX_ABOUTUS.equals(url)||ACT_INDEX_HREF.equals(url)){
			return true;
		}
		
		if(user == null){
			//没有登陆的情况下，跳转到登录页面
			//获取应用的名称
			String path = request.getContextPath();
			response.sendRedirect(path+"/page/forehead/login.jsp");
			return false;
		} else {
			return true;
		}
	}
	
}
