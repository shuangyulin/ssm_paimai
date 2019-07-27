<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reply.css" /> 

<div id="reply_manage"></div>
<div id="reply_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="reply_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="reply_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="reply_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="reply_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="reply_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="replyQueryForm" method="post">
			回复人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			回复时间：<input type="text" id="replyTime" name="replyTime" class="easyui-datebox" editable="false" style="width:100px">
			被回帖子：<input class="textbox" type="text" id="postInfoObj_postInfoId_query" name="postInfoObj.postInfoId" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="reply_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="replyEditDiv">
	<form id="replyEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">回复id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reply_replyId_edit" name="reply.replyId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Reply/js/reply_manage.js"></script> 
