$(function () {
	$.ajax({
		url : "ProductBidding/" + $("#productBidding_biddingId_edit").val() + "/update",
		type : "get",
		data : {
			//biddingId : $("#productBidding_biddingId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (productBidding, response, status) {
			$.messager.progress("close");
			if (productBidding) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#productBiddingModifyButton").click(function(){ 
		if ($("#productBiddingEditForm").form("validate")) {
			$("#productBiddingEditForm").form({
			    url:"ProductBidding/" +  $("#productBidding_biddingId_edit").val() + "/update",
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
			$("#productBiddingEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
