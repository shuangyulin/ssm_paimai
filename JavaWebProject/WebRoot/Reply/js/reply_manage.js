var reply_manage_tool = null; 
$(function () { 
	initReplyManageTool(); //建立Reply管理对象
	reply_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#reply_manage").datagrid({
		url : 'Reply/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "replyId",
		sortOrder : "desc",
		toolbar : "#reply_manage_tool",
		columns : [[
			{
				field : "replyId",
				title : "回复id",
				width : 70,
			},
			{
				field : "postInfoObj",
				title : "被回帖子",
				width : 140,
			},
			{
				field : "content",
				title : "回复内容",
				width : 140,
			},
			{
				field : "userObj",
				title : "回复人",
				width : 140,
			},
			{
				field : "replyTime",
				title : "回复时间",
				width : 140,
			},
		]],
	});

	$("#replyEditDiv").dialog({
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
				if ($("#replyEditForm").form("validate")) {
					//验证表单 
					if(!$("#replyEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#replyEditForm").form({
						    url:"Reply/" + $("#reply_replyId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#replyEditForm").form("validate"))  {
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
			                        $("#replyEditDiv").dialog("close");
			                        reply_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#replyEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#replyEditDiv").dialog("close");
				$("#replyEditForm").form("reset"); 
			},
		}],
	});
});

function initReplyManageTool() {
	reply_manage_tool = {
		init: function() {
			$.ajax({
				url : "PostInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#postInfoObj_postInfoId_query").combobox({ 
					    valueField:"postInfoId",
					    textField:"pTitle",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{postInfoId:0,pTitle:"不限制"});
					$("#postInfoObj_postInfoId_query").combobox("loadData",data); 
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
			$("#reply_manage").datagrid("reload");
		},
		redo : function () {
			$("#reply_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#reply_manage").datagrid("options").queryParams;
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["replyTime"] = $("#replyTime").datebox("getValue"); 
			queryParams["postInfoObj.postInfoId"] = $("#postInfoObj_postInfoId_query").combobox("getValue");
			$("#reply_manage").datagrid("options").queryParams=queryParams; 
			$("#reply_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#replyQueryForm").form({
			    url:"Reply/OutToExcel",
			});
			//提交表单
			$("#replyQueryForm").submit();
		},
		remove : function () {
			var rows = $("#reply_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var replyIds = [];
						for (var i = 0; i < rows.length; i ++) {
							replyIds.push(rows[i].replyId);
						}
						$.ajax({
							type : "POST",
							url : "Reply/deletes",
							data : {
								replyIds : replyIds.join(","),
							},
							beforeSend : function () {
								$("#reply_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#reply_manage").datagrid("loaded");
									$("#reply_manage").datagrid("load");
									$("#reply_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#reply_manage").datagrid("loaded");
									$("#reply_manage").datagrid("load");
									$("#reply_manage").datagrid("unselectAll");
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
			var rows = $("#reply_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Reply/" + rows[0].replyId +  "/update",
					type : "get",
					data : {
						//replyId : rows[0].replyId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (reply, response, status) {
						$.messager.progress("close");
						if (reply) { 
							$("#replyEditDiv").dialog("open");
							$("#reply_replyId_edit").val(reply.replyId);
							$("#reply_replyId_edit").validatebox({
								required : true,
								missingMessage : "请输入回复id",
								editable: false
							});
							$("#reply_postInfoObj_postInfoId_edit").combobox({
								url:"PostInfo/listAll",
							    valueField:"postInfoId",
							    textField:"pTitle",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#reply_postInfoObj_postInfoId_edit").combobox("select", reply.postInfoObjPri);
									//var data = $("#reply_postInfoObj_postInfoId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#reply_postInfoObj_postInfoId_edit").combobox("select", data[0].postInfoId);
						            //}
								}
							});
							$("#reply_content_edit").val(reply.content);
							$("#reply_content_edit").validatebox({
								required : true,
								missingMessage : "请输入回复内容",
							});
							$("#reply_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#reply_userObj_user_name_edit").combobox("select", reply.userObjPri);
									//var data = $("#reply_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#reply_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#reply_replyTime_edit").datetimebox({
								value: reply.replyTime,
							    required: true,
							    showSeconds: true,
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
