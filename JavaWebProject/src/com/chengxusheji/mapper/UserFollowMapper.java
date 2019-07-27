package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.UserFollow;

public interface UserFollowMapper {
	/*添加用户关注信息*/
	public void addUserFollow(UserFollow userFollow) throws Exception;

	/*按照查询条件分页查询用户关注记录*/
	public ArrayList<UserFollow> queryUserFollow(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有用户关注记录*/
	public ArrayList<UserFollow> queryUserFollowList(@Param("where") String where) throws Exception;

	/*按照查询条件的用户关注记录数*/
	public int queryUserFollowCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条用户关注记录*/
	public UserFollow getUserFollow(int followId) throws Exception;

	/*更新用户关注记录*/
	public void updateUserFollow(UserFollow userFollow) throws Exception;

	/*删除用户关注记录*/
	public void deleteUserFollow(int followId) throws Exception;

}
