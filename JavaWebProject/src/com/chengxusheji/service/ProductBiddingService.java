package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Item;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.ProductBidding;

import com.chengxusheji.mapper.ProductBiddingMapper;
@Service
public class ProductBiddingService {

	@Resource ProductBiddingMapper productBiddingMapper;
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

    /*添加竞拍订单记录*/
    public void addProductBidding(ProductBidding productBidding) throws Exception {
    	productBiddingMapper.addProductBidding(productBidding);
    }

    /*按照查询条件分页查询竞拍订单记录*/
    public ArrayList<ProductBidding> queryProductBidding(Item itemObj,UserInfo userObj,String biddingTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != itemObj && itemObj.getItemId()!= null && itemObj.getItemId()!= 0)  where += " and t_productBidding.itemObj=" + itemObj.getItemId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_productBidding.userObj='" + userObj.getUser_name() + "'";
    	if(!biddingTime.equals("")) where = where + " and t_productBidding.biddingTime like '%" + biddingTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return productBiddingMapper.queryProductBidding(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ProductBidding> queryProductBidding(Item itemObj,UserInfo userObj,String biddingTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != itemObj && itemObj.getItemId()!= null && itemObj.getItemId()!= 0)  where += " and t_productBidding.itemObj=" + itemObj.getItemId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_productBidding.userObj='" + userObj.getUser_name() + "'";
    	if(!biddingTime.equals("")) where = where + " and t_productBidding.biddingTime like '%" + biddingTime + "%'";
    	return productBiddingMapper.queryProductBiddingList(where);
    }

    /*查询所有竞拍订单记录*/
    public ArrayList<ProductBidding> queryAllProductBidding()  throws Exception {
        return productBiddingMapper.queryProductBiddingList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Item itemObj,UserInfo userObj,String biddingTime) throws Exception {
     	String where = "where 1=1";
    	if(null != itemObj && itemObj.getItemId()!= null && itemObj.getItemId()!= 0)  where += " and t_productBidding.itemObj=" + itemObj.getItemId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_productBidding.userObj='" + userObj.getUser_name() + "'";
    	if(!biddingTime.equals("")) where = where + " and t_productBidding.biddingTime like '%" + biddingTime + "%'";
        recordNumber = productBiddingMapper.queryProductBiddingCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取竞拍订单记录*/
    public ProductBidding getProductBidding(int biddingId) throws Exception  {
        ProductBidding productBidding = productBiddingMapper.getProductBidding(biddingId);
        return productBidding;
    }

    /*更新竞拍订单记录*/
    public void updateProductBidding(ProductBidding productBidding) throws Exception {
        productBiddingMapper.updateProductBidding(productBidding);
    }

    /*删除一条竞拍订单记录*/
    public void deleteProductBidding (int biddingId) throws Exception {
        productBiddingMapper.deleteProductBidding(biddingId);
    }

    /*删除多条竞拍订单信息*/
    public int deleteProductBiddings (String biddingIds) throws Exception {
    	String _biddingIds[] = biddingIds.split(",");
    	for(String _biddingId: _biddingIds) {
    		productBiddingMapper.deleteProductBidding(Integer.parseInt(_biddingId));
    	}
    	return _biddingIds.length;
    }
}
