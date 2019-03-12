package com.plmc.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plmc.common.Page;
import com.plmc.dao.ActDao;
import com.plmc.dao.UserDao;
import com.plmc.dto.ActDto;
import com.plmc.service.ActService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.entity.Act;
import com.plmc.vo.entity.User;

@Service
public class ActServiceImpl extends ServiceConstantUtil implements ActService {

	@Autowired 
	private ActDao actDao;
	
	@Autowired 
	private UserDao userDao;
	
	@Override
	public int addAct(ActDto actDto) {
		Act act = new Act();
		act.setUserNo(actDto.getUserNo());
		act.setActTitle(actDto.getActTitle());
		act.setActContent(actDto.getActContent());
		act.setActPic(actDto.getActPic());
		act.setActNum(actDto.getActNum()==null ? 0: Integer.parseInt(actDto.getActNum()));
		act.setActPubTime(new Date());
		act.setActState(Integer.parseInt(actDto.getActState()));
		return actDao.save(act);
	}

	@Override
	public int deleteAct(String actNo) {
		return this.changeState(actNo, ACT_OVERDUE_STATE);
	}

	@Override
	public int deleteActReally(String actNo) {
		return actDao.deleteById(Act.class, actNo);
	}

	@Override
	public int recoverAct(String actNo) {
		return this.changeState(actNo, ACT_PUBLISHED_STATE);
	}

	@Override
	public int alterAct(ActDto actDto) throws ParseException {
		Act act = actDao.getById(Act.class, actDto.getActNo());
		Act actUpdate = this.clearAct(actDao.getById(Act.class, actDto.getActNo()));
		
		if(actDto.getUserNo() != null && actDto.getUserNo() !=""){
			if(!actDto.getUserNo().equals(act.getUserNo())){
				actUpdate.setUserNo(actDto.getUserNo());
			}
		}
		if(actDto.getActTitle() != null && actDto.getActTitle() !=""){
			if(!actDto.getActTitle().equals(act.getActTitle())){
				actUpdate.setActTitle(actDto.getActTitle());
			}
		}
		if(actDto.getActContent() != null && actDto.getActContent() !=""){
			if(!actDto.getActContent().equals(act.getActContent())){
				actUpdate.setActContent(actDto.getActContent());
			}
		}
		if(actDto.getActPic() != null && actDto.getActPic() !=""){
			if(!actDto.getActPic().equals(act.getActPic())){
				actUpdate.setActPic(actDto.getActPic());
			}
		}
		if(actDto.getActNum() != null && actDto.getActNum() !=""){
			if(!actDto.getActNum().equals(String.valueOf(act.getActNum()))){
				actUpdate.setActNum(Integer.parseInt(actDto.getActNum()));
			}
		}
		if(actDto.getActPubTime() != null && actDto.getActPubTime() !=""){
			if(!actDto.getActPubTime().equals(ThreadLocalDateUtil.formatDate(act.getActPubTime()))){
				actUpdate.setActPubTime(ThreadLocalDateUtil.parse(actDto.getActPubTime()));
			}
		}
		if(actDto.getActState() != null && actDto.getActState() !=""){
			if(!actDto.getActState().equals(String.valueOf(act.getActState()))){
				actUpdate.setActState(Integer.parseInt(actDto.getActState()));
			}
		}
		
		return actDao.update(actUpdate);
	}

	@Override
	public ActDto findByActNo(String actNo) throws ParseException {
		return this.entityToDto(actDao.getById(Act.class, actNo));
	}

	@Override
	public Page<ActDto> findActPage(Page<ActDto> dtoPage, String[] attrs, Object[] values) throws ParseException {
		Page<Act> actPage = new Page<Act>();
		actPage.setPage(dtoPage.getPage());
		actPage.setPageSize(dtoPage.getPageSize());
		
		actPage = actDao.pageSelect(Act.class, actPage, attrs, values);

		Page<ActDto> page = new Page<ActDto>();
		page.setPage(actPage.getPage());
		page.setOrder(actPage.getOrder());
		page.setPageSize(actPage.getPageSize());
		page.setSort(actPage.getSort());
		page.setTotal(actPage.getTotal());
		page.setPageCount(actPage.getPageCount());
		List<Act> actPageDate = actPage.getData();
		int pageDateSize = actPageDate.size();
		if(pageDateSize <= 0){
			return page;
		}
		else{
			List<ActDto> pageDate = new ArrayList<ActDto>();
			for(int i=0; i<pageDateSize; i++){
				pageDate.add(this.entityToDto(actPageDate.get(i)));
			}
			page.setData(pageDate);
			return page;
		}

	}

	@Override
	public int actApply(ActDto actDto) {
		actDto.setActState(String.valueOf(ACT_WAITINGCHECK_STATE));
		return this.addAct(actDto);
	}

	@Override
	public int cancelActApply(String actNo, String userNo) {
		HashMap<String, Object> map =new HashMap<String, Object>();
		map.put("actNo", actNo);
		map.put("userNo", userNo);
		List<Map<String, Object>> list = actDao.selectMap("listMapAct", map);
		if(list.size() == 0){
			return 2;
		}
		else{
			if(actDao.deleteById(Act.class, actNo)!=1){
				return 3;
			}
			else{
				return 1;
			}
		}
	}

	@Override
	public int passAct(String actNo) {
		return this.changeState(actNo, ACT_PUBLISHED_STATE);
	}

	@Override
	public int failAct(String actNo) {
		return this.changeState(actNo, ACT_FAILCHECK_STATE);
	}

	@Override
	public int countAct(String[] attrs, Object[] values) {
		return actDao.pageCount(Act.class, attrs, values);
	}

	@Override
	public List<ActDto> findAct(String[] attrs, Object[] values) throws ParseException {
		List<ActDto> listDto = new ArrayList<ActDto>(); 
		List<Act> listEntity = actDao.selectList(Act.class, attrs, values);
		for(int i=0; i<listEntity.size(); i++ ){
			ActDto dto = this.entityToDto(listEntity.get(i));
			listDto.add(dto);
		}
		return listDto;
	}

	//**************私有方法 开始**************//
	private ActDto entityToDto(Act act) throws ParseException{
		ActDto actDto = new ActDto();
		actDto.setActNo(act.getActNo());
		actDto.setUserNo(act.getUserNo());
		actDto.setActTitle(act.getActTitle());
		actDto.setActContent(act.getActContent());
		actDto.setActPic(act.getActPic());
		actDto.setActNum(String.valueOf(act.getActNum()));
		actDto.setActPubTime(ThreadLocalDateUtil.formatDate(act.getActPubTime()));
		actDto.setActState(String.valueOf(act.getActState()));
		actDto.setUserName(userDao.getUserNameByUserNo(act.getUserNo()));
		return actDto;
	}
	
	private Act clearAct(Act act){
		act.setUserNo("");
		act.setActTitle("");
		act.setActContent("");
		act.setActPic("");
		act.setActNum(-1);
		act.setActPubTime(null);
		act.setActState(-1);
		return act;
	}
	
	private int changeState(String actNo, int state){
		Act act = actDao.getById(Act.class, actNo);
		if(act == null){
			return -1;
		}
		else{
			act = this.clearAct(act);
			act.setActState(state);
			return actDao.update(act);
		}
	}
	
	//**************私有方法 结束**************//
}
