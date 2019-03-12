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
import com.plmc.dto.ToolDto;
import com.plmc.service.ToolService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.vo.session.CurrentUser;

@RequestMapping("/tool")
@Controller
public class ToolController extends ControllerConstantUtil {

	@Autowired 
	private ToolService toolService;
	
	@RequestMapping(value = "/toGetAllTool", method = RequestMethod.GET)
	public ModelAndView toGetAllTool(HttpSession session,
			@RequestParam("toolState") String toolState) {
		ModelAndView toolModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		toolModel.addObject(CURRENT_USER, currentUser);
		toolModel.addObject(TOOL_STATE, toolState);
		toolModel.setViewName("page/background/tool-list");
		return toolModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/doGetAllTool")
	public Page<ToolDto> doGetAllTool(int pageNow, int pageSize, int toolState) throws ParseException {
		Page<ToolDto> page =new Page<ToolDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"toolState"};
		Object[] values = {toolState};
		page = toolService.findToolPage(page, attrs, values);
		return page;
	}

	
	@ResponseBody
	@RequestMapping("/getToolCondition")
	public Page<ToolDto> getToolCondition(int pageNow, int pageSize, ToolDto dto, int toolState, String searchStartPrice, String searchEndPrice, String searchStartTime, String searchEndTime) throws ParseException {
		Page<ToolDto> page =new Page<ToolDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"toolName","toolNum","priceStart","priceEnd","timeBefore","timeAfter","actState"};
		Object[] values = {dto.getToolName(),dto.getToolNum().equals("") ?  null : Integer.parseInt(dto.getToolNum()),searchStartPrice,searchEndPrice,searchStartTime,searchEndTime,toolState};
		page = toolService.findToolPage(page, attrs, values);
		return page;
	}

	
	@ResponseBody
	@RequestMapping("/findToolByToolNo")
	public ToolDto findToolByToolNo(String toolNo) throws ParseException{
		ToolDto toolDto = toolService.findByToolNo(toolNo);
		return toolDto;
	}
	
	
	@RequestMapping("/findToolIndexByToolNo")
	public ModelAndView findActIndexByActNo(String toolNo) throws ParseException{
		ModelAndView toolModel = new ModelAndView();
		ToolDto tool = toolService.findByToolNo(toolNo);
		toolModel.addObject(TOOL_ONE, tool);
		toolModel.setViewName("page/forehead/pageone/page-tool");
		return toolModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/toolIndexShow")
	public List<ToolDto> toolIndexShow(int selectNum) throws ParseException {
		String[] attrs = {"pubTimeOrder", "selectNum", "toolState"};
		Object[] values = {"true", selectNum, TOOL_SALING_STATE};
		return toolService.findTool(attrs, values);
	}
	
	
	@ResponseBody
	@RequestMapping("/getToolNumByToolNo")
	public int getToolNumByToolNo(String toolNo) throws ParseException {
		String[] attrs = {"toolNo"};
		Object[] values = {toolNo};
		return Integer.parseInt(toolService.findTool(attrs, values).get(0).getToolNum());
	}
	
	
	public String getUploadFileName(MultipartFile file) throws IOException{	
		String originalName = file.getOriginalFilename();
		int index = originalName.lastIndexOf(".");
		String suffixName = originalName.substring(index+1);		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String prefixName = sdf.format(new Date());
		String fileName = prefixName+"."+suffixName;
		String path = "D:/plmc/img/tool";
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
	
	
	@RequestMapping(value = "/addTool", method = RequestMethod.POST)
	public ModelAndView addTool (
			@ModelAttribute("toolDto") ToolDto toolDto, HttpServletRequest request)throws IOException{
		
		MultipartHttpServletRequest mRequest =
				(MultipartHttpServletRequest)request;
		MultipartFile file = mRequest.getFile("file");
		ModelAndView toolModel = new ModelAndView();
		toolModel.addObject(TOOL_STATE, toolDto.getToolState());
		toolDto.setToolPic(getUploadFileName(file));
		int result = toolService.addTool(toolDto);
		if(1 == result){
			toolModel.addObject("addMsg", "道具添加成功！");
			toolModel.addObject("addState", 1);
		}
		else{
			toolModel.addObject("addMsg", "道具添加失败！");
			toolModel.addObject("addState", 0);
		}
		toolModel.setViewName("page/background/tool-list");
		return toolModel;
		
	}
	
	
	@RequestMapping(value = "/doAlterTool", method = RequestMethod.POST)
	public ModelAndView doAlterTool( 
			@ModelAttribute("toolDto") ToolDto toolDto, HttpServletRequest request) throws IOException, ParseException{
		ModelAndView toolModel = new ModelAndView();
		if(toolDto.getToolPic().equals("success")){
			MultipartHttpServletRequest mRequest =
					(MultipartHttpServletRequest)request;
			MultipartFile file = mRequest.getFile("file");
			String flilName = getUploadFileName(file);
			
			File deleteFile = new File("D:/plmc/img/tool/"+toolService.findByToolNo(toolDto.getToolNo()).getToolPic());
			deleteFile.delete();
			toolDto.setToolPic(flilName);
		}
		else{
			toolDto.setToolPic(toolService.findByToolNo(toolDto.getToolNo()).getToolPic());
		}
		toolDto.setToolPubTime(toolService.findByToolNo(toolDto.getToolNo()).getToolPubTime());
		int result = toolService.alterTool(toolDto);
		toolModel.addObject(TOOL_STATE, toolDto.getToolState());
		if(1 == result){
			toolModel.addObject("alterMsg", "道具修改成功！");
			toolModel.addObject("alterState", 1);
		}
		else{
			toolModel.addObject("alterMsg", "道具修改失败！");
			toolModel.addObject("alterState", 0);
		}
		toolModel.setViewName("page/background/tool-list");
		return toolModel;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/overdueTool")
	public Model overdueTool(Model model, String toolNo){
		int result = toolService.deleteTool(toolNo);
		if(1==result){
			model.addAttribute("overdueMsg","道具状态已变更为过期状态！");
			model.addAttribute("overdueState",1);
		}
		else{
			model.addAttribute("overdueMsg","道具过期处理失败！");
			model.addAttribute("overdueState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/deleteTool")
	public Model deleteTool(Model model, String toolNo){
		int result = toolService.deleteToolReally(toolNo);
		if(1==result){
			model.addAttribute("deleteMsg","已彻底删除道具！");
			model.addAttribute("deleteState",1);
		}
		else{
			model.addAttribute("deleteMsg","删除道具失败！");
			model.addAttribute("deleteMsg",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/recoverTool")
	public Model recoverTool(Model model, String toolNo){
		int result = toolService.recoverTool(toolNo);
		if(1==result){
			model.addAttribute("recoverMsg","已恢复道具至已发布状态！");
			model.addAttribute("recoverState",1);
		}
		else{
			model.addAttribute("recoverMsg","恢复道具失败！");
			model.addAttribute("recoverMsg",0);
		}
		return model;
		
	}
	
	
	
}
