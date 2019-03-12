package com.plmc.controller;

import java.text.ParseException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.plmc.common.Page;
import com.plmc.dto.ActDto;
import com.plmc.dto.NoticeDto;
import com.plmc.service.NoticeService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.vo.session.CurrentUser;

@RequestMapping("/notice")
@Controller
public class NoticeController extends ControllerConstantUtil {
	
	@Resource(name = "noticeServiceImpl")
	private NoticeService noticeService;

	@RequestMapping(value = "/toGetAllNotice", method = RequestMethod.GET)
	public ModelAndView toGetAllNotice(HttpSession session,
			@RequestParam("noticeState") String noticeState) {
		ModelAndView actModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		actModel.addObject(CURRENT_USER, currentUser);
		actModel.addObject(NOTICE_STATE, noticeState);
		actModel.setViewName("page/background/notice-list");
		return actModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/doGetAllNotice")
	public Page<NoticeDto> doGetAllNotice(int pageNow, int pageSize, int noticeState) throws ParseException {
		Page<NoticeDto> page =new Page<NoticeDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"noticeState"};
		Object[] values = {noticeState};
		page = noticeService.findNoticePage(page, attrs, values);
		return page;
	}

	
	@ResponseBody
	@RequestMapping("/getNoticeCondition")
	public Page<NoticeDto> getNoticeCondition(int pageNow, int pageSize, NoticeDto dto, int noticeState, String searchStartTime, String searchEndTime) throws ParseException {
		Page<NoticeDto> page =new Page<NoticeDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"userName","noticeTitle","timeStart","timeEnd","noticeState"};
		Object[] values = {dto.getUserName(),dto.getNoticeTitle(),searchStartTime,searchEndTime,noticeState};
		page = noticeService.findNoticePage(page, attrs, values);
		return page;
	}

	@ResponseBody
	@RequestMapping("/findNoticeByNoticeNo")
	public NoticeDto findNoticeByNoticeNo(String noticeNo) throws ParseException{
		NoticeDto noticeDto = noticeService.findByNoticeNo(noticeNo);
		return noticeDto;
	}
	
	
	@RequestMapping("/findNoticeIndexByNoticeNo")
	public ModelAndView findNoticeIndexByNoticeNo(String noticeNo) throws ParseException{
		ModelAndView noticeModel = new ModelAndView();
//		HttpSession session =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession(); 
//		CurrentUser currentUser = (CurrentUser)session.getAttribute(CURRENT_USER);
//		if(currentUser != null){
//			userModel.addObject(CURRENT_USER, currentUser);
//		}
		NoticeDto notice = noticeService.findByNoticeNo(noticeNo);
		noticeModel.addObject(NOTICE_ONE, notice);
		noticeModel.setViewName("page/forehead/pageone/page-notice");
		return noticeModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/noticeIndexShow")
	public List<NoticeDto> actPicCarousel(int selectNum) throws ParseException {
		String[] attrs = {"pubTimeOrder","selectNum"};
		Object[] values = {"true",selectNum};
		return noticeService.findNotice(attrs, values);
	}

	
	@RequestMapping(value = "/addNotice", method = RequestMethod.POST)
	public ModelAndView addNotice(
			@ModelAttribute("noticeDto") NoticeDto noticeDto){
		ModelAndView noticeModel = new ModelAndView();
		noticeDto.setNoticeState(String.valueOf(NOTICE_PUBLISHED_STATE));
		noticeModel.addObject(NOTICE_STATE, noticeDto.getNoticeState());
		int result = noticeService.addNotice(noticeDto);
		if(1 == result){
			noticeModel.addObject("addMsg", "公告添加成功！");
			noticeModel.addObject("addState", 1);
		}
		else{
			noticeModel.addObject("addMsg", "公告添加失败！");
			noticeModel.addObject("addState", 0);
		}
		noticeModel.setViewName("page/background/notice-list");
		return noticeModel;
		
	}
	
	
	@RequestMapping(value = "/doAlterNotice", method = RequestMethod.POST)
	public ModelAndView doAlterNotice( 
			@ModelAttribute("noticeDto") NoticeDto noticeDto) throws ParseException{
		ModelAndView noticeModel = new ModelAndView();
		int result = noticeService.alterNotice(noticeDto);
		noticeModel.addObject(NOTICE_STATE, noticeDto.getNoticeState());
		if(1 == result){
			noticeModel.addObject("alterMsg", "公告修改成功！");
			noticeModel.addObject("alterState", 1);
		}
		else{
			noticeModel.addObject("alterMsg", "公告修改失败！");
			noticeModel.addObject("alterState", 0);
		}
		noticeModel.setViewName("page/background/notice-list");
		return noticeModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/overdueNotice")
	public Model overdueNotice(Model model, String noticeNo){
		int result = noticeService.deleteNotice(noticeNo);
		if(1==result){
			model.addAttribute("overdueMsg","公告状态已变更为过期状态！");
			model.addAttribute("overdueState",1);
		}
		else{
			model.addAttribute("overdueMsg","公告过期处理失败！");
			model.addAttribute("overdueState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/deleteNotice")
	public Model deleteNotice(Model model, String noticeNo){
		int result = noticeService.deleteNoticeReally(noticeNo);
		if(1==result){
			model.addAttribute("deleteMsg","已彻底删除公告！");
			model.addAttribute("deleteState",1);
		}
		else{
			model.addAttribute("deleteMsg","删除公告失败！");
			model.addAttribute("deleteMsg",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/recoverNotice")
	public Model recoverNotice(Model model, String noticeNo){
		int result = noticeService.recoverNotice(noticeNo);
		if(1==result){
			model.addAttribute("recoverMsg","已恢复公告至已发布状态！");
			model.addAttribute("recoverState",1);
		}
		else{
			model.addAttribute("recoverMsg","恢复公告失败！");
			model.addAttribute("recoverMsg",0);
		}
		return model;
		
	}
	
	
}
