<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userInfo.css" />
<div id="userInfo_editDiv">
	<form id="userInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">用户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_user_name_edit" name="userInfo.user_name" value="<%=request.getParameter("user_name") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_password_edit" name="userInfo.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_name_edit" name="userInfo.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_gender_edit" name="userInfo.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">生日:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_birthDate_edit" name="userInfo.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">用户照片:</span>
			<span class="inputControl">
				<img id="userInfo_userImageImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="userInfo_userImage" name="userInfo.userImage"/>
				<input id="userImageFile" name="userImageFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_telephone_edit" name="userInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在城市:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_city_edit" name="userInfo.city" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_address_edit" name="userInfo.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">邮箱:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_email_edit" name="userInfo.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">paypal账户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_paypalAccount_edit" name="userInfo.paypalAccount" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">注册时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_createTime_edit" name="userInfo.createTime" />

			</span>

		</div>
		<div class="operation">
			<a id="userInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/UserInfo/js/userInfo_modify.js"></script> 
