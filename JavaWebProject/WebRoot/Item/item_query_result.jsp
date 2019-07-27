<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/item.css" /> 

<div id="item_manage"></div>
<div id="item_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="item_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="item_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="item_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="item_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="item_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="itemQueryForm" method="post">
			商品分类：<input class="textbox" type="text" id="itemClassObj_classId_query" name="itemClassObj.classId" style="width: auto"/>
			商品标题：<input type="text" class="textbox" id="pTitle" name="pTitle" style="width:110px" />
			发布人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			起拍时间：<input type="text" id="startTime" name="startTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="item_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="itemEditDiv">
	<form id="itemEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商品id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="item_itemId_edit" name="item.itemId" style="width:200px" />
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
				<script name="item.itemDesc" id="item_itemDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

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
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var item_itemDesc_editor = UE.getEditor('item_itemDesc_edit'); //商品描述编辑器
</script>
<script type="text/javascript" src="Item/js/item_manage.js"></script> 
