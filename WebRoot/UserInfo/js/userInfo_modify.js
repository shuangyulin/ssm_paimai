$(function () {
	$.ajax({
		url : "UserInfo/" + $("#userInfo_user_name_edit").val() + "/update",
		type : "get",
		data : {
			//user_name : $("#userInfo_user_name_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (userInfo, response, status) {
			$.messager.progress("close");
			if (userInfo) { 
				$("#userInfo_user_name_edit").val(userInfo.user_name);
				$("#userInfo_user_name_edit").validatebox({
					required : true,
					missingMessage : "请输入用户名",
					editable: false
				});
				$("#userInfo_password_edit").val(userInfo.password);
				$("#userInfo_password_edit").validatebox({
					required : true,
					missingMessage : "请输入登录密码",
				});
				$("#userInfo_name_edit").val(userInfo.name);
				$("#userInfo_name_edit").validatebox({
					required : true,
					missingMessage : "请输入姓名",
				});
				$("#userInfo_gender_edit").val(userInfo.gender);
				$("#userInfo_gender_edit").validatebox({
					required : true,
					missingMessage : "请输入性别",
				});
				$("#userInfo_birthDate_edit").datebox({
					value: userInfo.birthDate,
					required: true,
					showSeconds: true,
				});
				$("#userInfo_userImage").val(userInfo.userImage);
				$("#userInfo_userImageImg").attr("src", userInfo.userImage);
				$("#userInfo_telephone_edit").val(userInfo.telephone);
				$("#userInfo_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				$("#userInfo_city_edit").val(userInfo.city);
				$("#userInfo_city_edit").validatebox({
					required : true,
					missingMessage : "请输入所在城市",
				});
				$("#userInfo_address_edit").val(userInfo.address);
				$("#userInfo_address_edit").validatebox({
					required : true,
					missingMessage : "请输入家庭地址",
				});
				$("#userInfo_email_edit").val(userInfo.email);
				$("#userInfo_paypalAccount_edit").val(userInfo.paypalAccount);
				$("#userInfo_paypalAccount_edit").validatebox({
					required : true,
					missingMessage : "请输入paypal账户名",
				});
				$("#userInfo_createTime_edit").datetimebox({
					value: userInfo.createTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#userInfoModifyButton").click(function(){ 
		if ($("#userInfoEditForm").form("validate")) {
			$("#userInfoEditForm").form({
			    url:"UserInfo/" +  $("#userInfo_user_name_edit").val() + "/update",
			    onSubmit: function(){
					if($("#userInfoEditForm").form("validate"))  {
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
			$("#userInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
