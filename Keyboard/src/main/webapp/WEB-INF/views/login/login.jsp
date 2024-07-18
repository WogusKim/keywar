<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
const info =  document.getElementById('info');

div.addEventListener('mouseover', (event) => {
	  result.innerHTML+= '<div>mouseover</div>';
	});
div.addEventListener('mouseout', (event) => {
	  result.innerHTML+= '<div>mouseout</div>';
	});



function submitForm() {
    document.getElementById('loginForm').submit();
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
	<h1 style ="margin-top:50px;">로그인</h1>
<span> <img alt="초기 비밀번호 안내" src="${pageContext.request.contextPath}/resources/images/info.png" style="float: right; margin-right: 50px;" >   <a href="./findPassword" style="float: right; margin-right: 10px; color: gray;" id="info">비밀번호 변경</a></span>
<br>


	<form action="./loginAction" method="post" id="loginForm">
		<span class="input_text">직원번호</span> <input type="text" class="inputText" placeholder="직원번호를 입력하세요" name="userno" id="userno" />  <br> 
		<span class="input_text">비밀번호</span>  <input type="password" class="inputText"  placeholder="비밀번호를 입력하세요" name="userpw" id="userpw"/> <br>
		<input type="button" value="로그인" class="loginButton" onclick="submitForm()">
	</form>


		</div>
	</div>

</body>
</html>