<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 비밀번호 변경</title>
<style>
	body{
	background-image: url(${pageContext.request.contextPath}/resources/images/background.jpg);
	background-repeat : no-repeat;
	background-size : cover;
	text-align: center;
	}
	
</style>

<script>
function submitForm() {
    document.getElementById('findPwForm').submit();
}

function checkInfo() {
 	 var promoCode = $("#userno").val();
 	 console.log(promoCode);
 	 console.log(typeof(promoCode));
 	 	fetch('${pageContext.request.contextPath}/findPw',{   
 	 		
 	 		method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
            	
                userno: promoCode,
                phoneno: $("#phoneno").val(),
                mail: $("#mail").val()
            })
 	 	})
 	 	
	    .then(response => {
	        if (!response.ok) {
	            throw new Error('Network response was not ok');
	        }
	        return response.json();
	    })
	    .then(result => {
	        console.log(result);
	        // 여기서 가져온 데이터를 처리할 수 있습니다.
	        if(result.userno!=null){
	        	alert("정보가 정상적으로 확인되었습니다.");
	        	 $("#key").val("itiscorrect")
	        	 submitForm();
	        }else{
	        	alert("입력하신 정보가 등록된 정보와 일치하지 않습니다.");
	        }
	    })
	    .catch(error => {
	        console.error('Fetch Error:', error);
	        // 에러 처리 로직을 추가할 수 있습니다.
	    });
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
<div class="fullContent" >
	<h1 style ="margin-top:50px;">비밀번호 찾기</h1>

	<form action="${pageContext.request.contextPath}/setNewPassword" method="post" id="findPwForm" style="height: 100%">
	<table style="width: 80%; margin: auto; height: 60%;">
	<tr>
	<td style="width:20%;"><span class="input_text"> 직원번호</span> </td><td style="width:40%;"><input type="text" class="inputText1" placeholder="직원번호를 입력하세요" name="userno" id="userno"/></td>
	</tr>
	<tr>
	<td><span class="input_text"> 핸드폰번호</span> </td><td><input type="text" class="inputText1" placeholder="핸드폰 번호를 입력하세요" name="phoneno" id="phoneno" /></td>
	</tr>
	<tr>
	<td><span class="input_text">이메일</span> </td><td><input type="text" class="inputText1" placeholder="이메일 주소를 입력하세요"  name="mail" id="mail" /></td>
	</tr>
	<tr>
		<td colspan="2"><input type="button" value="비밀번호 찾기" class="loginButton" onclick="checkInfo()" style="width: 35%;"> </td>
	</tr>
	</table>
	<input type="hidden" id="key" name="key" value="itisuncorrect" />
	</form>

</div>
</div>
<script>


</script>


</body>
</html>