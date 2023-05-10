<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/item.css" />
<div id="itemAddDiv">
	<form id="itemAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商品分类:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_itemClassObj_classId" name="item.itemClassObj.classId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">商品标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_pTitle" name="item.pTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">商品图片:</span>
			<span class="inputControl">
				<input id="itemPhotoFile" name="itemPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">商品描述:</span>
			<span class="inputControl">
				<script name="item.itemDesc" id="item_itemDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">发布人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_userObj_user_name" name="item.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">起拍价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_startPrice" name="item.startPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">起拍时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_startTime" name="item.startTime" />

			</span>

		</div>
		<div>
			<span class="label">结束时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_endTime" name="item.endTime" />

			</span>

		</div>
		<div class="operation">
			<a id="itemAddButton" class="easyui-linkbutton">添加</a>
			<a id="itemClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Item/js/item_add.js"></script> 
