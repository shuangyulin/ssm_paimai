$(function () {
	$("#productBidding_itemObj_itemId").combobox({
	    url:'Item/listAll',
	    valueField: "itemId",
	    textField: "pTitle",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#productBidding_itemObj_itemId").combobox("getData"); 
            if (data.length > 0) {
                $("#productBidding_itemObj_itemId").combobox("select", data[0].itemId);
            }
        }
	});
	$("#productBidding_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#productBidding_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#productBidding_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#productBidding_biddingTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#productBidding_biddingPrice").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入竞拍出价',
		invalidMessage : '竞拍出价输入不对',
	});

	//单击添加按钮
	$("#productBiddingAddButton").click(function () {
		//验证表单 
		if(!$("#productBiddingAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#productBiddingAddForm").form({
			    url:"ProductBidding/add",
			    onSubmit: function(){
					if($("#productBiddingAddForm").form("validate"))  { 
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
                        $("#productBiddingAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#productBiddingAddForm").submit();
		}
	});

	//单击清空按钮
	$("#productBiddingClearButton").click(function () { 
		$("#productBiddingAddForm").form("clear"); 
	});
});
