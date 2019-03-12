package com.plmc.service;

import java.text.ParseException;
import java.util.List;

import com.plmc.common.Page;
import com.plmc.dto.ActDto;
import com.plmc.dto.NoticeDto;

public interface NoticeService {
	
	//公告增删改
	/**
	 * 添加公告
	 * @param noticeDto 公告对象
	 * @return
	 */
	public int addNotice(NoticeDto noticeDto);
	/**
	 * 删除公告
	 * @param noticeNo 公告编号
	 * @return
	 */
	public int deleteNotice(String noticeNo);
	/**
	 * 真正删除公告
	 * @param noticeNo 公告编号
	 * @return
	 */
	public int deleteNoticeReally(String noticeNo);
	/**
	 * 恢复公告
	 * @param noticeNo 公告编号
	 * @return
	 */
	public int recoverNotice(String noticeNo);
	/**
	 * 修改公告
	 * @param noticeDto 公告对象
	 * @return
	 * @throws ParseException 
	 */
	public int alterNotice(NoticeDto noticeDto) throws ParseException;

	
	
	//公告查询
	/**
	 * 按公告编号查询公告
	 * @param noticeNo 公告编号
	 * @return 公告对象
	 * @throws ParseException 
	 */
	public NoticeDto findByNoticeNo(String noticeNo) throws ParseException;

	/**
	 * 查询一页公告
	 * @param dtoPage
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException
	 */
	public Page<NoticeDto> findNoticePage(Page<NoticeDto> dtoPage, String[] attrs, Object[] values) throws ParseException;
	
	/**
	 * 取指定条件公告
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException
	 */
	public List<NoticeDto> findNotice(String[] attrs, Object[] values) throws ParseException;

	
}
