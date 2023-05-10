package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.UserFollow;

import com.chengxusheji.mapper.UserFollowMapper;
@Service
public class UserFollowService {

	@Resource UserFollowMapper userFollowMapper;
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

    /*添加用户关注记录*/
    public void addUserFollow(UserFollow userFollow) throws Exception {
    	userFollowMapper.addUserFollow(userFollow);
    }

    /*按照查询条件分页查询用户关注记录*/
    public ArrayList<UserFollow> queryUserFollow(UserInfo userObj1,UserInfo userObj2,String followTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != userObj1 &&  userObj1.getUser_name() != null  && !userObj1.getUser_name().equals(""))  where += " and t_userFollow.userObj1='" + userObj1.getUser_name() + "'";
    	if(null != userObj2 &&  userObj2.getUser_name() != null  && !userObj2.getUser_name().equals(""))  where += " and t_userFollow.userObj2='" + userObj2.getUser_name() + "'";
    	if(!followTime.equals("")) where = where + " and t_userFollow.followTime like '%" + followTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return userFollowMapper.queryUserFollow(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<UserFollow> queryUserFollow(UserInfo userObj1,UserInfo userObj2,String followTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != userObj1 &&  userObj1.getUser_name() != null && !userObj1.getUser_name().equals(""))  where += " and t_userFollow.userObj1='" + userObj1.getUser_name() + "'";
    	if(null != userObj2 &&  userObj2.getUser_name() != null && !userObj2.getUser_name().equals(""))  where += " and t_userFollow.userObj2='" + userObj2.getUser_name() + "'";
    	if(!followTime.equals("")) where = where + " and t_userFollow.followTime like '%" + followTime + "%'";
    	return userFollowMapper.queryUserFollowList(where);
    }

    /*查询所有用户关注记录*/
    public ArrayList<UserFollow> queryAllUserFollow()  throws Exception {
        return userFollowMapper.queryUserFollowList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(UserInfo userObj1,UserInfo userObj2,String followTime) throws Exception {
     	String where = "where 1=1";
    	if(null != userObj1 &&  userObj1.getUser_name() != null && !userObj1.getUser_name().equals(""))  where += " and t_userFollow.userObj1='" + userObj1.getUser_name() + "'";
    	if(null != userObj2 &&  userObj2.getUser_name() != null && !userObj2.getUser_name().equals(""))  where += " and t_userFollow.userObj2='" + userObj2.getUser_name() + "'";
    	if(!followTime.equals("")) where = where + " and t_userFollow.followTime like '%" + followTime + "%'";
        recordNumber = userFollowMapper.queryUserFollowCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取用户关注记录*/
    public UserFollow getUserFollow(int followId) throws Exception  {
        UserFollow userFollow = userFollowMapper.getUserFollow(followId);
        return userFollow;
    }

    /*更新用户关注记录*/
    public void updateUserFollow(UserFollow userFollow) throws Exception {
        userFollowMapper.updateUserFollow(userFollow);
    }

    /*删除一条用户关注记录*/
    public void deleteUserFollow (int followId) throws Exception {
        userFollowMapper.deleteUserFollow(followId);
    }

    /*删除多条用户关注信息*/
    public int deleteUserFollows (String followIds) throws Exception {
    	String _followIds[] = followIds.split(",");
    	for(String _followId: _followIds) {
    		userFollowMapper.deleteUserFollow(Integer.parseInt(_followId));
    	}
    	return _followIds.length;
    }
}
