$(function () {
	$("#userFollow_userObj1_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#userFollow_userObj1_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#userFollow_userObj1_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#userFollow_userObj2_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#userFollow_userObj2_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#userFollow_userObj2_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#userFollow_followTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#userFollowAddButton").click(function () {
		//验证表单 
		if(!$("#userFollowAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#userFollowAddForm").form({
			    url:"UserFollow/add",
			    onSubmit: function(){
					if($("#userFollowAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#userFollowAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#userFollowAddForm").submit();
		}
	});

	//单击清空按钮
	$("#userFollowClearButton").click(function () { 
		$("#userFollowAddForm").form("clear"); 
	});
});
