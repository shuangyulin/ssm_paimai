<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/item.css" />
<div id="item_editDiv">
	<form id="itemEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商品id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_itemId_edit" name="item.itemId" value="<%=request.getParameter("itemId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">商品分类:</span>
			<span class="inputControl">
				<input class="textbox"  id="item_itemClassObj_classId_edit" name="item.itemClassObj.classId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">商品标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_pTitle_edit" name="item.pTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">商品图片:</span>
			<span class="inputControl">
				<img id="item_itemPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="item_itemPhoto" name="item.itemPhoto"/>
				<input id="itemPhotoFile" name="itemPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">商品描述:</span>
			<span class="inputControl">
				<script id="item_itemDesc_edit" name="item.itemDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">发布人:</span>
			<span class="inputControl">
				<input class="textbox"  id="item_userObj_user_name_edit" name="item.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">起拍价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_startPrice_edit" name="item.startPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">起拍时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_startTime_edit" name="item.startTime" />

			</span>

		</div>
		<div>
			<span class="label">结束时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_endTime_edit" name="item.endTime" />

			</span>

		</div>
		<div class="operation">
			<a id="itemModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Item/js/item_modify.js"></script> 
