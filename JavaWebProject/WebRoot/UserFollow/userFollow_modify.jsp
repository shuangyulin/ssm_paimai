<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userFollow.css" />
<div id="userFollow_editDiv">
	<form id="userFollowEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userFollow_followId_edit" name="userFollow.followId" value="<%=request.getParameter("followId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">被关注人:</span>
			<span class="inputControl">
				<input class="textbox"  id="userFollow_userObj1_user_name_edit" name="userFollow.userObj1.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">关注人:</span>
			<span class="inputControl">
				<input class="textbox"  id="userFollow_userObj2_user_name_edit" name="userFollow.userObj2.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">关注时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userFollow_followTime_edit" name="userFollow.followTime" />

			</span>

		</div>
		<div class="operation">
			<a id="userFollowModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/UserFollow/js/userFollow_modify.js"></script> 
