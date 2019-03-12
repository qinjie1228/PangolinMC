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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.plmc.common.Page;
import com.plmc.dto.ActDto;
import com.plmc.dto.OrderDto;
import com.plmc.dto.PictureDto;
import com.plmc.service.PicService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.vo.session.CurrentUser;

@RequestMapping("/pic")
@Controller
public class PicController extends ControllerConstantUtil {
	
	@Autowired  
	private PicService picService;

	@RequestMapping(value = "/toGetAllPic", method = RequestMethod.GET)
	public ModelAndView toGetAllPic(HttpSession session,
			@RequestParam("picState") String picState, String url) {
		ModelAndView picModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		picModel.addObject(CURRENT_USER, currentUser);
		picModel.addObject(PIC_STATE, picState);
		picModel.setViewName(url);
		return picModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/doGetAllPic")
	public Page<PictureDto> doGetAllPic(int pageNow, int pageSize, int picState, @RequestParam(value="islove", required=false) Integer islove) throws ParseException {
		Page<PictureDto> page =new Page<PictureDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {PIC_STATE, "islove"};
		Object[] values = {picState, islove};
		page = picService.findPicturePage(page, attrs, values);
		return page;
	}

	
	@ResponseBody
	@RequestMapping("/picIndexShow")
	public List<PictureDto> picIndexShow(int selectNum) throws ParseException {
		String[] attrs = {"pubTimeOrder", "selectNum", "picState"};
		Object[] values = {"true", selectNum, PIC_WELLCHOSEN_STATE};
		return picService.findPic(attrs, values);
	}
	
	
	@ResponseBody
	@RequestMapping("/getPicCondition")
	public Page<PictureDto> getPicCondition(int pageNow, int pageSize, PictureDto dto, int picState, @RequestParam(value="islove", required=false) Integer islove, String searchStartTime, String searchEndTime) throws ParseException {
		Page<PictureDto> page =new Page<PictureDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		if(picState == PIC_MYLOVE_STATE){
			String[] attrs = {"userName","picDes","timeStart","timeEnd","isLove"};
			Object[] values = {dto.getUserName(),dto.getPicDes(),searchStartTime,searchEndTime,islove};
			page = picService.findPicturePage(page, attrs, values);
			return page;
		}
		String[] attrs = {"userName","picDes","timeStart","timeEnd",PIC_STATE};
		Object[] values = {dto.getUserName(),dto.getPicDes(),searchStartTime,searchEndTime,picState};
		page = picService.findPicturePage(page, attrs, values);
		return page;
	}

	@ResponseBody
	@RequestMapping("/findPicByPicNo")
	public PictureDto findPicByPicNo(String picNo) throws ParseException{
		PictureDto pictureDto = picService.findByPictureNo(picNo);
		return pictureDto;
	}

	
	public String getUploadFileName(MultipartFile file) throws IOException{	
		String originalName = file.getOriginalFilename();
		int index = originalName.lastIndexOf(".");
		String suffixName = originalName.substring(index+1);		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String prefixName = sdf.format(new Date());
		String fileName = prefixName+"."+suffixName;
		String path = "D:/plmc/img/pic";
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
	
	
	@RequestMapping(value = "/addPic", method = RequestMethod.POST)
	public ModelAndView addPic(
			@ModelAttribute("pictureDto") PictureDto pictureDto, @RequestParam(value="url", required=false) String url, HttpServletRequest request) throws IOException{
		MultipartHttpServletRequest mRequest =
				(MultipartHttpServletRequest)request;
		MultipartFile file = mRequest.getFile("file");
		ModelAndView picModel = new ModelAndView();
		picModel.addObject(PIC_STATE, pictureDto.getPicState());
		pictureDto.setPicPath(getUploadFileName(file));
		int result = picService.uploadPicture(pictureDto);
		if(url == null){
			if(1 == result){
				picModel.addObject("addMsg", "照片上传成功！");
				picModel.addObject("addState", 1);
			}
			else{
				picModel.addObject("addMsg", "照片上传失败！");
				picModel.addObject("addState", 0);
			}
			picModel.setViewName("page/background/pic-list");
		}
		else{
			picModel.setViewName("page/forehead/mypage/my-pic");
		}
		return picModel;
		
	}
	
	
	@RequestMapping(value = "/doAlterPic", method = RequestMethod.POST)
	public ModelAndView doAlterPic( 
			@ModelAttribute("pictureDto") PictureDto pictureDto, @RequestParam(value="url", required=false) String url, HttpServletRequest request) throws IOException, ParseException{
		ModelAndView picModel = new ModelAndView();
		
		if(pictureDto.getPicPath().equals("success")){
			MultipartHttpServletRequest mRequest =
					(MultipartHttpServletRequest)request;
			MultipartFile file = mRequest.getFile("file");
			String flilName = getUploadFileName(file);
			File deleteFile = new File("D:/plmc/img/post/"+picService.findByPictureNo(pictureDto.getPicNo()).getPicPath());
			deleteFile.delete();
			pictureDto.setPicPath(flilName);
		}
		else{
			pictureDto.setPicPath(picService.findByPictureNo(pictureDto.getPicNo()).getPicPath());
		}
		
		pictureDto.setPicPubTime(picService.findByPictureNo(pictureDto.getPicNo()).getPicPubTime());
		int result = picService.alterPicture(pictureDto);
		picModel.addObject(PIC_STATE, pictureDto.getPicState());
		if(url == null){
			if(1 == result){
				picModel.addObject("alterMsg", "照片修改成功！");
				picModel.addObject("alterState", 1);
			}
			else{
				picModel.addObject("alterMsg", "照片修改失败！");
				picModel.addObject("alterState", 0);
			}
			picModel.setViewName("page/background/pic-list");
		}
		else{
			picModel.setViewName("page/forehead/mypage/my-pic");
		}
		return picModel;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/wellPictureApply")
	public Model wellPictureApply(Model model, String picNo){
		int result = picService.wellPictureApply(picNo);
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
	@RequestMapping("/cancelWellPictureApply")
	public Model cancelWellPictureApply(Model model, String picNo){
		int result = picService.cancelWellPictureApply(picNo);
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
	@RequestMapping("/passPic")
	public Model passPic(Model model, String picNo){
		int result = picService.passWellPicture(picNo);
		if(1==result){
			model.addAttribute("passMsg","照片已变为精品照片！");
			model.addAttribute("passState",1);
		}
		else{
			model.addAttribute("passMsg","精品照片申请处理失败！");
			model.addAttribute("passState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/failPic")
	public Model failPost(Model model, String picNo){
		int result = picService.failWellPicture(picNo);
		if(1==result){
			model.addAttribute("failMsg","精品照片申请已否决！");
			model.addAttribute("failState",1);
		}
		else{
			model.addAttribute("failMsg","精品照片申请处理失败！");
			model.addAttribute("failState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/overduePic")
	public Model overduePost(Model model, String picNo){
		int result = picService.deletePicture(picNo);
		if(1==result){
			model.addAttribute("overdueMsg","照片状态已变更为过期状态！");
			model.addAttribute("overdueState",1);
		}
		else{
			model.addAttribute("overdueMsg","照片过期处理失败！");
			model.addAttribute("overdueState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/deletePic")
	public Model deletePost(Model model, String picNo){
		int result = picService.deletePictureReally(picNo);
		if(1==result){
			model.addAttribute("deleteMsg","已彻底删除照片！");
			model.addAttribute("deleteState",1);
		}
		else{
			model.addAttribute("deleteMsg","删除照片失败！");
			model.addAttribute("deleteMsg",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/recoverPic")
	public Model recoverPost(Model model, String picNo){
		int result = picService.recoverPicture(picNo);
		if(1==result){
			model.addAttribute("recoverMsg","已恢复照片至普通照片状态！");
			model.addAttribute("recoverState",1);
		}
		else{
			model.addAttribute("recoverMsg","恢复照片失败！");
			model.addAttribute("recoverMsg",0);
		}
		return model;
		
	}
	
	
	
	@ResponseBody
	@RequestMapping("/addPictureMyLove")
	public Model addPictureMyLove(Model model, String picNo){
		int result = picService.addPictureMyLove(picNo);
		if(1==result){
			model.addAttribute("addMyLoveMsg","照片已添加到我喜欢！");
			model.addAttribute("addMyLoveState",1);
		}
		else{
			model.addAttribute("addMyLoveMsg","添加照片到我喜欢失败！");
			model.addAttribute("addMyLoveState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/cancelPictureMyLove")
	public Model cancelPictureMyLove(Model model, String picNo){
		int result = picService.cancelPictureMyLove(picNo);
		if(1==result){
			model.addAttribute("cancelMyLoveMsg","照片已从我喜欢移除！");
			model.addAttribute("cancelMyLoveState",1);
		}
		else{
			model.addAttribute("cancelMyLoveMsg","取消我喜欢失败！");
			model.addAttribute("cancelMyLoveState",0);
		}
		return model;
		
	}
	
}
