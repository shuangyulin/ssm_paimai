$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('item_itemDesc');
	var item_itemDesc_editor = UE.getEditor('item_itemDesc'); //商品描述编辑框
	$("#item_itemClassObj_classId").combobox({
	    url:'ItemClass/listAll',
	    valueField: "classId",
	    textField: "className",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#item_itemClassObj_classId").combobox("getData"); 
            if (data.length > 0) {
                $("#item_itemClassObj_classId").combobox("select", data[0].classId);
            }
        }
	});
	$("#item_pTitle").validatebox({
		required : true, 
		missingMessage : '请输入商品标题',
	});

	$("#item_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#item_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#item_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#item_startPrice").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入起拍价',
		invalidMessage : '起拍价输入不对',
	});

	$("#item_startTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#item_endTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#itemAddButton").click(function () {
		if(item_itemDesc_editor.getContent() == "") {
			alert("请输入商品描述");
			return;
		}
		//验证表单 
		if(!$("#itemAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#itemAddForm").form({
			    url:"Item/add",
			    onSubmit: function(){
					if($("#itemAddForm").form("validate"))  { 
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
                        $("#itemAddForm").form("clear");
                        item_itemDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#itemAddForm").submit();
		}
	});

	//单击清空按钮
	$("#itemClearButton").click(function () { 
		$("#itemAddForm").form("clear"); 
	});
});
