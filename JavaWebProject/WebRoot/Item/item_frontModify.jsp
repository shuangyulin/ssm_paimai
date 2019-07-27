<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Item" %>
<%@ page import="com.chengxusheji.po.ItemClass" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的itemClassObj信息
    List<ItemClass> itemClassList = (List<ItemClass>)request.getAttribute("itemClassList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Item item = (Item)request.getAttribute("item");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改商品信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">商品信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="itemEditForm" id="itemEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="item_itemId_edit" class="col-md-3 text-right">商品id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="item_itemId_edit" name="item.itemId" class="form-control" placeholder="请输入商品id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="item_itemClassObj_classId_edit" class="col-md-3 text-right">商品分类:</label>
		  	 <div class="col-md-9">
			    <select id="item_itemClassObj_classId_edit" name="item.itemClassObj.classId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_pTitle_edit" class="col-md-3 text-right">商品标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="item_pTitle_edit" name="item.pTitle" class="form-control" placeholder="请输入商品标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_itemPhoto_edit" class="col-md-3 text-right">商品图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="item_itemPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="item_itemPhoto" name="item.itemPhoto"/>
			    <input id="itemPhotoFile" name="itemPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_itemDesc_edit" class="col-md-3 text-right">商品描述:</label>
		  	 <div class="col-md-9">
			    <script name="item.itemDesc" id="item_itemDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_userObj_user_name_edit" class="col-md-3 text-right">发布人:</label>
		  	 <div class="col-md-9">
			    <select id="item_userObj_user_name_edit" name="item.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_startPrice_edit" class="col-md-3 text-right">起拍价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="item_startPrice_edit" name="item.startPrice" class="form-control" placeholder="请输入起拍价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_startTime_edit" class="col-md-3 text-right">起拍时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date item_startTime_edit col-md-12" data-link-field="item_startTime_edit">
                    <input class="form-control" id="item_startTime_edit" name="item.startTime" size="16" type="text" value="" placeholder="请选择起拍时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="item_endTime_edit" class="col-md-3 text-right">结束时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date item_endTime_edit col-md-12" data-link-field="item_endTime_edit">
                    <input class="form-control" id="item_endTime_edit" name="item.endTime" size="16" type="text" value="" placeholder="请选择结束时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxItemModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#itemEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var item_itemDesc_editor = UE.getEditor('item_itemDesc_edit'); //商品描述编辑框
var basePath = "<%=basePath%>";
/*弹出修改商品界面并初始化数据*/
function itemEdit(itemId) {
  item_itemDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(itemId);
  });
}
 function ajaxModifyQuery(itemId) {
	$.ajax({
		url :  basePath + "Item/" + itemId + "/update",
		type : "get",
		dataType: "json",
		success : function (item, response, status) {
			if (item) {
				$("#item_itemId_edit").val(item.itemId);
				$.ajax({
					url: basePath + "ItemClass/listAll",
					type: "get",
					success: function(itemClasss,response,status) { 
						$("#item_itemClassObj_classId_edit").empty();
						var html="";
		        		$(itemClasss).each(function(i,itemClass){
		        			html += "<option value='" + itemClass.classId + "'>" + itemClass.className + "</option>";
		        		});
		        		$("#item_itemClassObj_classId_edit").html(html);
		        		$("#item_itemClassObj_classId_edit").val(item.itemClassObjPri);
					}
				});
				$("#item_pTitle_edit").val(item.pTitle);
				$("#item_itemPhoto").val(item.itemPhoto);
				$("#item_itemPhotoImg").attr("src", basePath +　item.itemPhoto);
				item_itemDesc_editor.setContent(item.itemDesc, false);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#item_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#item_userObj_user_name_edit").html(html);
		        		$("#item_userObj_user_name_edit").val(item.userObjPri);
					}
				});
				$("#item_startPrice_edit").val(item.startPrice);
				$("#item_startTime_edit").val(item.startTime);
				$("#item_endTime_edit").val(item.endTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交商品信息表单给服务器端修改*/
function ajaxItemModify() {
	$.ajax({
		url :  basePath + "Item/" + $("#item_itemId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#itemEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#itemQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*起拍时间组件*/
    $('.item_startTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*结束时间组件*/
    $('.item_endTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    itemEdit("<%=request.getParameter("itemId")%>");
 })
 </script> 
</body>
</html>

