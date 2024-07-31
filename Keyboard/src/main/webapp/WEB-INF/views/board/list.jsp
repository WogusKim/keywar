<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 인기 노트 </title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="content_outline">
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />
	<div class="content_right">
		<div style="width: 100%; height: 10%;"><b>BEST 게시물 모아보기</b></div>
		<div style=" width: 100%; height: 80%; overflow-y: auto; ">
			<c:forEach var="list" items="${list}">
	        	<a href="${pageContext.request.contextPath}/detailNote?id=${list.id}"><span>${ list.title } </span></a><br>
	        </c:forEach>
		
		
		
		
		</div>
		<div style="background-color: pink; width: 100%; height: 10%;">페이지네이션 영역</div>
	</div>
</div>
</body>
</html>