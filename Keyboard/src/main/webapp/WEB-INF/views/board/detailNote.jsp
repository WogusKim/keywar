<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 노트 훔쳐보기 </title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="content_outline">
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />
	<div class="content_right">
	</div>
</div>
</body>
</html>