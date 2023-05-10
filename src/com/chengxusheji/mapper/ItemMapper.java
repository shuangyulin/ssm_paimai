package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Item;

public interface ItemMapper {
	/*添加商品信息*/
	public void addItem(Item item) throws Exception;

	/*按照查询条件分页查询商品记录*/
	public ArrayList<Item> queryItem(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有商品记录*/
	public ArrayList<Item> queryItemList(@Param("where") String where) throws Exception;

	/*按照查询条件的商品记录数*/
	public int queryItemCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条商品记录*/
	public Item getItem(int itemId) throws Exception;

	/*更新商品记录*/
	public void updateItem(Item item) throws Exception;

	/*删除商品记录*/
	public void deleteItem(int itemId) throws Exception;

}
