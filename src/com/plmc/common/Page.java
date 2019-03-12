package com.plmc.common;

import java.util.List;

import com.plmc.vo.entity.BaseEntity;

@SuppressWarnings("serial")
public class Page<T> extends BaseEntity{
	  
    /** 
     * 页码 
     */  
    private int page = 1;  
  
    /** 
     * 每页条数 
     */  
    private int pageSize = 6;  
  
    /** 
     * 总页数数 
     */  
    private int pageCount;  
    
    /** 
     * 总记录数 
     */  
    private long total;  
  
    /** 
     * 排序列 
     */  
    private String sort;  
  
    /** 
     * 升降序 
     */  
    private String order;  
  
    /** 
     * 单页数据 
     */  
    private List<T> data;  
  
    public Page() {  
        this.page = 1;  
        this.pageSize = 10;  
    }  
  
      
    public Page(int page, int pageSize) {  
        this.page = page;  
        this.pageSize = pageSize;  
    }  
  
    /** 
     * 获取page值 
     * @return int page. 
     */  
    public int getPage() {  
        return page;  
    }  
  
    /** 
     * 设置page值 
     * @param page The page to set. 
     */  
    public void setPage(int page) {  
        this.page = page;  
    }  
  
    /** 
     * 获取pageSize值 
     * @return int pageSize. 
     */  
    public int getPageSize() {  
        return pageSize;  
    }  
  
    /** 
     * 设置pageSize值 
     * @param pageSize The pageSize to set. 
     */  
    public void setPageSize(int pageSize) {  
        this.pageSize = pageSize;  
    }  
  
    /** 
     * 获取data值 
     * @return List<T> data. 
     */  
    public List<T> getData() {  
        return data;  
    }  
  
    /** 
     * 设置data值 
     * @param data The data to set. 
     */  
    public void setData(List<T> data) {  
        this.data = data;  
    }  
  
    /** 
     * 获取total值 
     * @return long total. 
     */  
    public long getTotal() {  
        return total;  
    }  
  
    public int getPageCount() {
		return pageCount;
	}


	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}


	/** 
     * 设置total值 
     * @param total The total to set. 
     */  
    public void setTotal(long total) {  
        this.total = total;  
    }  
  
    public String getSort() {  
        return sort;  
    }  
  
    public void setSort(String sort) {  
        this.sort = sort;  
    }  
  
    /** 
     * @return the order 
     */  
    public String getOrder() {  
        return order;  
    }  
  
    /** 
     * @param order the order to set 
     */  
    public void setOrder(String order) {  
        this.order = order;  
    }  
  
    /** 
     *  
     * 获取分页开始的位置 
     *  
     * @return 
     */  
    public int getStartIndex() {  
        if(page<1){  
            return 0;  
        }  
        return (page - 1) * pageSize;  
    }  
}
