package com.plmc.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import com.plmc.dto.UserDto;
import com.plmc.service.ActService;
import com.plmc.service.CommentService;
import com.plmc.service.MactService;
import com.plmc.service.NoticeService;
import com.plmc.service.OrderService;
import com.plmc.service.PicService;
import com.plmc.service.PostService;
import com.plmc.service.ToolService;
import com.plmc.service.UserService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.vo.session.CurrentUser;

@RequestMapping("/bac")
@Controller
public class BacController extends ControllerConstantUtil {
	
	@Autowired  
	private ActService actService;
	
	@Autowired  
	private MactService mactService;

	@Autowired  
	private OrderService orderService;
	
	@Autowired  
	private PostService postService;
	
	@Autowired  
	private PicService picService;

	
	@ResponseBody
	@RequestMapping("/count")
	public Model count(Model model){
		String[] attrsAct = {"actState"};
		Object[] valuesAct = {ACT_WAITINGCHECK_STATE};
		model.addAttribute("actCount", actService.countAct(attrsAct, valuesAct));
		
		String[] attrsMact = {"actResState"};
		Object[] valuesMact = {MACT_WAITINGCHECK_STATE};
		model.addAttribute("mactCount", mactService.countMact(attrsMact, valuesMact));
		
		String[] attrsOrderCheck = {"orderState"};
		Object[] valuesOrderCheck = {ORDER_WAITINGCHECK_STATE};
		model.addAttribute("orderCheckCount", orderService.countOrder(attrsOrderCheck, valuesOrderCheck));
		
		String[] attrsOrderSend = {"orderState"};
		Object[] valuesOrderSend = {ORDER_PASSPAY_STATE};
		model.addAttribute("orderSendCount", orderService.countOrder(attrsOrderSend, valuesOrderSend));
		
		String[] attrsPost = {"postState"};
		Object[] valuesPost = {POST_WAITINGCHECK_STATE};
		model.addAttribute("postCount", postService.countPost(attrsPost, valuesPost));
		
		String[] attrsPic = {"picState"};
		Object[] valuesPic = {PIC_WAITINGCHECK_STATE};
		model.addAttribute("picCount", picService.countPic(attrsPic, valuesPic));
		
		return model;
	}

	/**
	 * 跳转到后台个人中心首页
	 * @return
	 */
	@RequestMapping(value = "/toBacMain", method = RequestMethod.GET)
	public ModelAndView toBacMain() {
		HttpSession session =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession(); 
		ModelAndView userModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser)session.getAttribute(CURRENT_USER);
		if(currentUser != null){
			userModel.addObject(CURRENT_USER, currentUser);
			userModel.setViewName("page/background/background-main");
		}
		else{
			userModel.setViewName("index");
		}
		return userModel;
	}
}
