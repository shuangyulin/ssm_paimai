<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reply.css" />
<div id="reply_editDiv">
	<form id="replyEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">回复id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reply_replyId_edit" name="reply.replyId" value="<%=request.getParameter("replyId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">被回帖子:</span>
			<span class="inputControl">
				<input class="textbox"  id="reply_postInfoObj_postInfoId_edit" name="reply.postInfoObj.postInfoId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">回复内容:</span>
			<span class="inputControl">
				<textarea id="reply_content_edit" name="reply.content" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">回复人:</span>
			<span class="inputControl">
				<input class="textbox"  id="reply_userObj_user_name_edit" name="reply.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">回复时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reply_replyTime_edit" name="reply.replyTime" />

			</span>

		</div>
		<div class="operation">
			<a id="replyModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Reply/js/reply_modify.js"></script> 
