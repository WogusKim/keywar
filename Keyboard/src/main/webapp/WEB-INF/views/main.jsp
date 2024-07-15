<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="content_outline">
	<%@ include file="/WEB-INF/views/sidebar.jsp" %>
	<div class="content_right">
	    
	    <div class="board_top">
	    	<div class="board_inner">
	    		<div class="card_top">
		    		<h2 class="card_title">환율</h2>
		    		<a href="#" class="link-icon">바로가기</a>
	    		</div>
	    		<hr>

	    	</div>
	    	<div class="board_inner">
	    		<div class="card_top">
		    		<h2 class="card_title">증시</h2>
		    		<a href="#" class="link-icon">바로가기</a>
	    		</div>
	    		<hr>
	    	</div>
	    	<div class="board_inner">
	    		<div class="card_top">
		    		<h2 class="card_title">금리</h2>
		    		<a href="#" class="link-icon">바로가기</a>
	    		</div>
	    		<hr>
	    	</div>
	    </div>
	    
	    <div class="board_bottom">
	    	<div class="board_inner2">
				
	    	</div>
	    	<div class="board_inner2">

	    	</div>
	    </div>
	</div> 
</div>

</body>
</html>