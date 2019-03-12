package com.plmc.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.plmc.common.Page;
import com.plmc.dao.ActDao;
import com.plmc.dao.MactDao;
import com.plmc.dao.UserDao;
import com.plmc.dto.ActDto;
import com.plmc.dto.MactDto;
import com.plmc.service.MactService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.entity.Act;
import com.plmc.vo.entity.Mact;
import com.plmc.vo.entity.User;

@Service
@Transactional
public class MactServiceImpl extends ServiceConstantUtil implements MactService {

	@Resource(name="mactDaoImpl")
	private MactDao mactDao;
	
	@Resource(name="actDaoImpl")
	private ActDao actDao;
	
	@Resource(name="userDaoImpl")
	private UserDao userDao;
	
	@Override
	public int addMact(MactDto mactDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMact(String mactNo) {
		try {
			Mact mact = mactDao.getById(Mact.class, mactNo);
			Act act = this.clearAct(actDao.getById(Act.class, mact.getActNo()));
			mact = this.clearMact(mact);
			mact.setActResState(MACT_OVERDUE_STATE);
			mactDao.update(mact);
			
			act.setActNum(act.getActNum() - 1); 
			return actDao.update(act);
		} catch (Exception e) {
			return -1;
		}
		

	}

	@Override
	public int deleteMactReally(String mactNo) {
		return mactDao.deleteById(Mact.class, mactNo);
	}

	@Override
	public int recoverMact(String mactNo) {
		try {
			Mact mact = mactDao.getById(Mact.class, mactNo);
			Act act = this.clearAct(actDao.getById(Act.class, mact.getActNo()));
			mact.setActResState(MACT_PASSRESERVE_STATE);
			mact.setActResTime(new Date());
			mactDao.update(mact);
			
			act.setActNum(act.getActNum() + 1); 
			return actDao.update(act);
		} catch (Exception e) {
			return -1;
		}
	}

	@Override
	public int alterMact(MactDto mactDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Page<MactDto> findMactPage(Page<MactDto> dtoPage, String[] attrs, Object[] values) throws ParseException {
		Page<Mact> mactPage = new Page<Mact>();
		mactPage.setPage(dtoPage.getPage());
		mactPage.setPageSize(dtoPage.getPageSize());
		
		mactPage = actDao.pageSelect(Mact.class, mactPage, attrs, values);

		Page<MactDto> page = new Page<MactDto>();
		page.setPage(mactPage.getPage());
		page.setOrder(mactPage.getOrder());
		page.setPageSize(mactPage.getPageSize());
		page.setSort(mactPage.getSort());
		page.setTotal(mactPage.getTotal());
		page.setPageCount(mactPage.getPageCount());
		List<Mact> mactPageDate = mactPage.getData();
		int pageDateSize = mactPageDate.size();
		if(pageDateSize <= 0){
			return page;
		}
		else{
			List<MactDto> pageDate = new ArrayList<MactDto>();
			for(int i=0; i<pageDateSize; i++){
				pageDate.add(this.entityToDto(mactPageDate.get(i)));
			}
			page.setData(pageDate);
			return page;
		}

	}

	@Override
	public MactDto findByMactNo(String mactNo) throws ParseException {
		return this.entityToDto(mactDao.getById(Mact.class, mactNo));
	}
	
	@Override
	public int mactApply(String actNo, String userNo) {
		Mact mact =new Mact(userNo, actNo, new Date(), MACT_WAITINGCHECK_STATE);
		return mactDao.save(mact);
	}
	
	@Override
	public int mactRes(String actNo, String userNo) {
		try {
			Mact mact =new Mact(userNo, actNo, new Date(), MACT_PASSRESERVE_STATE);
			mactDao.save(mact);
			
			Act act = this.clearAct(actDao.getById(Act.class, actNo));
			act.setActNum(act.getActNum() + 1); 
			return actDao.update(act);
		} catch (Exception e) {
			return -1;
		}
	}

	@Override
	public int cancelMactApply(String mactNo) {
		return mactDao.deleteById(Mact.class, mactNo);
	}

	@Override
	public int passMact(String mactNo) {
		try {
			Mact mact = mactDao.getById(Mact.class, mactNo);
			Act act = this.clearAct(actDao.getById(Act.class, mact.getActNo()));
			mact.setActResState(MACT_PASSRESERVE_STATE);
			mact.setActResTime(new Date());
			mactDao.update(mact);
			
			act.setActNum(act.getActNum() + 1); 
			return actDao.update(act);
		} catch (Exception e) {
			return -1;
		}
	}

	@Override
	@Transactional
	public int failMactAgain(String mactNo) {
		try {
			Mact mact = mactDao.getById(Mact.class, mactNo);
			Act act = this.clearAct(actDao.getById(Act.class, mact.getActNo()));
			mact.setActResState(MACT_FAILRESERVE_STATE);
			mactDao.update(mact);
			
			act.setActNum(act.getActNum() - 1); 
			return actDao.update(act);
		} catch (Exception e) {
			return -1;
		}
	}

	@Override
	public int failMact(String mactNo) {
		return this.changeState(mactNo, MACT_FAILRESERVE_STATE);
	}

	@Override
	public int countMact(String[] attrs, Object[] values) {
		return mactDao.pageCount(Mact.class, attrs, values);
	}

	@Override
	public List<MactDto> findMact(String[] attrs, Object[] values) throws ParseException {
		List<MactDto> listDto = new ArrayList<MactDto>(); 
		List<Mact> listEntity = mactDao.selectList(Mact.class, attrs, values);
		for(int i=0; i<listEntity.size(); i++ ){
			MactDto dto = this.entityToDto(listEntity.get(i));
			listDto.add(dto);
		}
		return listDto;
	}

	@Override
	public int cancelMactRes(String mactNo) {
		Mact mact = mactDao.getById(Mact.class, mactNo);
		Act act = this.clearAct(actDao.getById(Act.class, mact.getActNo()));

		act.setActNum(act.getActNum() - 1);
		actDao.update(act);

		return mactDao.deleteById(Mact.class, mactNo);
	}
	
	//**************私有方法 开始**************//
		public MactDto entityToDto(Mact mact) throws ParseException{
			MactDto mactDto = new MactDto();
			mactDto.setMactNo(mact.getMactNo());
			mactDto.setActNo(mact.getActNo());
			mactDto.setUserNo(mact.getUserNo());
			mactDto.setActResTime(ThreadLocalDateUtil.formatDate(mact.getActResTime()));
			mactDto.setActResState(String.valueOf(mact.getActResState()));
			mactDto.setUserName(userDao.getUserNameByUserNo(mact.getUserNo()));
			mactDto.setActTitle(actDao.getById(Act.class, mact.getActNo()).getActTitle());
			return mactDto;
		}
		
		public Mact clearMact(Mact mact){
			mact.setActResTime(null);
			mact.setActResState(-1);
			return mact;
		}
		
		public Act clearAct(Act act){
			act.setUserNo("");
			act.setActTitle("");
			act.setActContent("");
			act.setActPic("");
			act.setActPubTime(null);
			act.setActState(-1);
			return act;
		}
		
		public int changeState(String mactNo, int state){
			Mact mact = mactDao.getById(Mact.class, mactNo);
			if(mact == null){
				return -1;
			}
			else{
				mact = this.clearMact(mact);
				mact.setActResState(state);
				return mactDao.update(mact);
			}
		}
		
		//**************私有方法 结束**************//
}
