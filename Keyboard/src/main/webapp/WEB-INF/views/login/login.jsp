<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 로그인</title>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
const info =  document.getElementById('info');

/* div.addEventListener('mouseover', (event) => {
	  result.innerHTML+= '<div>mouseover</div>';
	});
div.addEventListener('mouseout', (event) => {
	  result.innerHTML+= '<div>mouseout</div>';
	}); */



function submitForm() {
   // document.getElementById('loginForm').submit();
}

</script>
</head>
<body>
<script>
// 문서에서 키가 눌렸을 때 이벤트 핸들러
document.onkeydown = function(event) {
    // 엔터 키 코드 확인
    if (event.key === 'Enter') {
        event.preventDefault(); // 기본 동작 방지 (폼 제출 방지)
        getLogin();
    }
}


function getLogin(){
	var userno = $("input#userno").val();
	var userpw = $("input#userpw").val();

	
    fetch('${pageContext.request.contextPath}/getLogin', {   
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
        	userno : userno,
            userpw : userpw
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        if(data.status == "success"){
        	alert(data.username + "님 환영합니다.");
        	window.location.href =  "${pageContext.request.contextPath}/main";
        }else if(data.status == "userpwIncorrect"){
        	alert("잘못된 비밀번호입니다.");
        	$("input#userpw").val("");
        	$("input#userpw").focus();
        }else if(data.status == "firstLogin"){
        	alert("비밀번호 초기 설정 상태입니다. 비밀번호 변경이 필요합니다.");
        	$("#loginForm").submit();
        } else if(data.status == "usernoIncorrect"){
        	alert("잘못된 직원번호입니다.");
        } 
        	
    })
    .catch((error) => {
        console.error('Error:', error);
    });
    

    
}
</script>
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


	<form action="${pageContext.request.contextPath}/resetPassword" method="post" id="loginForm">
		<span class="input_text">직원번호</span> <input type="text" class="inputText" placeholder="직원번호를 입력하세요" name="userno" id="userno" />  <br> 
		<span class="input_text">비밀번호</span>  <input type="password" class="inputText"  placeholder="비밀번호를 입력하세요" name="userpw" id="userpw"/> <br>
		<input type="button" value="로그인" class="loginButton" onclick="getLogin()">
	</form>


		</div>
	</div>

</body>
</html>