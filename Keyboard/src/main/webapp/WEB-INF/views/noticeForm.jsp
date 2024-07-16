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
<style>
.board_todo1 {
	border-radius: 10px;
	background-color: white;
	width: 100%;
	height: 95%;
	padding: 10px;
	/* margin-bottom: 10px; /* 아래쪽에 여백 추가 */ */
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);

}
.aa {
	display: flex;
	flex-wrap:wrap;
	border-radius: 10px;
	width: 100%;
	height: 80%;
}
</style>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>
		<div class="content_right">
			<!-- 여기까지 기본세팅(흰 배경) -->

			<div class="board_back">
				<!-- 민트 배경 -->
				<div class="board_todo1">
					<!-- 흰 배경 -->
					<h2 class="card_title">부점 공지사항 작성</h2>
					<hr>
						<div class="aa" >
							<input type="text">
						</div>
					
				</div>
				<input type="button" value="추가하기" class="addButton">
			</div>
		</div>
	</div>


</body>
</html>