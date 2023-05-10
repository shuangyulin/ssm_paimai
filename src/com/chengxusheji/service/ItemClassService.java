package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ItemClass;

import com.chengxusheji.mapper.ItemClassMapper;
@Service
public class ItemClassService {

	@Resource ItemClassMapper itemClassMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加商品类别记录*/
    public void addItemClass(ItemClass itemClass) throws Exception {
    	itemClassMapper.addItemClass(itemClass);
    }

    /*按照查询条件分页查询商品类别记录*/
    public ArrayList<ItemClass> queryItemClass(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return itemClassMapper.queryItemClass(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ItemClass> queryItemClass() throws Exception  { 
     	String where = "where 1=1";
    	return itemClassMapper.queryItemClassList(where);
    }

    /*查询所有商品类别记录*/
    public ArrayList<ItemClass> queryAllItemClass()  throws Exception {
        return itemClassMapper.queryItemClassList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = itemClassMapper.queryItemClassCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取商品类别记录*/
    public ItemClass getItemClass(int classId) throws Exception  {
        ItemClass itemClass = itemClassMapper.getItemClass(classId);
        return itemClass;
    }

    /*更新商品类别记录*/
    public void updateItemClass(ItemClass itemClass) throws Exception {
        itemClassMapper.updateItemClass(itemClass);
    }

    /*删除一条商品类别记录*/
    public void deleteItemClass (int classId) throws Exception {
        itemClassMapper.deleteItemClass(classId);
    }

    /*删除多条商品类别信息*/
    public int deleteItemClasss (String classIds) throws Exception {
    	String _classIds[] = classIds.split(",");
    	for(String _classId: _classIds) {
    		itemClassMapper.deleteItemClass(Integer.parseInt(_classId));
    	}
    	return _classIds.length;
    }
}
