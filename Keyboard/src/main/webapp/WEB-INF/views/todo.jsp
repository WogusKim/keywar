<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>
		<div class="content_right">
			<div class="content_todo">
				<p>To-Do List</p>
				<ul>
					<li><input type="checkbox" name="task1"> 최성은 고객 가계대출 기한연장 자서 누락된 부분 보완</li>
					<li><input type="checkbox" name="task2"> 문재욱 고객 담보대출 상담 15:00 내점 예정</li>
					<li><input type="checkbox" name="task3"> 지점장님 예산 떨기</li>
					<li><input type="checkbox" name="task4"> 365 자동화 임대료 납부</li>
					<li><input type="checkbox" name="task5"> 김재현 대리 생일축하 케이크 구매</li>
					<li><input type="checkbox" name="task6"> 12월 휴가 올리기</li>
				</ul>

			</div>
			<input type="button" value="추가하기" class="addButton">
		</div>
	</div>
</body>
</html>