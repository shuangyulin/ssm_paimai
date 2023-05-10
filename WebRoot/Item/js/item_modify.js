$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('item_itemDesc_edit');
	var item_itemDesc_edit = UE.getEditor('item_itemDesc_edit'); //商品描述编辑器
	item_itemDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Item/" + $("#item_itemId_edit").val() + "/update",
		type : "get",
		data : {
			//itemId : $("#item_itemId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (item, response, status) {
			$.messager.progress("close");
			if (item) { 
				$("#item_itemId_edit").val(item.itemId);
				$("#item_itemId_edit").validatebox({
					required : true,
					missingMessage : "请输入商品id",
					editable: false
				});
				$("#item_itemClassObj_classId_edit").combobox({
					url:"ItemClass/listAll",
					valueField:"classId",
					textField:"className",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#item_itemClassObj_classId_edit").combobox("select", item.itemClassObjPri);
						//var data = $("#item_itemClassObj_classId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#item_itemClassObj_classId_edit").combobox("select", data[0].classId);
						//}
					}
				});
				$("#item_pTitle_edit").val(item.pTitle);
				$("#item_pTitle_edit").validatebox({
					required : true,
					missingMessage : "请输入商品标题",
				});
				$("#item_itemPhoto").val(item.itemPhoto);
				$("#item_itemPhotoImg").attr("src", item.itemPhoto);
				item_itemDesc_edit.setContent(item.itemDesc);
				$("#item_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#item_userObj_user_name_edit").combobox("select", item.userObjPri);
						//var data = $("#item_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#item_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#item_startPrice_edit").val(item.startPrice);
				$("#item_startPrice_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入起拍价",
					invalidMessage : "起拍价输入不对",
				});
				$("#item_startTime_edit").datetimebox({
					value: item.startTime,
					required: true,
					showSeconds: true,
				});
				$("#item_endTime_edit").datetimebox({
					value: item.endTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#itemModifyButton").click(function(){ 
		if ($("#itemEditForm").form("validate")) {
			$("#itemEditForm").form({
			    url:"Item/" +  $("#item_itemId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#itemEditForm").form("validate"))  {
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
			$("#itemEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
