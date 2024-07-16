<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>

<body>
<header>
<div class="header_outline">
<div class="header_innerBox">
 <img  class="header_logo" src="${pageContext.request.contextPath}/resources/images/mainLogo.png">
 <div class="header_innerText">김국민의 업무노트</div>
</div>
 <div class="header_iconArea">
    <a href="${pageContext.request.contextPath}/calendar"><img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/calendar.png"></a>
    <img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/mypage.png">
    <img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/alarm.png">
    <img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/setting.png">
 </div>
</div>
</header>
</body>
</html>