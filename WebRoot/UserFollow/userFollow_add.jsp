<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userFollow.css" />
<div id="userFollowAddDiv">
	<form id="userFollowAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">被关注人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userFollow_userObj1_user_name" name="userFollow.userObj1.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">关注人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userFollow_userObj2_user_name" name="userFollow.userObj2.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">关注时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userFollow_followTime" name="userFollow.followTime" />

			</span>

		</div>
		<div class="operation">
			<a id="userFollowAddButton" class="easyui-linkbutton">添加</a>
			<a id="userFollowClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/UserFollow/js/userFollow_add.js"></script> 
