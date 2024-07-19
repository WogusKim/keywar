<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 마이페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/display.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.imageEditButton{
	background-color: #EBF8FE;
	border-radius: 10px;
	border: none;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
	margin : 5px;
	font-size: 15px;
	width: 130px;
	height: 30px;
	cursor: pointer;
	font-family: 'textL';
	margin-top : 15px;
}
.editBox{
	margin : auto;
	width : 30%;
/* 	background-color: #EBF8FE; */
	margin-top: 20px;

}
.editText{
	border:1px; 
/* 	background-color: #EBF8FE; */
	font-size: 20px;
	text-align: center;
	height: 40px;
	
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function changeNickname(){
	 var nickname = $("#nickname").val();
	 var userno = $("#userno").val();
 	 console.log(nickname);
 	 	fetch('${pageContext.request.contextPath}/changeNickname',{   
 	 		
 	 		method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
            	userno: userno,
                nickname: nickname
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
	        	alert("정상적으로 처리되었습니다.");	        	
	        }else{
	        	alert("변경 중 오류가 발생하였습니다.");
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

<div class="content_outline" style="height:  100%;">
	<%@ include file="/WEB-INF/views/sidebar.jsp" %>
	<div class="content_right" style="height:  90%;">
		<div class="board_currency">
			<div class="board_currency_inner" style="background-color: #92D1BA; ">
				<div class="outlineBox">
					<div style="float: left;"><h2 class="card_title">마이페이지 수정</h2></div><div style="float: right;">
					<a href="${pageContext.request.contextPath}/editProfile"> <img class="header_icon" style="margin-top: 5px;" src="${pageContext.request.contextPath}/resources/images/setting.png"> </a></div>
				</div>
				<hr>
				<div class="outlineBox" style="height: 85%">
				<div class="white_Box" style="width: 100%; text-align: center;"> 
				<div style="height: 15%;">
				</div>
				<div class="box" style="background: #BDBDBD; ">
    				<img class="profile" src="${pageContext.request.contextPath}/resources/images/background.jpg">
				</div>
				<button class=" imageEditButton ">프로필 사진 변경</button> <br>
				<div class="editBox"><span style="font-size: 20px;">별명 </span> <input type="text" value="${dto.username }" class="editText" id="nickname" name="nickname"/> </div>
				<button  class="imageEditButton" style="background-color: #92D1BA;" onclick="changeNickname()">저장하기</button>
								
				
				<div> </div>
				
				
				</div>
				
				</div>
				<input type="hidden" name="userno" id="userno" value="${dto.userno}" />
		
			</div>
		</div>

	</div>
</div>

</body>
</html>