<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productBidding.css" />
<div id="productBiddingAddDiv">
	<form id="productBiddingAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">竞拍商品:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_itemObj_itemId" name="productBidding.itemObj.itemId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">竞拍用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_userObj_user_name" name="productBidding.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">竞拍时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_biddingTime" name="productBidding.biddingTime" />

			</span>

		</div>
		<div>
			<span class="label">竞拍出价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_biddingPrice" name="productBidding.biddingPrice" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="productBiddingAddButton" class="easyui-linkbutton">添加</a>
			<a id="productBiddingClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ProductBidding/js/productBidding_add.js"></script> 
