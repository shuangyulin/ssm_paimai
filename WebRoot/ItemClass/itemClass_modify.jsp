<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/itemClass.css" />
<div id="itemClass_editDiv">
	<form id="itemClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商品分类id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="itemClass_classId_edit" name="itemClass.classId" value="<%=request.getParameter("classId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">商品类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="itemClass_className_edit" name="itemClass.className" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">类别描述:</span>
			<span class="inputControl">
				<textarea id="itemClass_classDesc_edit" name="itemClass.classDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="itemClassModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ItemClass/js/itemClass_modify.js"></script> 
