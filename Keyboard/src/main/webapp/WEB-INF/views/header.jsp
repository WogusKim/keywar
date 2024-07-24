<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>
<style>
.alertSendTime{
color: gray; 
margin top: 0px;
}
.alerthr{
background:#CFCFCF;
height:1px;
border:0;
}
.alertContent{
width: 100%;
}
.alertContentArea{
width: 100%;
}
</style>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">


    <script>
   
    
    document.addEventListener('DOMContentLoaded', (event) => {
        const notifyButton = document.getElementById('notifyButton');
        const notifyButton1 = document.getElementById('notifyButton1');
        const notificationBox = document.getElementById('notificationBox');

        notifyButton.addEventListener('click', () => {
            if (notificationBox.style.display === 'none' || notificationBox.style.display === '') {
                notificationBox.style.display = 'block'; // 박스 보이기
                alarmOff();
            } else {
                notificationBox.style.display = 'none'; // 박스 숨기기 
            }
        });
        notifyButton1.addEventListener('click', () => {
            if (notificationBox.style.display === 'none' || notificationBox.style.display === '') {
                notificationBox.style.display = 'block'; // 박스 보이기
                alarmOff();
            } else {
                notificationBox.style.display = 'none'; // 박스 숨기기
            }
        });
    });
    
    function checkForNotifications() {
    	
    	
    	fetch(`${pageContext.request.contextPath}/ajaxNotification`, {
            method: 'GET', // HTTP 메서드 설정
            headers: {
                'Accept': 'application/json', // 서버로부터 JSON 형식의 응답을 기대
          //      'Content-Type': 'application/json; charset=utf-8' // 클라이언트가 JSON 형식으로 데이터를 보낼 것임을 명시
            }
        })
        .then(response => {
        // 응답 상태가 OK(200)인지 확인
        if (!response.ok) {
            throw new Error('Network response was not ok.');
        }
        return response.json(); // JSON 형태로 응답 본문을 변환
	    })
	            .then(data => {
	        // 데이터를 성공적으로 가져왔을 때 실행
	        if (Array.isArray(data) && data.length > 0) {
	            // 새 알림이 있을 경우 처리
	             $('#alertContentArea').empty();

                // 알림 메시지 추가
                data.forEach(function(item) {
                	var alertNo = 'contentNo'+item.alertid;
                    $('#alertContentArea').append('<div id="'+ alertNo +'" class="alertContent" onclick="getDetail('+item.alertid+')">  </div>');
                    $('#'+alertNo).append('<p>' + item.message + '</p>');
                    $('#'+alertNo).append('<p class="alertTimeStamp">' + item.senddate + '</div>');
                    $('#'+alertNo).append('<hr class="alerthr">');
                    
                });

	            console.log(data);
	            alarmOn(); // 알림 표시 기능 호출
	        } else {
	            console.log("No new notifications");
	        }
	    })
	    .catch(error => {
	        // 네트워크 오류나 JSON 변환 오류 등 예외 처리
	        console.error('Error:', error);
	    });
	        // 다음 체크 주기 설정 (예: 5초)  // 일단 1분으로 해놈~~ 자꾸 떠서
	        setTimeout(checkForNotifications, 5000000);
	    }

    // 페이지 로드 시 알림 체크 시작
    window.onload = checkForNotifications;
    
    
  	//알림이 있으면 알림 있는 이미지로 변경하는 내용.
    function alarmOn() {
    	 var img = document.getElementById('alarm');
        img.src = '${pageContext.request.contextPath}/resources/images/alarm2.png';
    }
    function alarmOff() {
    	 var img = document.getElementById('alarm');
        img.src = '${pageContext.request.contextPath}/resources/images/alarm.png';
    }
    function getDetail(alertno1){
    	window.location.href = '${pageContext.request.contextPath}/testUrl?alertid='+alertno1;
    }
    
    
    
    </script>


</head>

<body>
<header>
<div class="header_outline">
<div class="header_innerBox">
<a href="${pageContext.request.contextPath}" > <img  class="header_logo" src="${pageContext.request.contextPath}/resources/images/mainLogo.png"></a>
 <div class="header_innerText"><a href="${pageContext.request.contextPath}" style="color: inherit; font-family: inherit; font-size: inherit; text-decoration: none; ">김국민의 업무노트</a></div>
</div>
 <div class="header_iconArea">
    <a href="${pageContext.request.contextPath}/calendar"><img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/calendar.png"></a>
    <a href="${pageContext.request.contextPath}/mypage"> <img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/mypage.png"></a>
    <a href="#;"  id="notifyButton"><img id="alarm" class="header_icon" src="${pageContext.request.contextPath}/resources/images/alarm.png"></a>
    <img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/setting.png">
 </div>
</div>
</header>
    <div id="notificationBox" class="notification-box1">
    <div><a href="#;" class="deleteButton1" id="notifyButton1">X</a></div>
    <div id="alertContentArea" class="alertContentArea"> 
    	<div class="alertContent">
        <p id="alertTitle">새로운 알림이 있습니다!</p>
        <p id="alertTimeStamp" class="alertSendTime" >알림 등록 일시</p>
        <hr class="alerthr">
        </div>
        
        
    </div>
    
    </div>

</body>
</html>