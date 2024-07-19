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
    	<ul id="notifications"></ul>
<script>
var eventSource = new EventSource('/warrior/subscribe');

eventSource.onmessage = function(event) {
    if (event.data && event.data !== "connected") {
        var notifications = document.getElementById('notifications');
        var notification = document.createElement('li');
        notification.appendChild(document.createTextNode('New post: ' + event.data));
        notifications.appendChild(notification);
    }
};

eventSource.onerror = function(event) {
    console.error('EventSource error:', event);
    console.error('EventSource readyState:', event.target.readyState);
    console.error('EventSource response text:', event.target.responseText);
};
    </script>
	
	
	</div>
</div>   
</body>
</html>