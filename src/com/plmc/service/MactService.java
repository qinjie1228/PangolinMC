package com.plmc.service;

import java.text.ParseException;
import java.util.List;

import com.plmc.common.Page;
import com.plmc.dto.ActDto;
import com.plmc.dto.MactDto;

public interface MactService {
	
	//活动预约记录增删改
	/**
	 * 添加活动预约记录
	 * @param mact 活动预约记录对象
	 * @return 操作影响行数
	 */
	public int addMact(MactDto mactDto);
	/**
	 * 删除活动预约记录
	 * @param mactNo 活动预约记录编号
	 * @return 
	 */
	public int deleteMact(String mactNo);
	/**
	 * 真正删除活动预约记录
	 * @param mactNo 活动预约记录编号
	 * @return 
	 */
	public int deleteMactReally(String mactNo);
	/**
	 * 恢复活动预约记录
	 * @param mactNo 活动预约记录编号
	 * @return 
	 */
	public int recoverMact(String mactNo);
	/**
	 * 修改活动预约记录
	 * @param mact 活动对象
	 * @return 
	 */
	public int alterMact(MactDto mactDto);

	
	
	//活动预约记录查询
	/**
	 * 查询一页活动预约记录
	 * @param dtoPage
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException 
	 */
	public Page<MactDto> findMactPage(Page<MactDto> dtoPage, String[] attrs, Object[] values) throws ParseException;

	/**
	 * 按用户编号,活动编号查询活动预约记录
	 * @param mactNo 活动预约记录编号
	 * @return 活动预约记录对象
	 * @throws ParseException 
	 */
	public MactDto findByMactNo(String mactNo) throws ParseException;
	
	/**
	 * 统计活动预约记录
	 * @param attrs
	 * @param values
	 * @return
	 */
	public int countMact(String[] attrs, Object[] values);
	
	/**
	 * 取指定条件活动预约记录
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException
	 */
	public List<MactDto> findMact(String[] attrs, Object[] values) throws ParseException;
	
	
	//活动预约申请
	/**
	 * 活动预约申请
	 * @return
	 */
	public int mactApply(String actNo, String userNo);
	/**
	 * 取消活动预约申请
	 * @param mactNo 活动预约记录编号
	 * @return
	 */
	public int cancelMactApply(String mactNo);
	/**
	 * 高级会员活动预约
	 * @return
	 */
	public int mactRes(String actNo, String userNo);
	
	
	//审核活动预约申请
	/**
	 * 通过活动预约
	 * @param mactNo 活动预约记录编号
	 * @return
	 */
	public int passMact(String mactNo);
	
	/**
	 * 否决后的活动预约申请再次变更为预约成功状态
	 * @param mactNo 活动预约记录编号
	 * @return
	 */
	public int failMactAgain(String mactNo);
	
	/**
	 * 否决活动预约
	 * @param mactNo 活动预约记录编号
	 * @return
	 */
	public int failMact(String mactNo);
	
	/**
	 * 取消活动预约
	 * @param mactNo 活动预约记录编号
	 * @return
	 */
	public int cancelMactRes(String mactNo);

}
