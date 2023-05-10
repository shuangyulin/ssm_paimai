var productBidding_manage_tool = null; 
$(function () { 
	initProductBiddingManageTool(); //建立ProductBidding管理对象
	productBidding_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#productBidding_manage").datagrid({
		url : 'ProductBidding/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "biddingId",
		sortOrder : "desc",
		toolbar : "#productBidding_manage_tool",
		columns : [[
			{
				field : "biddingId",
				title : "订单编号",
				width : 70,
			},
			{
				field : "itemObj",
				title : "竞拍商品",
				width : 140,
			},
			{
				field : "userObj",
				title : "竞拍用户",
				width : 140,
			},
			{
				field : "biddingTime",
				title : "竞拍时间",
				width : 140,
			},
			{
				field : "biddingPrice",
				title : "竞拍出价",
				width : 70,
			},
		]],
	});

	$("#productBiddingEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#productBiddingEditForm").form("validate")) {
					//验证表单 
					if(!$("#productBiddingEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#productBiddingEditForm").form({
						    url:"ProductBidding/" + $("#productBidding_biddingId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#productBiddingEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#productBiddingEditDiv").dialog("close");
			                        productBidding_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#productBiddingEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#productBiddingEditDiv").dialog("close");
				$("#productBiddingEditForm").form("reset"); 
			},
		}],
	});
});

function initProductBiddingManageTool() {
	productBidding_manage_tool = {
		init: function() {
			$.ajax({
				url : "Item/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#itemObj_itemId_query").combobox({ 
					    valueField:"itemId",
					    textField:"pTitle",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{itemId:0,pTitle:"不限制"});
					$("#itemObj_itemId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#productBidding_manage").datagrid("reload");
		},
		redo : function () {
			$("#productBidding_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#productBidding_manage").datagrid("options").queryParams;
			queryParams["itemObj.itemId"] = $("#itemObj_itemId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["biddingTime"] = $("#biddingTime").datebox("getValue"); 
			$("#productBidding_manage").datagrid("options").queryParams=queryParams; 
			$("#productBidding_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#productBiddingQueryForm").form({
			    url:"ProductBidding/OutToExcel",
			});
			//提交表单
			$("#productBiddingQueryForm").submit();
		},
		remove : function () {
			var rows = $("#productBidding_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var biddingIds = [];
						for (var i = 0; i < rows.length; i ++) {
							biddingIds.push(rows[i].biddingId);
						}
						$.ajax({
							type : "POST",
							url : "ProductBidding/deletes",
							data : {
								biddingIds : biddingIds.join(","),
							},
							beforeSend : function () {
								$("#productBidding_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#productBidding_manage").datagrid("loaded");
									$("#productBidding_manage").datagrid("load");
									$("#productBidding_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#productBidding_manage").datagrid("loaded");
									$("#productBidding_manage").datagrid("load");
									$("#productBidding_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#productBidding_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "ProductBidding/" + rows[0].biddingId +  "/update",
					type : "get",
					data : {
						//biddingId : rows[0].biddingId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (productBidding, response, status) {
						$.messager.progress("close");
						if (productBidding) { 
							$("#productBiddingEditDiv").dialog("open");
							$("#productBidding_biddingId_edit").val(productBidding.biddingId);
							$("#productBidding_biddingId_edit").validatebox({
								required : true,
								missingMessage : "请输入订单编号",
								editable: false
							});
							$("#productBidding_itemObj_itemId_edit").combobox({
								url:"Item/listAll",
							    valueField:"itemId",
							    textField:"pTitle",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#productBidding_itemObj_itemId_edit").combobox("select", productBidding.itemObjPri);
									//var data = $("#productBidding_itemObj_itemId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#productBidding_itemObj_itemId_edit").combobox("select", data[0].itemId);
						            //}
								}
							});
							$("#productBidding_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#productBidding_userObj_user_name_edit").combobox("select", productBidding.userObjPri);
									//var data = $("#productBidding_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#productBidding_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#productBidding_biddingTime_edit").datetimebox({
								value: productBidding.biddingTime,
							    required: true,
							    showSeconds: true,
							});
							$("#productBidding_biddingPrice_edit").val(productBidding.biddingPrice);
							$("#productBidding_biddingPrice_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入竞拍出价",
								invalidMessage : "竞拍出价输入不对",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
