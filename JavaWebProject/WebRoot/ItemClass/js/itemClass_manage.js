var itemClass_manage_tool = null; 
$(function () { 
	initItemClassManageTool(); //建立ItemClass管理对象
	itemClass_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#itemClass_manage").datagrid({
		url : 'ItemClass/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "classId",
		sortOrder : "desc",
		toolbar : "#itemClass_manage_tool",
		columns : [[
			{
				field : "classId",
				title : "商品分类id",
				width : 70,
			},
			{
				field : "className",
				title : "商品类别名称",
				width : 140,
			},
		]],
	});

	$("#itemClassEditDiv").dialog({
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
				if ($("#itemClassEditForm").form("validate")) {
					//验证表单 
					if(!$("#itemClassEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#itemClassEditForm").form({
						    url:"ItemClass/" + $("#itemClass_classId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#itemClassEditForm").form("validate"))  {
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
			                        $("#itemClassEditDiv").dialog("close");
			                        itemClass_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#itemClassEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#itemClassEditDiv").dialog("close");
				$("#itemClassEditForm").form("reset"); 
			},
		}],
	});
});

function initItemClassManageTool() {
	itemClass_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#itemClass_manage").datagrid("reload");
		},
		redo : function () {
			$("#itemClass_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#itemClass_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#itemClassQueryForm").form({
			    url:"ItemClass/OutToExcel",
			});
			//提交表单
			$("#itemClassQueryForm").submit();
		},
		remove : function () {
			var rows = $("#itemClass_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var classIds = [];
						for (var i = 0; i < rows.length; i ++) {
							classIds.push(rows[i].classId);
						}
						$.ajax({
							type : "POST",
							url : "ItemClass/deletes",
							data : {
								classIds : classIds.join(","),
							},
							beforeSend : function () {
								$("#itemClass_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#itemClass_manage").datagrid("loaded");
									$("#itemClass_manage").datagrid("load");
									$("#itemClass_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#itemClass_manage").datagrid("loaded");
									$("#itemClass_manage").datagrid("load");
									$("#itemClass_manage").datagrid("unselectAll");
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
			var rows = $("#itemClass_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "ItemClass/" + rows[0].classId +  "/update",
					type : "get",
					data : {
						//classId : rows[0].classId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (itemClass, response, status) {
						$.messager.progress("close");
						if (itemClass) { 
							$("#itemClassEditDiv").dialog("open");
							$("#itemClass_classId_edit").val(itemClass.classId);
							$("#itemClass_classId_edit").validatebox({
								required : true,
								missingMessage : "请输入商品分类id",
								editable: false
							});
							$("#itemClass_className_edit").val(itemClass.className);
							$("#itemClass_className_edit").validatebox({
								required : true,
								missingMessage : "请输入商品类别名称",
							});
							$("#itemClass_classDesc_edit").val(itemClass.classDesc);
							$("#itemClass_classDesc_edit").validatebox({
								required : true,
								missingMessage : "请输入类别描述",
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
