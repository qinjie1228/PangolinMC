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
import com.plmc.dao.PicDao;
import com.plmc.dao.UserDao;
import com.plmc.dto.ActDto;
import com.plmc.dto.PictureDto;
import com.plmc.service.PicService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.entity.Act;
import com.plmc.vo.entity.Picture;
import com.plmc.vo.entity.User;

@Service
public class PicServiceImpl extends ServiceConstantUtil implements PicService {

	@Autowired 
	private PicDao picDao;
	
	@Autowired 
	private UserDao userDao;

	@Override
	public int uploadPicture(PictureDto pictureDto) {
		Picture picture = new Picture();
		picture.setUserNo(pictureDto.getUserNo());
		picture.setPicDes(pictureDto.getPicDes());
		picture.setPicPath(pictureDto.getPicPath());
		picture.setPicPubTime(new Date());
		picture.setPicState(Integer.parseInt(pictureDto.getPicState()));
		return picDao.save(picture);
	}

	@Override
	public int downloadPicture(String picNo) {
		return 1;
	}

	@Override
	public int deletePicture(String picNo) {
		return this.changeState(picNo, PIC_OVERDUE_STATE);
	}

	@Override
	public int deletePictureReally(String picNo) {
		return picDao.deleteById(Picture.class, picNo);
	}

	@Override
	public int recoverPicture(String picNo) {
		return this.changeState(picNo, PIC_COMMON_STATE);
	}

	@Override
	public int alterPicture(PictureDto pictureDto) throws ParseException {
		Picture picture = picDao.getById(Picture.class, pictureDto.getPicNo());
		Picture pictureUpdate = this.clearPicture(picDao.getById(Picture.class, pictureDto.getPicNo()));
		
		if(pictureDto.getUserNo() != null && pictureDto.getUserNo() !=""){
			if(!pictureDto.getUserNo().equals(picture.getUserNo())){
				pictureUpdate.setUserNo(pictureDto.getUserNo());
			}
		}
		if(pictureDto.getPicDes() != null && pictureDto.getPicDes() !=""){
			if(!pictureDto.getPicDes().equals(picture.getPicDes())){
				pictureUpdate.setPicDes(pictureDto.getPicDes());
			}
		}
		if(pictureDto.getPicPath() != null && pictureDto.getPicPath() !=""){
			if(!pictureDto.getPicPath().equals(picture.getPicPath())){
				pictureUpdate.setPicPath(pictureDto.getPicPath());
			}
		}
		if(pictureDto.getPicPubTime() != null && pictureDto.getPicPubTime() !=""){
			if(!pictureDto.getPicPubTime().equals(ThreadLocalDateUtil.formatDate(picture.getPicPubTime()))){
				pictureUpdate.setPicPubTime(ThreadLocalDateUtil.parse(pictureDto.getPicPubTime()));
			}
		}
		if(pictureDto.getPicState() != null && pictureDto.getPicState() !=""){
			if(!pictureDto.getPicState().equals(String.valueOf(picture.getPicState()))){
				pictureUpdate.setPicState(Integer.parseInt(pictureDto.getPicState()));
			}
		}
		return picDao.update(pictureUpdate);
	}

	@Override
	public PictureDto findByPictureNo(String picNo) throws ParseException {
		return this.entityToDto(picDao.getById(Picture.class, picNo));
	}

	@Override
	public Page<PictureDto> findPicturePage(Page<PictureDto> dtoPage, String[] attrs, Object[] values) throws ParseException {
		Page<Picture> picturePage = new Page<Picture>();
		picturePage.setPage(dtoPage.getPage());
		picturePage.setPageSize(dtoPage.getPageSize());
		
		picturePage = picDao.pageSelect(Picture.class, picturePage, attrs, values);

		Page<PictureDto> page = new Page<PictureDto>();
		page.setPage(picturePage.getPage());
		page.setOrder(picturePage.getOrder());
		page.setPageSize(picturePage.getPageSize());
		page.setSort(picturePage.getSort());
		page.setTotal(picturePage.getTotal());
		page.setPageCount(picturePage.getPageCount());
		List<Picture> picturePageDate = picturePage.getData();
		int pageDateSize = picturePageDate.size();
		if(pageDateSize <= 0){
			return page;
		}
		else{
			List<PictureDto> pageDate = new ArrayList<PictureDto>();
			for(int i=0; i<pageDateSize; i++){
				pageDate.add(this.entityToDto(picturePageDate.get(i)));
			}
			page.setData(pageDate);
			return page;
		}

	}

	@Override
	public int addPictureMyLove(String picNo) {
		return picDao.addToLove(picNo);
	}

	@Override
	public int cancelPictureMyLove(String picNo) {
		return picDao.cancelToLove(picNo);
	}

	@Override
	public int wellPictureApply(String picNo) {
		return this.changeState(picNo, PIC_WAITINGCHECK_STATE);
	}

	@Override
	public int cancelWellPictureApply(String picNo) {
		return this.changeState(picNo, PIC_COMMON_STATE);
	}

	@Override
	public int passWellPicture(String picNo) {
		return this.changeState(picNo, PIC_WELLCHOSEN_STATE);
	}

	@Override
	public int failWellPicture(String picNo) {
		return this.changeState(picNo, PIC_COMMON_STATE);
	}

	@Override
	public int countPic(String[] attrs, Object[] values) {
		return picDao.pageCount(Picture.class, attrs, values);
	}

	@Override
	public List<PictureDto> findPic(String[] attrs, Object[] values) throws ParseException {
		List<PictureDto> listDto = new ArrayList<PictureDto>(); 
		List<Picture> listEntity = picDao.selectList(Picture.class, attrs, values);
		for(int i=0; i<listEntity.size(); i++ ){
			PictureDto dto = this.entityToDto(listEntity.get(i));
			listDto.add(dto);
		}
		return listDto;
	}

	
	//**************私有方法 开始**************//
	private PictureDto entityToDto(Picture picture) throws ParseException{
		PictureDto pictureDto = new PictureDto();
		pictureDto.setPicNo(picture.getPicNo());
		pictureDto.setUserNo(picture.getUserNo());
		pictureDto.setPicDes(picture.getPicDes());
		pictureDto.setPicPath(picture.getPicPath());
		pictureDto.setPicPubTime(ThreadLocalDateUtil.formatDate(picture.getPicPubTime()));
		pictureDto.setPicState(String.valueOf(picture.getPicState()));
		pictureDto.setUserName(userDao.getById(User.class, picture.getUserNo()).getUserName());
		return pictureDto;
	}
	
	private Picture clearPicture(Picture picture){
		picture.setUserNo("");
		picture.setPicDes("");
		picture.setPicPath("");
		picture.setPicPubTime(null);
		picture.setPicState(-1);
		return picture;
	}
	
	private int changeState(String picNo, int state){
		Picture picture = picDao.getById(Picture.class, picNo);
		if(picture == null){
			return -1;
		}
		else{
			picture = this.clearPicture(picture);
			picture.setPicState(state);
			return picDao.update(picture);
		}
	}
	
	//**************私有方法 结束**************//
}
