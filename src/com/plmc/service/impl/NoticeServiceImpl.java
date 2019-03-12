package com.plmc.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plmc.common.Page;
import com.plmc.dao.NoticeDao;
import com.plmc.dao.UserDao;
import com.plmc.dto.ActDto;
import com.plmc.dto.NoticeDto;
import com.plmc.service.NoticeService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.entity.Act;
import com.plmc.vo.entity.Notice;
import com.plmc.vo.entity.User;

@Service
public class NoticeServiceImpl extends ServiceConstantUtil implements NoticeService{

	@Autowired 
	private NoticeDao noticeDao;
	
	@Autowired 
	private UserDao userDao;
	
	@Override
	public int addNotice(NoticeDto noticeDto) {
		Notice notice = new Notice();
		notice.setUserNo(noticeDto.getUserNo());
		notice.setNoticeTitle(noticeDto.getNoticeTitle());
		notice.setNoticeContent(noticeDto.getNoticeContent());
		notice.setNoticePubTime(new Date());
		notice.setNoticeState(Integer.parseInt(noticeDto.getNoticeState()));
		return noticeDao.save(notice);
	}

	@Override
	public int deleteNotice(String noticeNo) {
		return this.changeState(noticeNo, NOTICE_OVERDUE_STATE);
	}

	@Override
	public int deleteNoticeReally(String noticeNo) {
		return noticeDao.deleteById(Notice.class, noticeNo);
	}

	@Override
	public int recoverNotice(String noticeNo) {
		return this.changeState(noticeNo, NOTICE_PUBLISHED_STATE);
	}

	@Override
	public int alterNotice(NoticeDto noticeDto) throws ParseException {
		Notice notice = noticeDao.getById(Notice.class, noticeDto.getNoticeNo());
		Notice noticeUpdate = this.clearNotice(noticeDao.getById(Notice.class, noticeDto.getNoticeNo()));
		
		if(noticeDto.getUserNo() != null && noticeDto.getUserNo() !=""){
			if(!noticeDto.getUserNo().equals(notice.getUserNo())){
				noticeUpdate.setUserNo(noticeDto.getUserNo());
			}
		}
		if(noticeDto.getNoticeTitle() != null && noticeDto.getNoticeTitle() !=""){
			if(!noticeDto.getNoticeTitle().equals(notice.getNoticeTitle())){
				noticeUpdate.setNoticeTitle(noticeDto.getNoticeTitle());
			}
		}
		if(noticeDto.getNoticeContent() != null && noticeDto.getNoticeContent() !=""){
			if(!noticeDto.getNoticeContent().equals(notice.getNoticeContent())){
				noticeUpdate.setNoticeContent(noticeDto.getNoticeContent());
			}
		}
		if(noticeDto.getNoticePubTime() != null && noticeDto.getNoticePubTime() !=""){
			if(!noticeDto.getNoticePubTime().equals(ThreadLocalDateUtil.formatDate(notice.getNoticePubTime()))){
				noticeUpdate.setNoticePubTime(ThreadLocalDateUtil.parse(noticeDto.getNoticePubTime()));
			}
		}
		if(noticeDto.getNoticeState() != null && noticeDto.getNoticeState() !=""){
			if(!noticeDto.getNoticeState().equals(String.valueOf(notice.getNoticeState()))){
				noticeUpdate.setNoticeState(Integer.parseInt(noticeDto.getNoticeState()));
			}
		}		
		return noticeDao.update(noticeUpdate);
	}

	@Override
	public NoticeDto findByNoticeNo(String noticeNo) throws ParseException {
		return this.entityToDto(noticeDao.getById(Notice.class, noticeNo));
	}

	@Override
	public Page<NoticeDto> findNoticePage(Page<NoticeDto> dtoPage, String[] attrs, Object[] values) throws ParseException {
		Page<Notice> noticePage = new Page<Notice>();
		noticePage.setPage(dtoPage.getPage());
		noticePage.setPageSize(dtoPage.getPageSize());
		
		noticePage = noticeDao.pageSelect(Notice.class, noticePage, attrs, values);

		Page<NoticeDto> page = new Page<NoticeDto>();
		page.setPage(noticePage.getPage());
		page.setOrder(noticePage.getOrder());
		page.setPageSize(noticePage.getPageSize());
		page.setSort(noticePage.getSort());
		page.setTotal(noticePage.getTotal());
		page.setPageCount(noticePage.getPageCount());
		List<Notice> noticePageDate = noticePage.getData();
		int pageDateSize = noticePageDate.size();
		if(pageDateSize <= 0){
			return page;
		}
		else{
			List<NoticeDto> pageDate = new ArrayList<NoticeDto>();
			for(int i=0; i<pageDateSize; i++){
				pageDate.add(this.entityToDto(noticePageDate.get(i)));
			}
			page.setData(pageDate);
			return page;
		}
	}

	@Override
	public List<NoticeDto> findNotice(String[] attrs, Object[] values) throws ParseException {
		List<NoticeDto> listDto = new ArrayList<NoticeDto>(); 
		List<Notice> listEntity = noticeDao.selectList(Notice.class, attrs, values);
		for(int i=0; i<listEntity.size(); i++ ){
			NoticeDto dto = this.entityToDto(listEntity.get(i));
			listDto.add(dto);
		}
		return listDto;
	}

	//**************私有方法 开始**************//
	private NoticeDto entityToDto(Notice notice) throws ParseException{
		NoticeDto noticeDto = new NoticeDto();
		noticeDto.setNoticeNo(notice.getNoticeNo());
		noticeDto.setUserNo(notice.getUserNo());
		noticeDto.setNoticeTitle(notice.getNoticeTitle());
		noticeDto.setNoticeContent(notice.getNoticeContent());
		noticeDto.setNoticePubTime(ThreadLocalDateUtil.formatDate(notice.getNoticePubTime()));
		noticeDto.setNoticeState(String.valueOf(notice.getNoticeState()));
		noticeDto.setUserName(userDao.getById(User.class, notice.getUserNo()).getUserName());
		return noticeDto;
	}
	
	private Notice clearNotice(Notice notice){
		notice.setUserNo("");
		notice.setNoticeTitle("");
		notice.setNoticeContent("");
		notice.setNoticePubTime(null);
		notice.setNoticeState(-1);
		return notice;
	}
	
	private int changeState(String noticeNo, int state){
		Notice notice = noticeDao.getById(Notice.class, noticeNo);
		if(notice == null){
			return -1;
		}
		else{
			notice = this.clearNotice(notice);
			notice.setNoticeState(state);
			return noticeDao.update(notice);
		}
	}
	
	//**************私有方法 结束**************//
}
