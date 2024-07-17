<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 로그인</title>
<style>
body {
	background-image:
		url(${pageContext.request.contextPath}/resources/images/background.jpg);
	background-repeat: no-repeat;
	background-size: cover;
	text-align: center;
}
</style>
<script>

function checkPw(){
	if($("#userpw").val()==$("#pw2").val()){
		alert("비밀번호가 정상적으로 등록되었습니다.");
		 submitForm();
	}else{
		alert("비밀번호가 서로 다릅니다.");
	}
}

function submitForm() {
    document.getElementById('resetPasswordForm').submit();
}
</script>
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>
<div style="
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%; ">
<div class="fullContent">
	<h1 style ="margin-top:50px; ">최초 비밀번호 설정 </h1>
<span>사용하실 비밀번호를 입력하세요.</span><br>
	<form action="./resetPasswordAction" method="post" id="resetPasswordForm" >
	<table style="width: 80%; margin: auto;">
	<tr>
	<td style="width: 20%"><span class="input_text">비밀번호</span></td><td style="width: 40%"> <input type="password" class="inputText1" placeholder=" 사용하실 비밀번호를 입력하세요" name="userpw" id="userpw" /></td>
	</tr>
	<tr>
	<td><span class="input_text">비밀번호 확인</span> </td><td> <input type="password" class="inputText1"  placeholder=" 다시 한 번 비밀번호를 입력하세요" name="pw2" id="pw2"/></td>
	</tr>
	</table>
		 <br>
		<input type="button" value="비밀번호 설정" class="loginButton" onclick="checkPw()">
		<input type="hidden" value="${userno.userno}" name="userno" id="userno"/>
	</form>
		</div>
	</div>

</body>
</html>