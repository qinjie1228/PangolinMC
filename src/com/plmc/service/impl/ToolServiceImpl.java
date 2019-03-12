package com.plmc.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.plmc.common.Page;
import com.plmc.dao.ToolDao;
import com.plmc.dto.ActDto;
import com.plmc.dto.ToolDto;
import com.plmc.service.ToolService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.entity.Act;
import com.plmc.vo.entity.Tool;

@Service
public class ToolServiceImpl extends ServiceConstantUtil implements ToolService {

	@Resource(name="toolDaoImpl")
	private ToolDao toolDao;
	
	//**************私有方法 开始**************//
	public Tool getToolByMap(Map<String, Object> toolMap){
		Tool tool = new Tool();
		tool.setToolNo((String) toolMap.get("tool_no"));
		tool.setToolName((String) toolMap.get("tool_name"));
		tool.setToolDes((String) toolMap.get("tool_des"));
		tool.setToolNum((Integer) toolMap.get("tool_num"));
		tool.setToolPrice((Double) toolMap.get("tool_price"));
		tool.setToolPic((String) toolMap.get("tool_pic"));
		tool.setToolPubTime((Date) toolMap.get("tool_pub_time"));
		tool.setToolState((Integer) toolMap.get("tool_state"));
		tool.setVersion((Integer) toolMap.get("version"));
		return tool;
	}
	
	public ToolDto entityToDto(Tool tool) throws ParseException{
		ToolDto toolDto = new ToolDto();
		toolDto.setToolNo(tool.getToolNo());
		toolDto.setToolName(tool.getToolName());
		toolDto.setToolDes(tool.getToolDes());
		toolDto.setToolNum(String.valueOf(tool.getToolNum()));
		toolDto.setToolPrice(String.valueOf(tool.getToolPrice()));
		toolDto.setToolPic(tool.getToolPic());
		toolDto.setToolPubTime(ThreadLocalDateUtil.formatDate(tool.getToolPubTime()));
		toolDto.setToolState(String.valueOf(tool.getToolState()));
		toolDto.setVersion(String.valueOf(tool.getVersion()));
		return toolDto;
	}
	
	public Tool clearTool(Tool tool){
		tool.setToolName("");
		tool.setToolDes("");
		tool.setToolNum(-1);
		tool.setToolPrice(-1);
		tool.setToolPic("");
		tool.setToolPubTime(null);
		tool.setToolState(-1);
		return tool;
	}
	
	public int changeState(String toolNo, int state){
		Tool tool = toolDao.getById(Tool.class, toolNo);
		if(tool == null){
			return -1;
		}
		else{
			tool = this.clearTool(tool);
			tool.setToolState(state);
			return toolDao.update(tool);
		}
	}
	//**************私有方法 结束**************//
	@Override
	public int addTool(ToolDto toolDto) {
		Tool tool = new Tool();
		tool.setToolName(toolDto.getToolName());
		tool.setToolDes(toolDto.getToolDes());
		tool.setToolNum(Integer.parseInt(toolDto.getToolNum()));
		tool.setToolPrice(Double.parseDouble(toolDto.getToolPrice()));
		tool.setToolPic(toolDto.getToolPic());
		tool.setToolPubTime(new Date());
		tool.setToolState(TOOL_SALING_STATE);
		return toolDao.save(tool);
	}

