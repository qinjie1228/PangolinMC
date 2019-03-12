package com.plmc.service;

import java.text.ParseException;
import java.util.List;

import com.plmc.common.Page;
import com.plmc.dto.ToolDto;

public interface ToolService {
	
	//道具增删改
	/**
	 * 添加道具
	 * @param toolDto 道具对象
	 * @return 
	 */
	public int addTool(ToolDto toolDto);
	/**
	 * 修改道具
	 * @param toolDto 道具对象
	 * @return
	 * @throws ParseException 
	 */
	public int alterTool(ToolDto toolDto) throws ParseException;
	/**
	 * 删除道具
	 * @param ToolNo 道具编号
	 * @return
	 */
	public int deleteTool(String toolNo);
	/**
	 * 真正删除道具
	 * @param ToolNo 道具编号
	 * @return
	 */
	public int deleteToolReally(String toolNo);
	/**
	 * 恢复道具
	 * @param ToolNo 道具编号
	 * @return
	 */
	public int recoverTool(String toolNo);

	
	
	//道具查询
	/**
	 * 按道具编号查询道具
	 * @param ToolNo 道具编号
	 * @return 道具对象
	 * @throws ParseException 
	 */
	public ToolDto findByToolNo(String toolNo) throws ParseException;
	
	/**
	 * 查询一页道具
	 * @param v
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException 
	 */
	public Page<ToolDto> findToolPage(Page<ToolDto> dtoPage, String[] attrs, Object[] values) throws ParseException;
	
	
	/**
	 * 取指定条件道具
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException 
	 */
	public List<ToolDto> findTool(String[] attrs, Object[] values) throws ParseException;



}
