<%@ page language="java" contentType="text/html; charset=UTF-8"                                                  
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 테스트 페이지</title>

<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />

</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<div class="content_outline">
	<%@ include file="/WEB-INF/views/sidebar.jsp" %>
	<div class="content_right">
		
 <h1>Real-time Notifications</h1>


    <script>
    
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
	           /*  $('#notificationBox').empty();

                // 삭제 버튼 추가
                $('#notificationBox').append('<div><a href="#;" class="deleteButton1" id="notifyButton1">X</a></div>');
 */
                // 알림 메시지 추가
                data.forEach(function(item) {
                    $('#notificationBox').append('<p class="notification-item">' + item.message + '</p>');
                    $('#notificationBox').append('<p class="notification-item">' + item.senddate + '</div>');
                    $('#notificationBox').append('<div class="notification-item">' + item.message + '</div>');
                    
                });

                // 삭제 버튼 클릭 시 동작
                $('#notifyButton1').on('click', function() {
                $('#notificationBox').empty();
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
	        setTimeout(checkForNotifications, 60000);
	    }

    // 페이지 로드 시 알림 체크 시작
    window.onload = checkForNotifications;
    
    function alarmOn() {
   	 var img = document.getElementById('alarm');
       img.src = '${pageContext.request.contextPath}/resources/images/alarm2.png';
   }
    
    
    </script>
	</div>
</div>   
</body>
</html>