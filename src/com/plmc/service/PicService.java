package com.plmc.service;

import java.text.ParseException;
import java.util.List;

import com.plmc.common.Page;
import com.plmc.dto.PictureDto;

public interface PicService {
	
	//照片上传下载
	/**
	 * 照片上传
	 * @param pictureDto 照片对象
	 * @return
	 */
	public int uploadPicture(PictureDto pictureDto);
	/**
	 * 照片下载
	 * @param picNo 照片编号
	 * @return
	 */
	public int downloadPicture(String picNo);

	
	
	//照片修改删除
	/**
	 * 删除照片
	 * @param picNo 照片编号
	 * @return
	 */
	public int deletePicture(String picNo);
	/**
	 * 真正删除照片
	 * @param picNo 照片编号
	 * @return
	 */
	public int deletePictureReally(String picNo);
	/**
	 * 恢复照片
	 * @param picNo 照片编号
	 * @return
	 */
	public int recoverPicture(String picNo);
	/**
	 * 修改照片
	 * @param picture 照片对象
	 * @return
	 * @throws ParseException 
	 */
	public int alterPicture(PictureDto pictureDto) throws ParseException;

	
	
	//照片查询
	/**
	 * 按照片编号查询照片
	 * @param picNo 照片编号
	 * @return 照片对象
	 * @throws ParseException 
	 */
	public PictureDto findByPictureNo(String picNo) throws ParseException;
	/**
	 * 查询一页照片
	 * @param dtoPage
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException
	 */
	public Page<PictureDto> findPicturePage(Page<PictureDto> dtoPage, String[] attrs, Object[] values) throws ParseException;
	
	/**
	 * 统计照片
	 * @param attrs
	 * @param values
	 * @return
	 */
	public int countPic(String[] attrs, Object[] values);

	
	
	//我喜欢的照片管理
	/**
	 * 收藏照片到我喜欢
	 * @param picNo 照片编号
	 * @return
	 */
	public int addPictureMyLove(String picNo);
	/**
	 * 取消收藏照片到我喜欢
	 * @param picNo 照片编号
	 * @return
	 */
	public int cancelPictureMyLove(String picNo);

	
	
	//照片申精
	/**
	 * 照片申精
	 * @param picNo 照片编号
	 * @return
	 */
	public int wellPictureApply(String picNo);
	/**
	 * 取消照片申精
	 * @param picNo 照片编号
	 * @return
	 */
	public int cancelWellPictureApply(String picNo);

	
	
	//照片审核
	/**
	 * 照片申精成功
	 * @param picNo 照片编号
	 * @return
	 */
	public int passWellPicture(String picNo);
	/**
	 * 照片申精失败
	 * @param picNo 照片编号
	 * @return
	 */
	public int failWellPicture(String picNo);
	
	
	
	/**
	 * 取指定条件照片
	 * @param attrs
	 * @param values
	 * @return
	 */
	public List<PictureDto> findPic(String[] attrs, Object[] values) throws ParseException;

	
}
