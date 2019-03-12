package com.plmc.service;

import java.text.ParseException;
import java.util.List;

import com.plmc.common.Page;
import com.plmc.dto.ActDto;

public interface ActService {
	
	//活动增删改
	/**
	 * 添加活动
	 * @param actDto 活动对象
	 * @return 受影响行数
	 */
	public int addAct(ActDto actDto);
	/**
	 * 删除活动
	 * @param actNo 活动编号
	 * @return 受影响行数
	 */
	public int deleteAct(String actNo);
	/**
	 * 真正删除活动
	 * @param actNo 活动编号
	 * @return 受影响行数
	 */
	public int deleteActReally(String actNo);
	/**
	 * 恢复活动
	 * @param actNo 活动编号
	 * @return 受影响行数
	 */
	public int recoverAct(String actNo);
	/**
	 * 修改活动
	 * @param actDto 活动对象
	 * @return 受影响行数
	 * @throws ParseException 
	 */
	public int alterAct(ActDto actDto) throws ParseException;

	
	//活动查询
	/**
	 * 按活动编号查询活动
	 * @param actNo 活动编号
	 * @return 活动对象
	 * @throws ParseException 
	 */
	public ActDto findByActNo(String actNo) throws ParseException;
	
	/**
	 * 查询一页活动
	 * @param dtoPage
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException 
	 */
	public Page<ActDto> findActPage(Page<ActDto> dtoPage, String[] attrs, Object[] values) throws ParseException;
	
	/**
	 * 统计活动
	 * @param attrs
	 * @param values
	 * @return
	 */
	public int countAct(String[] attrs, Object[] values);
	
	/**
	 * 取指定条件活动
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException 
	 */
	public List<ActDto> findAct(String[] attrs, Object[] values) throws ParseException;

	
	//活动申请
	/**
	 * 活动申请
	 * @param actDto 要申请的活动对象
	 * @return 活动申请结果
	 */
	public int actApply(ActDto actDto);
	/**
	 * 取消活动申请
	 * @param actNo 活动编号
	 * @param userNo 用户编号
	 * @return 取消活动申请结果
	 */
	public int cancelActApply(String actNo, String userNo);

	
	//活动审核
	/**
	 * 审核通过活动
	 * @param actNo 活动编号
	 * @return 取消审核通过活动结果
	 */
	public int passAct(String actNo);
	/**
	 * 审核否决活动
	 * @param actNo 活动编号
	 * @return 取消审核否决活动结果
	 */
	public int failAct(String actNo);

}
