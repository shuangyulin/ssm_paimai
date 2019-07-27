$(function () {
	$.ajax({
		url : "UserFollow/" + $("#userFollow_followId_edit").val() + "/update",
		type : "get",
		data : {
			//followId : $("#userFollow_followId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (userFollow, response, status) {
			$.messager.progress("close");
			if (userFollow) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#userFollowModifyButton").click(function(){ 
		if ($("#userFollowEditForm").form("validate")) {
			$("#userFollowEditForm").form({
			    url:"UserFollow/" +  $("#userFollow_followId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#userFollowEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
