<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productBidding.css" />
<div id="productBidding_editDiv">
	<form id="productBiddingEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_biddingId_edit" name="productBidding.biddingId" value="<%=request.getParameter("biddingId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">竞拍商品:</span>
			<span class="inputControl">
				<input class="textbox"  id="productBidding_itemObj_itemId_edit" name="productBidding.itemObj.itemId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">竞拍用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="productBidding_userObj_user_name_edit" name="productBidding.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">竞拍时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_biddingTime_edit" name="productBidding.biddingTime" />

			</span>

		</div>
		<div>
			<span class="label">竞拍出价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="productBidding_biddingPrice_edit" name="productBidding.biddingPrice" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="productBiddingModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ProductBidding/js/productBidding_modify.js"></script> 
