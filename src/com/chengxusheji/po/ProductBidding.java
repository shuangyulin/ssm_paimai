package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ProductBidding {
    /*订单编号*/
    private Integer biddingId;
    public Integer getBiddingId(){
        return biddingId;
    }
    public void setBiddingId(Integer biddingId){
        this.biddingId = biddingId;
    }

    /*竞拍商品*/
    private Item itemObj;
    public Item getItemObj() {
        return itemObj;
    }
    public void setItemObj(Item itemObj) {
        this.itemObj = itemObj;
    }

    /*竞拍用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*竞拍时间*/
    private String biddingTime;
    public String getBiddingTime() {
        return biddingTime;
    }
    public void setBiddingTime(String biddingTime) {
        this.biddingTime = biddingTime;
    }

    /*竞拍出价*/
    @NotNull(message="必须输入竞拍出价")
    private Float biddingPrice;
    public Float getBiddingPrice() {
        return biddingPrice;
    }
    public void setBiddingPrice(Float biddingPrice) {
        this.biddingPrice = biddingPrice;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProductBidding=new JSONObject(); 
		jsonProductBidding.accumulate("biddingId", this.getBiddingId());
		jsonProductBidding.accumulate("itemObj", this.getItemObj().getPTitle());
		jsonProductBidding.accumulate("itemObjPri", this.getItemObj().getItemId());
		jsonProductBidding.accumulate("userObj", this.getUserObj().getName());
		jsonProductBidding.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonProductBidding.accumulate("biddingTime", this.getBiddingTime().length()>19?this.getBiddingTime().substring(0,19):this.getBiddingTime());
		jsonProductBidding.accumulate("biddingPrice", this.getBiddingPrice());
		return jsonProductBidding;
    }}