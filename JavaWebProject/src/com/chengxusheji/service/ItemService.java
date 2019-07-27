package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ItemClass;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Item;

import com.chengxusheji.mapper.ItemMapper;
@Service
public class ItemService {

	@Resource ItemMapper itemMapper;
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

    /*添加商品记录*/
    public void addItem(Item item) throws Exception {
    	itemMapper.addItem(item);
    }

    /*按照查询条件分页查询商品记录*/
    public ArrayList<Item> queryItem(ItemClass itemClassObj,String pTitle,UserInfo userObj,String startTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != itemClassObj && itemClassObj.getClassId()!= null && itemClassObj.getClassId()!= 0)  where += " and t_item.itemClassObj=" + itemClassObj.getClassId();
    	if(!pTitle.equals("")) where = where + " and t_item.pTitle like '%" + pTitle + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_item.userObj='" + userObj.getUser_name() + "'";
    	if(!startTime.equals("")) where = where + " and t_item.startTime like '%" + startTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return itemMapper.queryItem(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Item> queryItem(ItemClass itemClassObj,String pTitle,UserInfo userObj,String startTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != itemClassObj && itemClassObj.getClassId()!= null && itemClassObj.getClassId()!= 0)  where += " and t_item.itemClassObj=" + itemClassObj.getClassId();
    	if(!pTitle.equals("")) where = where + " and t_item.pTitle like '%" + pTitle + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_item.userObj='" + userObj.getUser_name() + "'";
    	if(!startTime.equals("")) where = where + " and t_item.startTime like '%" + startTime + "%'";
    	return itemMapper.queryItemList(where);
    }

    /*查询所有商品记录*/
    public ArrayList<Item> queryAllItem()  throws Exception {
        return itemMapper.queryItemList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(ItemClass itemClassObj,String pTitle,UserInfo userObj,String startTime) throws Exception {
     	String where = "where 1=1";
    	if(null != itemClassObj && itemClassObj.getClassId()!= null && itemClassObj.getClassId()!= 0)  where += " and t_item.itemClassObj=" + itemClassObj.getClassId();
    	if(!pTitle.equals("")) where = where + " and t_item.pTitle like '%" + pTitle + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_item.userObj='" + userObj.getUser_name() + "'";
    	if(!startTime.equals("")) where = where + " and t_item.startTime like '%" + startTime + "%'";
        recordNumber = itemMapper.queryItemCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取商品记录*/
    public Item getItem(int itemId) throws Exception  {
        Item item = itemMapper.getItem(itemId);
        return item;
    }

    /*更新商品记录*/
    public void updateItem(Item item) throws Exception {
        itemMapper.updateItem(item);
    }

    /*删除一条商品记录*/
    public void deleteItem (int itemId) throws Exception {
        itemMapper.deleteItem(itemId);
    }

    /*删除多条商品信息*/
    public int deleteItems (String itemIds) throws Exception {
    	String _itemIds[] = itemIds.split(",");
    	for(String _itemId: _itemIds) {
    		itemMapper.deleteItem(Integer.parseInt(_itemId));
    	}
    	return _itemIds.length;
    }
}
