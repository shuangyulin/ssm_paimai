<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/itemClass.css" />
<div id="itemClassAddDiv">
	<form id="itemClassAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商品类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="itemClass_className" name="itemClass.className" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">类别描述:</span>
			<span class="inputControl">
				<textarea id="itemClass_classDesc" name="itemClass.classDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="itemClassAddButton" class="easyui-linkbutton">添加</a>
			<a id="itemClassClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ItemClass/js/itemClass_add.js"></script> 
