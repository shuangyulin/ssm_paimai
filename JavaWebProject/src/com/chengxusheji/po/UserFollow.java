package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class UserFollow {
    /*记录id*/
    private Integer followId;
    public Integer getFollowId(){
        return followId;
    }
    public void setFollowId(Integer followId){
        this.followId = followId;
    }

    /*被关注人*/
    private UserInfo userObj1;
    public UserInfo getUserObj1() {
        return userObj1;
    }
    public void setUserObj1(UserInfo userObj1) {
        this.userObj1 = userObj1;
    }

    /*关注人*/
    private UserInfo userObj2;
    public UserInfo getUserObj2() {
        return userObj2;
    }
    public void setUserObj2(UserInfo userObj2) {
        this.userObj2 = userObj2;
    }

    /*关注时间*/
    private String followTime;
    public String getFollowTime() {
        return followTime;
    }
    public void setFollowTime(String followTime) {
        this.followTime = followTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonUserFollow=new JSONObject(); 
		jsonUserFollow.accumulate("followId", this.getFollowId());
		jsonUserFollow.accumulate("userObj1", this.getUserObj1().getName());
		jsonUserFollow.accumulate("userObj1Pri", this.getUserObj1().getUser_name());
		jsonUserFollow.accumulate("userObj2", this.getUserObj2().getName());
		jsonUserFollow.accumulate("userObj2Pri", this.getUserObj2().getUser_name());
		jsonUserFollow.accumulate("followTime", this.getFollowTime().length()>19?this.getFollowTime().substring(0,19):this.getFollowTime());
		return jsonUserFollow;
    }}