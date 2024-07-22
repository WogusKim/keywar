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
</style>


<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> --> 

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
    
    
    
  	//알림이 있으면 알림 있는 이미지로 변경하는 내용.
    function alarmOn() {
    	 var img = document.getElementById('alarm');
        img.src = '${pageContext.request.contextPath}/resources/images/alarm2.png';
    }
    function alarmOff() {
    	 var img = document.getElementById('alarm');
        img.src = '${pageContext.request.contextPath}/resources/images/alarm.png';
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
    <div id="alertContent" class="alertContent"> 
        <p id="alertTitle">새로운 알림이 있습니다!</p>
        <p id="alertTimeStamp" class="alertSendTime" >알림 등록 일시</p>
        <hr class="alerthr">
    </div>
    
    </div>

</body>
</html>