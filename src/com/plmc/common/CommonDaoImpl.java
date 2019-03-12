package com.plmc.common;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;

@Repository("commonDao")  
public class CommonDaoImpl implements CommonDao {  
  
    @Resource(name = "sqlSessionFactory")  
    protected SqlSessionFactory sqlSessionFactory;  
  
    protected <T> String getStatement(Class<T> clazz, String prefix) {  
        String entityName = clazz.getSimpleName();  
        entityName = prefix + entityName;  
        return entityName;  
    }  
  
    @SuppressWarnings("finally")
	@Override  
    public <T extends Serializable> int save(T pojo) {  
        String statement = getStatement(pojo.getClass(), "insert"); 
        SqlSession sqlSession = null;
        Integer result = -1;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.insert(statement, pojo); 
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return result;
        }
    }  
  
    @SuppressWarnings("finally")
	@Override  
    public <T extends Serializable> int deleteById(Class<T> clazz,  
            Serializable id) {  
        String statement = getStatement(clazz, "idDelete");  
        SqlSession sqlSession = null;
        Integer result = -1;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.update(statement, id); 
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return result;
        }
    }  
    
    @SuppressWarnings("finally")
	@Override  
    public <T extends Serializable> int update(T pojo) {  
        String statement = getStatement(pojo.getClass(), "update");  
        SqlSession sqlSession = null;
        Integer result = -1;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.update(statement, pojo); 
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return result;
        }
    }  
  
    @SuppressWarnings("finally")
	@Override  
    public <T extends Serializable> T getById(Class<T> clazz, Serializable id) {  
        String statement = getStatement(clazz, "idGet");  
        SqlSession sqlSession = null;
        List<T> t = null;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	t = sqlSession.selectList(statement, id);  
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return t.get(0);
        }
    }  
  
    @SuppressWarnings("finally")
	@Override  
    public <T extends Serializable> List<T> listAll(Class<T> clazz) {  
        String statement = getStatement(clazz, "list");  
        SqlSession sqlSession = null;
        List<T> list = null;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	list = sqlSession.selectList(statement);  
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return list;
        }
    }  
  
    /** 
     *  
     * 组装排序串 
     * @param sort 
     * @param order 
     * @return 
     */  
    private String genOrderStr(String sort, String order) {  
        String orderBy = "";  
        if (StringUtils.isNotBlank(sort)) {  
            if (StringUtils.isNotBlank(order)) {  
                StringBuilder sb = new StringBuilder(" ");  
                String[] aSort = sort.split(",");  
                String[] aOrder = order.split(",");  
                for (int i = 0; i < aSort.length; i++) {  
                    sb.append(aSort[i]).append(" ");  
                    if (i < aOrder.length) {  
                        sb.append(aOrder[i]).append(",");  
                    } else {  
                        sb.append("ASC").append(",");  
                    }  
                }  
                // 删除最后一个,  
                sb.deleteCharAt(sb.length() - 1);  
                orderBy = sb.toString();  
  
            } else {  
                orderBy = " order by " + sort;  
            }  
        }  
  
        return orderBy;  
    }  
  
    @SuppressWarnings("finally")
	@Override  
    public <T extends Serializable> int pageCount(Class<T> clazz,  
            String[] attrs, Object[] values) {  
        Map<String, Object> paraMap = new HashMap<String, Object>();  
  
        if (values != null && attrs != null) {  
            for (int i = 0; i < values.length; i++) {  
                if (i < attrs.length) {  
                    paraMap.put(attrs[i], values[i]);  
                }  
            }  
        }  
        String statement = getStatement(clazz, "pageCount");  
        SqlSession sqlSession = null;
        Integer result = -1;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.selectOne(statement,paraMap); 
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return result;
        }
    }  
  
    @Override  
    public <T extends Serializable> Page<T> pageSelect(Class<T> clazz,  
            Page<T> p, String[] attrs, Object[] values) {  
        int startNum = p.getStartIndex();  
        int pageSize = p.getPageSize();  
        String orderBy = genOrderStr(p.getSort(), p.getOrder());  
        Map<String, Object> paraMap = new HashMap<String, Object>();  
        if (values != null && attrs != null) {  
            for (int i = 0; i < values.length; i++) {  
                if (i < attrs.length) {  
                    paraMap.put(attrs[i], values[i]);  
                }  
            }  
        }  
        String statement = getStatement(clazz, "page");  
        p.setTotal(pageCount(clazz, attrs, values));  
        paraMap.put("startNum", startNum);  
        paraMap.put("endNum", pageSize);  
        paraMap.put("orderBy", orderBy);   
        SqlSession sqlSession = null;
        List<T> list = null;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	list = sqlSession.selectList(statement,paraMap); 
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        }
        
        int pageCount = 0;
		if (p.getTotal() % pageSize == 0) {
			pageCount = (int) (p.getTotal() / pageSize);
		} else {
			pageCount = (int) (p.getTotal() / pageSize + 1);
		}
		if(pageCount==0){
			pageCount=1;
		}
		p.setPageCount(pageCount);
        p.setData(list);  
        return p;  
    }  
  
    @Override  
    public <T extends Serializable> List<T> selectList(Class<T> clazz, String[] attrs, Object[] values) {  
        Map<String, Object> paraMap = new HashMap<String, Object>();  
        if (values != null && attrs != null) {  
            for (int i = 0; i < values.length; i++) {  
                if (i < attrs.length) {  
                    paraMap.put(attrs[i], values[i]);  
                }  
            }  
        }  
        String statement = getStatement(clazz, "selectList");  
        SqlSession sqlSession = null;
        List<T> list = null;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	list = sqlSession.selectList(statement,paraMap); 
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        }
        return list;  
    }  
    
    @SuppressWarnings("finally")
	@Override  
    public <T extends Serializable> int countAll(Class<T> clazz) {  
        String statement = getStatement(clazz, "count");  
        SqlSession sqlSession = null;
        Integer result = -1;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.selectOne(statement);  
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return result;
        }
    }  
  
    @SuppressWarnings("finally")
	@Override  
    public List<Map<String, Object>> selectMap(String statement, Map<String, Object> paraMap) {
        SqlSession sqlSession = null;
        List<Map<String, Object>> result = null;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.selectList(statement,paraMap); 
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return result;
        }
    }  
  
	@SuppressWarnings("finally")
	protected <T extends Serializable> long getVersion(Class<T> clazz){
    	String statement = getStatement(clazz, "getVersion");  
        SqlSession sqlSession = null;
        Integer result = -1;
        try {
        	sqlSession = sqlSessionFactory.openSession();
        	result = sqlSession.selectOne(statement);  
        	sqlSession.commit(true);
        } catch (Exception e) {
        	e.printStackTrace();
        	sqlSession.rollback(true);
        } finally { 
        	sqlSession.close();
        	return result;
        }
    }
    
}  