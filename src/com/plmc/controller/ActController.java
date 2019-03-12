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
import com.plmc.dto.NoticeDto;
import com.plmc.service.ActService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.vo.session.CurrentUser;

@RequestMapping("/act")
@Controller
public class ActController extends ControllerConstantUtil {
	
	@Autowired  
	private ActService actService;

	@RequestMapping(value = "/toGetAllAct", method = RequestMethod.GET)
	public ModelAndView toGetAllAct(HttpSession session,
			@RequestParam("actState") String actState, String url) {
		ModelAndView actModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		actModel.addObject(CURRENT_USER, currentUser);
		actModel.addObject(ACT_STATE, actState);
		actModel.setViewName(url);
		return actModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/doGetAllAct")
	public Page<ActDto> doGetAllAct(int pageNow, int pageSize, int actState) throws ParseException {
		Page<ActDto> page =new Page<ActDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"actState"};
		Object[] values = {actState};
		page = actService.findActPage(page, attrs, values);
		return page;
	}

	
	@ResponseBody
	@RequestMapping("/actPicCarousel")
	public List<ActDto> actPicCarousel(int selectNum) throws ParseException {
		String[] attrs = {"numOrder", "selectNum", "actState"};
		Object[] values = {"true", selectNum, ACT_PUBLISHED_STATE};
		return actService.findAct(attrs, values);
	}
	
	
	@ResponseBody
	@RequestMapping("/actIndexShow")
	public List<ActDto> actIndexShow(int selectNum) throws ParseException {
		String[] attrs = {"pubTimeOrder", "selectNum", "actState"};
		Object[] values = {"true", selectNum, ACT_PUBLISHED_STATE};
		return actService.findAct(attrs, values);
	}
	
	
	@ResponseBody
	@RequestMapping("/getActCondition")
	public Page<ActDto> getActCondition(int pageNow, int pageSize, ActDto dto, int actState, String searchStartTime, String searchEndTime) throws ParseException {
		Page<ActDto> page =new Page<ActDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"userName","actTitle","actNum","timeBefore","timeAfter","actState"};
		Object[] values = {dto.getUserName(),dto.getActTitle(),dto.getActNum().equals("") ?  null : Integer.parseInt(dto.getActNum()),searchStartTime,searchEndTime,actState};
		page = actService.findActPage(page, attrs, values);
		return page;
	}
	

	@ResponseBody
	@RequestMapping("/findActByActNo")
	public ActDto findActByActNo(String actNo) throws ParseException{
		ActDto actDto = actService.findByActNo(actNo);
		return actDto;
	}
	
	
	@RequestMapping("/findActIndexByActNo")
	public ModelAndView findActIndexByActNo(String actNo) throws ParseException{
		ModelAndView noticeModel = new ModelAndView();
		ActDto act = actService.findByActNo(actNo);
		noticeModel.addObject(ACT_ONE, act);
		noticeModel.setViewName("page/forehead/pageone/page-act");
		return noticeModel;
	}

	
	public String getUploadFileName(MultipartFile file) throws IOException{	
		String originalName = file.getOriginalFilename();
		int index = originalName.lastIndexOf(".");
		String suffixName = originalName.substring(index+1);		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String prefixName = sdf.format(new Date());
		String fileName = prefixName+"."+suffixName;
		String path = "D:/plmc/img/act";
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
	
	
	@RequestMapping(value = "/addAct", method = RequestMethod.POST)
	public ModelAndView addAct(
			@ModelAttribute("actDto") ActDto actDto, HttpServletRequest request) throws IOException{
		MultipartHttpServletRequest mRequest =
				(MultipartHttpServletRequest)request;
		MultipartFile file = mRequest.getFile("file");
		ModelAndView actModel = new ModelAndView();
		actModel.addObject(ACT_STATE, actDto.getActState());
		actDto.setActPic(getUploadFileName(file));
		int result = actService.addAct(actDto);
		if(1 == result){
			actModel.addObject("addMsg", "活动添加成功！");
			actModel.addObject("addState", 1);
		}
		else{
			actModel.addObject("addMsg", "活动添加失败！");
			actModel.addObject("addState", 0);
		}
		actModel.setViewName("page/background/act-list");
		return actModel;
		
	}
	
	
	@RequestMapping(value = "/actApply", method = RequestMethod.POST)
	public ModelAndView actApply(
			@ModelAttribute("actDto") ActDto actDto, HttpServletRequest request) throws IOException{
		HttpSession session =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
		MultipartHttpServletRequest mRequest =
				(MultipartHttpServletRequest)request;
		MultipartFile file = mRequest.getFile("file");
		ModelAndView actModel = new ModelAndView();
		actDto.setActPic(getUploadFileName(file));
		actService.actApply(actDto);
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		actModel.addObject(CURRENT_USER, currentUser);
		if(currentUser.getCurrentState() == USER_SUPERIOR_STATE || currentUser.getCurrentState() == USER_ADMIN_STATE || currentUser.getCurrentState() == USER_ADMIN_SYSTEM_STATE){
			actModel.addObject(ACT_STATE, ACT_PUBLISHED_STATE);
		}
		else{
			actModel.addObject(ACT_STATE, ACT_WAITINGCHECK_STATE);
		}
		actModel.setViewName("page/forehead/mypage/my-act");
		return actModel;
		
	}
	
	
	@RequestMapping(value = "/doAlterAct", method = RequestMethod.POST)
	public ModelAndView doAlterAct( 
			@ModelAttribute("actDto") ActDto actDto, @RequestParam(value="url", required=false) String url, HttpServletRequest request) throws IOException, ParseException{
		ModelAndView actModel = new ModelAndView();
		
		if(actDto.getActPic().equals("success")){
			MultipartHttpServletRequest mRequest =
					(MultipartHttpServletRequest)request;
			MultipartFile file = mRequest.getFile("file");
			String flilName = getUploadFileName(file);
			File deleteFile = new File("D:/plmc/img/act/"+actService.findByActNo(actDto.getActNo()).getActPic());
			deleteFile.delete();
			actDto.setActPic(flilName);
		}
		else{
			actDto.setActPic(actService.findByActNo(actDto.getActNo()).getActPic());
		}
		
		actDto.setActPubTime(actService.findByActNo(actDto.getActNo()).getActPubTime());
		int result = actService.alterAct(actDto);
		actModel.addObject(ACT_STATE, actDto.getActState());
		if(url == null){
			if(1 == result){
				actModel.addObject("alterMsg", "活动修改成功！");
				actModel.addObject("alterState", 1);
			}
			else{
				actModel.addObject("alterMsg", "活动修改失败！");
				actModel.addObject("alterState", 0);
			}
			actModel.setViewName("page/background/act-list");
		}
		else{
			HttpSession session =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
			CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
			actModel.addObject(CURRENT_USER, currentUser);
			actModel.setViewName("page/forehead/mypage/my-act");
		}
		return actModel;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/passAct")
	public Model passAct(Model model, String actNo){
		int result = actService.passAct(actNo);
		if(1==result){
			model.addAttribute("passMsg","活动申请已通过并发布！");
			model.addAttribute("passState",1);
		}
		else{
			model.addAttribute("passMsg","活动申请处理失败！");
			model.addAttribute("passState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/failAct")
	public Model failAct(Model model, String actNo){
		int result = actService.failAct(actNo);
		if(1==result){
			model.addAttribute("failMsg","活动申请已否决！");
			model.addAttribute("failState",1);
		}
		else{
			model.addAttribute("failMsg","活动申请处理失败！");
			model.addAttribute("failState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/overdueAct")
	public Model overdueAct(Model model, String actNo){
		int result = actService.deleteAct(actNo);
		if(1==result){
			model.addAttribute("overdueMsg","活动状态已变更为过期状态！");
			model.addAttribute("overdueState",1);
		}
		else{
			model.addAttribute("overdueMsg","活动过期处理失败！");
			model.addAttribute("overdueState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/deleteAct")
	public Model deleteAct(Model model, String actNo){
		int result = actService.deleteActReally(actNo);
		if(1==result){
			model.addAttribute("deleteMsg","已彻底删除活动！");
			model.addAttribute("deleteState",1);
		}
		else{
			model.addAttribute("deleteMsg","删除活动失败！");
			model.addAttribute("deleteMsg",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/recoverAct")
	public Model recoverAct(Model model, String actNo){
		int result = actService.recoverAct(actNo);
		if(1==result){
			model.addAttribute("recoverMsg","已恢复活动至已发布状态！");
			model.addAttribute("recoverState",1);
		}
		else{
			model.addAttribute("recoverMsg","恢复活动失败！");
			model.addAttribute("recoverMsg",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/cancelActApply")
	public Model cancelActApply(Model model, String actNo, String userNo){
		int result = actService.cancelActApply(actNo, userNo);
		if(1==result){
			model.addAttribute("cancelMsg","已取消该活动申请！");
			model.addAttribute("cancelState",1);
		}
		else{
			model.addAttribute("cancelMsg","取消活动申请失败！");
			model.addAttribute("cancelState",0);
		}
		return model;
		
	}
	
	
}
