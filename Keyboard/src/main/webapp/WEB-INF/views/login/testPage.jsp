<%@ page language="java" contentType="text/html; charset=UTF-8"                                                  
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 테스트 페이지</title>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<div class="content_outline">
	<%@ include file="/WEB-INF/views/sidebar.jsp" %>
	<div class="content_right">
		
 <h1>Real-time Notifications</h1>


    <script>
    function checkForNotifications() {
        fetch('/warrior/ajaxNotification')
            .then(response => response.json())
            .then(data => {
                if (data.message !== "No new notifications") {
                    // 새 알림을 처리하는 로직
                    alert(data.message);
                }
            })
            .catch(error => console.error('Error:', error));

        // 다음 체크 주기 설정 (예: 5초)
        setTimeout(checkForNotifications, 5000);
    }

    // 페이지 로드 시 알림 체크 시작
    window.onload = checkForNotifications;
    </script>
	</div>
</div>   
</body>
</html>