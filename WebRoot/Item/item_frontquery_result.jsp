<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Item" %>
<%@ page import="com.chengxusheji.po.ItemClass" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Item> itemList = (List<Item>)request.getAttribute("itemList");
    //获取所有的itemClassObj信息
    List<ItemClass> itemClassList = (List<ItemClass>)request.getAttribute("itemClassList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    ItemClass itemClassObj = (ItemClass)request.getAttribute("itemClassObj");
    String pTitle = (String)request.getAttribute("pTitle"); //商品标题查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String startTime = (String)request.getAttribute("startTime"); //起拍时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>商品查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Item/frontlist">商品信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Item/item_frontAdd.jsp" style="display:none;">添加商品</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<itemList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Item item = itemList.get(i); //获取到商品对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Item/<%=item.getItemId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=item.getItemPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		商品分类:<%=item.getItemClassObj().getClassName() %>
			     	</div>
			     	<div class="field">
	            		商品标题:<%=item.getPTitle() %>
			     	</div>
			     	<div class="field">
	            		发布人:<%=item.getUserObj().getName() %>
			     	</div>
			     	<div class="field">
	            		起拍价:<%=item.getStartPrice() %>
			     	</div>
			     	<div class="field">
	            		起拍时间:<%=item.getStartTime() %>
			     	</div>
			     	<div class="field">
	            		结束时间:<%=item.getEndTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Item/<%=item.getItemId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="itemEdit('<%=item.getItemId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="itemDelete('<%=item.getItemId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>商品查询</h1>
		</div>
		<form name="itemQueryForm" id="itemQueryForm" action="<%=basePath %>Item/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="itemClassObj_classId">商品分类：</label>
                <select id="itemClassObj_classId" name="itemClassObj.classId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(ItemClass itemClassTemp:itemClassList) {
	 					String selected = "";
 					if(itemClassObj!=null && itemClassObj.getClassId()!=null && itemClassObj.getClassId().intValue()==itemClassTemp.getClassId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=itemClassTemp.getClassId() %>" <%=selected %>><%=itemClassTemp.getClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="pTitle">商品标题:</label>
				<input type="text" id="pTitle" name="pTitle" value="<%=pTitle %>" class="form-control" placeholder="请输入商品标题">
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">发布人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="startTime">起拍时间:</label>
				<input type="text" id="startTime" name="startTime" class="form-control"  placeholder="请选择起拍时间" value="<%=startTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="itemEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;商品信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="item.itemDesc" id="item_itemDesc_edit" style="width:100%;height:500px;"></textarea>
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
		</form> 
	    <style>#itemEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxItemModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
//实例化编辑器
var item_itemDesc_edit = UE.getEditor('item_itemDesc_edit'); //商品描述编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.itemQueryForm.currentPage.value = currentPage;
    document.itemQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.itemQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.itemQueryForm.currentPage.value = pageValue;
    documentitemQueryForm.submit();
}

/*弹出修改商品界面并初始化数据*/
function itemEdit(itemId) {
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
				item_itemDesc_edit.setContent(item.itemDesc, false);
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
				$('#itemEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除商品信息*/
function itemDelete(itemId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Item/deletes",
			data : {
				itemIds : itemId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#itemQueryForm").submit();
					//location.href= basePath + "Item/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

