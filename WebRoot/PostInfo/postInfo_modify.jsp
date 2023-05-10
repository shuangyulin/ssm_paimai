<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/postInfo.css" />
<div id="postInfo_editDiv">
	<form id="postInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">帖子id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_postInfoId_edit" name="postInfo.postInfoId" value="<%=request.getParameter("postInfoId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">帖子标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_pTitle_edit" name="postInfo.pTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">帖子内容:</span>
			<span class="inputControl">
				<script id="postInfo_content_edit" name="postInfo.content" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">发帖人:</span>
			<span class="inputControl">
				<input class="textbox"  id="postInfo_userObj_user_name_edit" name="postInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发帖时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_addTime_edit" name="postInfo.addTime" />

			</span>

		</div>
		<div>
			<span class="label">浏览量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_hitNum_edit" name="postInfo.hitNum" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="postInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/PostInfo/js/postInfo_modify.js"></script> 
