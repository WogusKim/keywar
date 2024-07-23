<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 비밀번호 재설정</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />

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



document.addEventListener('DOMContentLoaded', function() {
    checkAndRedirect();
});

function checkAndRedirect() {
    const valueToCheck = $("#key").val()

    // 조건을 확인
    if (valueToCheck != 'itiscorrect') {
        window.location.href = '${pageContext.request.contextPath}/login';
        alert("잘못된 접근, 로그인 페이지로 이동합니다.")
    }
}



</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>
<div style="
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%; ">
<div class="fullContent">
	<h1 style ="margin-top:50px; ">새로운 비밀번호 설정 </h1>
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
		<input type="hidden" value="${userdto.userno}" name="userno" id="userno"/>
		<input type="hidden" id="key" name="key" value="${pagedto.key}" />
	</form>
		</div>
	</div>

</body>
</html>