	@Override
	public int alterTool(ToolDto toolDto) throws ParseException {
		Tool tool = toolDao.getById(Tool.class, toolDto.getToolNo());
		Tool toolUpdate = this.clearTool(toolDao.getById(Tool.class, toolDto.getToolNo()));
		
		toolUpdate.setVersion(Integer.parseInt(toolDto.getVersion()));
		if(toolDto.getToolName() != null && toolDto.getToolName() !=""){
			if(!toolDto.getToolName().equals(tool.getToolName())){
				toolUpdate.setToolName(toolDto.getToolName());
			}
		}
		if(toolDto.getToolDes() != null && toolDto.getToolDes() !=""){
			if(!toolDto.getToolDes().equals(tool.getToolDes())){
				toolUpdate.setToolDes(toolDto.getToolDes());
			}
		}
		if(toolDto.getToolNum() != null && toolDto.getToolNum() !=""){
			if(!toolDto.getToolNum().equals(String.valueOf(tool.getToolNum()))){
				if(toolDto.getToolNum().charAt(0) == '0'){
					return -1;
				}
				toolUpdate.setToolNum(Integer.parseInt(toolDto.getToolNum()));
			}
		}
		if(toolDto.getToolPrice() != null && toolDto.getToolPrice() !=""){
			if(!toolDto.getToolPrice().equals(String.valueOf(tool.getToolPrice()))){
				toolUpdate.setToolPrice(Double.parseDouble(toolDto.getToolPrice()));
			}
		}
		if(toolDto.getToolPic() != null && toolDto.getToolPic() !=""){
			if(!toolDto.getToolPic().equals(tool.getToolPic())){
				toolUpdate.setToolPic(toolDto.getToolPic());
			}
		}
		if(toolDto.getToolPubTime() != null && toolDto.getToolPubTime() !=""){
			if(!toolDto.getToolPubTime().equals(ThreadLocalDateUtil.formatDate(tool.getToolPubTime()))){
				toolUpdate.setToolPubTime(ThreadLocalDateUtil.parse(toolDto.getToolPubTime()));
			}
		}
		if(toolDto.getToolState() != null && toolDto.getToolState() !=""){
			if(!toolDto.getToolState().equals(String.valueOf(tool.getToolState()))){
				toolUpdate.setToolState(Integer.parseInt(toolDto.getToolState()));
			}
		}
		return toolDao.update(toolUpdate);
	}

	@Override
	public int deleteTool(String toolNo) {
		return this.changeState(toolNo, TOOL_OVERDUE_STATE);
	}

	@Override
	public int deleteToolReally(String toolNo) {
		return toolDao.deleteById(Tool.class, toolNo);
	}

	@Override
	public int recoverTool(String toolNo) {
		return this.changeState(toolNo, TOOL_SALING_STATE);
	}

	@Override
	public ToolDto findByToolNo(String toolNo) throws ParseException {
		return this.entityToDto(toolDao.getById(Tool.class, toolNo));
	}

	@Override
	public Page<ToolDto> findToolPage(Page<ToolDto> dtoPage, String[] attrs, Object[] values) throws ParseException {
		Page<Tool> toolPage = new Page<Tool>();
		toolPage.setPage(dtoPage.getPage());
		toolPage.setPageSize(dtoPage.getPageSize());
		
		toolPage = toolDao.pageSelect(Tool.class, toolPage, attrs, values);

		Page<ToolDto> page = new Page<ToolDto>();
		page.setPage(toolPage.getPage());
		page.setOrder(toolPage.getOrder());
		page.setPageSize(toolPage.getPageSize());
		page.setSort(toolPage.getSort());
		page.setTotal(toolPage.getTotal());
		page.setPageCount(toolPage.getPageCount());
		List<Tool> toolPageDate = toolPage.getData();
		int pageDateSize = toolPageDate.size();
		if(pageDateSize <= 0){
			return page;
		}
		else{
			List<ToolDto> pageDate = new ArrayList<ToolDto>();
			for(int i=0; i<pageDateSize; i++){
				pageDate.add(this.entityToDto(toolPageDate.get(i)));
			}
			page.setData(pageDate);
			return page;
		}
	}

	@Override
	public List<ToolDto> findTool(String[] attrs, Object[] values) throws ParseException {
		List<ToolDto> listDto = new ArrayList<ToolDto>(); 
		List<Tool> listEntity = toolDao.selectList(Tool.class, attrs, values);
		for(int i=0; i<listEntity.size(); i++ ){
			ToolDto dto = this.entityToDto(listEntity.get(i));
			listDto.add(dto);
		}
		return listDto;
	}
}
