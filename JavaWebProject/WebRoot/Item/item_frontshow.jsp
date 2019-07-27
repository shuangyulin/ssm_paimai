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
  <TITLE>查看商品详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Item/frontlist">商品信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品id:</div>
		<div class="col-md-10 col-xs-6"><%=item.getItemId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品分类:</div>
		<div class="col-md-10 col-xs-6"><%=item.getItemClassObj().getClassName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品标题:</div>
		<div class="col-md-10 col-xs-6"><%=item.getPTitle()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品图片:</div>
		<div class="col-md-10 col-xs-6"><img class="img-responsive" src="<%=basePath %><%=item.getItemPhoto() %>"  border="0px"/></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品描述:</div>
		<div class="col-md-10 col-xs-6"><%=item.getItemDesc()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">发布人:</div>
		<div class="col-md-10 col-xs-6"><%=item.getUserObj().getName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">起拍价:</div>
		<div class="col-md-10 col-xs-6"><%=item.getStartPrice()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">起拍时间:</div>
		<div class="col-md-10 col-xs-6"><%=item.getStartTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">结束时间:</div>
		<div class="col-md-10 col-xs-6"><%=item.getEndTime()%></div>
	</div>
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="history.back();" class="btn btn-primary">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 </script> 
</body>
</html>

