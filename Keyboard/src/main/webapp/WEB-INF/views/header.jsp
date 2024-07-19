<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>

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
            } else {
                notificationBox.style.display = 'none'; // 박스 숨기기
            }
        });
        notifyButton1.addEventListener('click', () => {
            if (notificationBox.style.display === 'none' || notificationBox.style.display === '') {
                notificationBox.style.display = 'block'; // 박스 보이기
            } else {
                notificationBox.style.display = 'none'; // 박스 숨기기
            }
        });
    });
    </script>
<style>
.notify-btn {
    background-color: #4CAF50;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border: none;
    border-radius: 4px;
    transition: background-color 0.3s;
}

.notify-btn:hover {
    background-color: #45a049;
}
/* 알림 박스 스타일 */
.notification-box {
    position: fixed;
    top: 85px; /* 위에서 60px 떨어진 위치 */
    right: 15px; /* 오른쪽 끝에서 10px 떨어진 위치 */
    width: 300px;
    padding: 20px;
    background-color: #F3F3F3;
    color: black;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
    display: none; /* 초기에는 박스를 숨깁니다 */
}
.deleteButton {
	text-decoration: none;
	width: 20px;
	height: 20px;
	position: absolute;
	top: 10px;
	right: 10px;
	background-color: #E65050;
	border: none;
	color: white;
	padding: 0;
	border-radius: 50%;
	cursor: pointer;
	font-size: 14px;
	text-align: center;
	line-height: 20px; /* 버튼 높이와 동일하게 설정하여 텍스트를 중앙에 배치 */
}

.deleteButton1:hover { /* yeji */
	background-color: #B53D3D;
}
</style>
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
    <a href="#"  id="notifyButton"><img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/alarm.png"></a>
    <img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/setting.png">
 </div>
</div>
</header>
    <div id="notificationBox" class="notification-box">
    <div><a href="#" class="deleteButton" id="notifyButton1">X</a></div>
        <p>새로운 알림이 있습니다!</p>
    </div>

</body>
</html>