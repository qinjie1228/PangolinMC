package com.plmc.controller;


import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.plmc.common.Page;
import com.plmc.dto.MactDto;
import com.plmc.dto.OrderDto;
import com.plmc.service.MactService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.vo.session.CurrentUser;

@RequestMapping("/mact")
@Controller
public class MactController extends ControllerConstantUtil {

	@Autowired  
	private MactService mactService;
	
	
	@RequestMapping(value = "/toGetAllMact", method = RequestMethod.GET)
	public ModelAndView toGetAllMact(HttpSession session,
			@RequestParam("actResState") String actResState, String url) {
		ModelAndView mactModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		mactModel.addObject(CURRENT_USER, currentUser);
		mactModel.addObject(ACT_RES_STATE, actResState);
		mactModel.setViewName(url);
		return mactModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/doGetAllMact")
	public Page<MactDto> doGetAllAct(int pageNow, int pageSize, int actResState) throws ParseException {
		Page<MactDto> page =new Page<MactDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"actResState"};
		Object[] values = {actResState};
		page = mactService.findMactPage(page, attrs, values);
		return page;
	}
	
	
	@ResponseBody
	@RequestMapping("/getMactCondition")
	public Page<MactDto> getMactCondition(int pageNow, int pageSize, MactDto dto, int actResState, String searchStartTime, String searchEndTime) throws ParseException {
		Page<MactDto> page =new Page<MactDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"actTitle","userName","timeBefore","timeAfter","actResState"};
		Object[] values = {dto.getActTitle(),dto.getUserName(),searchStartTime,searchEndTime,actResState};
		page = mactService.findMactPage(page, attrs, values);
		return page;
	}

	
	@ResponseBody
	@RequestMapping("/checkMact")
	public Model checkMact(Model model, String actNo, String userNo) throws ParseException{
		String[] attrsWaitingCheck = {"actNo", "userNo", "actResState"};
		Object[] valuesWaitingCheck = {actNo, userNo, MACT_WAITINGCHECK_STATE};
		List<MactDto> listWaitingCheckDto = mactService.findMact(attrsWaitingCheck, valuesWaitingCheck);
		if(listWaitingCheckDto.size() > 0){
			model.addAttribute("mactState", 1);
		}
		
		String[] attrsPassed = {"actNo", "userNo", "actResState"};
		Object[] valuesPassed = {actNo, userNo, MACT_PASSRESERVE_STATE};
		List<MactDto> listPassedDto = mactService.findMact(attrsPassed, valuesPassed);
		if(listPassedDto.size() > 0){
			model.addAttribute("mactState", 2);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/passMact")
	public Model passMact(Model model, String mactNo){
		int result = mactService.passMact(mactNo);
		if(1==result){
			model.addAttribute("passMsg","活动预约申请已通过！");
			model.addAttribute("passState",1);
		}
		else{
			model.addAttribute("passMsg","活动预约申请处理失败！");
			model.addAttribute("passState",0);
		}
		return model;
		
	}
	
	
	
	@ResponseBody
	@RequestMapping("/failMact")
	public Model failMact(Model model, String mactNo){
		int result = mactService.failMact(mactNo);
		if(1==result){
			model.addAttribute("failMsg","活动预约申请已否决！");
			model.addAttribute("failState",1);
		}
		else{
			model.addAttribute("failMsg","活动预约申请处理失败！");
			model.addAttribute("failState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/failMactAgain")
	public Model passMactAgain(Model model, String mactNo){
		int result = mactService.failMactAgain(mactNo);
		if(1==result){
			model.addAttribute("failAgainMsg","活动预约记录状态已变更为预约失败状态！");
			model.addAttribute("failAgainState",1);
		}
		else{
			model.addAttribute("failAgainMsg","活动预约记录处理失败！");
			model.addAttribute("failAgainState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/overdueMact")
	public Model overdueMact(Model model, String mactNo){
		int result = mactService.deleteMact(mactNo);
		if(1==result){
			model.addAttribute("overdueMsg","活动预约记录已过期！");
			model.addAttribute("overdueState",1);
		}
		else{
			model.addAttribute("overdueMsg","活动预约记录处理失败！");
			model.addAttribute("overdueState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/deleteMact")
	public Model deleteMact(Model model, String mactNo){
		int result = mactService.deleteMactReally(mactNo);
		if(1==result){
			model.addAttribute("deleteMsg","活动预约记录已彻底删除！");
			model.addAttribute("deleteState",1);
		}
		else{
			model.addAttribute("deleteMsg","删除失败！");
			model.addAttribute("deleteState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/recoverMact")
	public Model recoverMact(Model model, String mactNo){
		int result = mactService.recoverMact(mactNo);
		if(1==result){
			model.addAttribute("recoverMsg","活动预约记录已恢复至成功预约状态！");
			model.addAttribute("recoverState",1);
		}
		else{
			model.addAttribute("recoverMsg","恢复失败！");
			model.addAttribute("recoverState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/resAct")
	public Model resAct(Model model, HttpSession session, String actNo, String userNo) throws ParseException{
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		int userState = currentUser.getCurrentState();
		int result = -1;
		if(userState == 4 || userState == 5){
			result = mactService.mactRes(actNo, userNo);
			if (1 == result) {
				model.addAttribute("mactState", 2);
			}
		}
		else{
			result = mactService.mactApply(actNo, userNo);
			if (1 == result) {
				model.addAttribute("mactState", 1);
			} 
		}
		if (-1 == result) {
			model.addAttribute("mactState", 0);
		}
		return model;
	}
	
	
	@ResponseBody
	@RequestMapping("/cancelRes")
	public Model cancelRes(Model model, String actNo, String userNo) throws ParseException{
		String[] attrs = {"actNo", "userNo"};
		Object[] values = {actNo, userNo};
		int result = mactService.cancelMactRes(mactService.findMact(attrs, values).get(0).getMactNo());
		if (1 == result) {
			model.addAttribute("mactMsg", "取消活动预约成功！");
			model.addAttribute("mactState", 1);
		} else {
			model.addAttribute("mactMsg", "取消活动预约失败！");
			model.addAttribute("mactState", 0);
		}
		return model;
	}
	
	
	@ResponseBody
	@RequestMapping("/cancelApply")
	public Model cancelApply(Model model, String actNo, String userNo) throws ParseException{
		String[] attrs = {"actNo", "userNo"};
		Object[] values = {actNo, userNo};
		int result = mactService.cancelMactRes(mactService.findMact(attrs, values).get(0).getMactNo());
		if (1 == result) {
			model.addAttribute("mactMsg", "取消活动预约申请成功！");
			model.addAttribute("mactState", 1);
		} else {
			model.addAttribute("mactMsg", "取消活动预约申请失败！");
			model.addAttribute("mactState", 0);
		}
		return model;
	}
	
	
	
}
