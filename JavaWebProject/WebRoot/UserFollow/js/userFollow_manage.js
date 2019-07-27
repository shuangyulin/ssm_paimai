var userFollow_manage_tool = null; 
$(function () { 
	initUserFollowManageTool(); //建立UserFollow管理对象
	userFollow_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#userFollow_manage").datagrid({
		url : 'UserFollow/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "followId",
		sortOrder : "desc",
		toolbar : "#userFollow_manage_tool",
		columns : [[
			{
				field : "followId",
				title : "记录id",
				width : 70,
			},
			{
				field : "userObj1",
				title : "被关注人",
				width : 140,
			},
			{
				field : "userObj2",
				title : "关注人",
				width : 140,
			},
			{
				field : "followTime",
				title : "关注时间",
				width : 140,
			},
		]],
	});

	$("#userFollowEditDiv").dialog({
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
				if ($("#userFollowEditForm").form("validate")) {
					//验证表单 
					if(!$("#userFollowEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#userFollowEditForm").form({
						    url:"UserFollow/" + $("#userFollow_followId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#userFollowEditForm").form("validate"))  {
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
			                        $("#userFollowEditDiv").dialog("close");
			                        userFollow_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#userFollowEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#userFollowEditDiv").dialog("close");
				$("#userFollowEditForm").form("reset"); 
			},
		}],
	});
});

function initUserFollowManageTool() {
	userFollow_manage_tool = {
		init: function() {
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj1_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj1_user_name_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj2_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj2_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#userFollow_manage").datagrid("reload");
		},
		redo : function () {
			$("#userFollow_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#userFollow_manage").datagrid("options").queryParams;
			queryParams["userObj1.user_name"] = $("#userObj1_user_name_query").combobox("getValue");
			queryParams["userObj2.user_name"] = $("#userObj2_user_name_query").combobox("getValue");
			queryParams["followTime"] = $("#followTime").datebox("getValue"); 
			$("#userFollow_manage").datagrid("options").queryParams=queryParams; 
			$("#userFollow_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#userFollowQueryForm").form({
			    url:"UserFollow/OutToExcel",
			});
			//提交表单
			$("#userFollowQueryForm").submit();
		},
		remove : function () {
			var rows = $("#userFollow_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var followIds = [];
						for (var i = 0; i < rows.length; i ++) {
							followIds.push(rows[i].followId);
						}
						$.ajax({
							type : "POST",
							url : "UserFollow/deletes",
							data : {
								followIds : followIds.join(","),
							},
							beforeSend : function () {
								$("#userFollow_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#userFollow_manage").datagrid("loaded");
									$("#userFollow_manage").datagrid("load");
									$("#userFollow_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#userFollow_manage").datagrid("loaded");
									$("#userFollow_manage").datagrid("load");
									$("#userFollow_manage").datagrid("unselectAll");
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
			var rows = $("#userFollow_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "UserFollow/" + rows[0].followId +  "/update",
					type : "get",
					data : {
						//followId : rows[0].followId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (userFollow, response, status) {
						$.messager.progress("close");
						if (userFollow) { 
							$("#userFollowEditDiv").dialog("open");
							$("#userFollow_followId_edit").val(userFollow.followId);
							$("#userFollow_followId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录id",
								editable: false
							});
							$("#userFollow_userObj1_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#userFollow_userObj1_user_name_edit").combobox("select", userFollow.userObj1Pri);
									//var data = $("#userFollow_userObj1_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#userFollow_userObj1_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#userFollow_userObj2_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#userFollow_userObj2_user_name_edit").combobox("select", userFollow.userObj2Pri);
									//var data = $("#userFollow_userObj2_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#userFollow_userObj2_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#userFollow_followTime_edit").datetimebox({
								value: userFollow.followTime,
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
