package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ItemClass;

public interface ItemClassMapper {
	/*添加商品类别信息*/
	public void addItemClass(ItemClass itemClass) throws Exception;

	/*按照查询条件分页查询商品类别记录*/
	public ArrayList<ItemClass> queryItemClass(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有商品类别记录*/
	public ArrayList<ItemClass> queryItemClassList(@Param("where") String where) throws Exception;

	/*按照查询条件的商品类别记录数*/
	public int queryItemClassCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条商品类别记录*/
	public ItemClass getItemClass(int classId) throws Exception;

	/*更新商品类别记录*/
	public void updateItemClass(ItemClass itemClass) throws Exception;

	/*删除商品类别记录*/
	public void deleteItemClass(int classId) throws Exception;

}
