package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ProductBidding;

public interface ProductBiddingMapper {
	/*添加竞拍订单信息*/
	public void addProductBidding(ProductBidding productBidding) throws Exception;

	/*按照查询条件分页查询竞拍订单记录*/
	public ArrayList<ProductBidding> queryProductBidding(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有竞拍订单记录*/
	public ArrayList<ProductBidding> queryProductBiddingList(@Param("where") String where) throws Exception;

	/*按照查询条件的竞拍订单记录数*/
	public int queryProductBiddingCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条竞拍订单记录*/
	public ProductBidding getProductBidding(int biddingId) throws Exception;

	/*更新竞拍订单记录*/
	public void updateProductBidding(ProductBidding productBidding) throws Exception;

	/*删除竞拍订单记录*/
	public void deleteProductBidding(int biddingId) throws Exception;

}
