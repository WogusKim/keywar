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
.addButton1 {
	padding: 10px 15px;
	border: none;
	background-color: #508AE6;
	color: white;
	border-radius: 10px;
	cursor: pointer;
	margin-top: 5px;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}

.addButton1:hover {
	background-color: #3d6db5;
}
</style>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>
		<div class="content_right">
			<!-- 여기까지 기본세팅(흰 배경) -->

			<div class="board_back1">
				<!-- 민트 배경 -->
				<div style="display: flex;">
					<!-- 나의메모와 부점메모 묶음 -->
					<div class="board_memo1">
						<!-- 흰 배경 -->
						<h2 class="card_title">나의 메모</h2>
						<hr>
						<ul>
							<li>궁민상사 대표님 010-5555-7777</li>
							<li>트랜디프로모션 담당자 010-3127-4782</li>
							<li>글로벌인터네셔널 경리 02-4154-5415</li>
							<li>국민건강보험공단 1355</li>
						</ul>
					</div>

					<div class="board_memo2">
						<!-- 흰 배경 -->
						<h2 class="card_title">부점 메모</h2>
						<hr>
						<ul>
							<li>궁민상사 대표님 010-5555-7777</li>
							<li>트랜디프로모션 담당자 010-3127-4782</li>
							<li>글로벌인터네셔널 경리 02-4154-5415</li>
							<li>국민건강보험공단 1355</li>
						</ul>
					</div>
				</div>

				<input type="button" value="추가하기" class="addButton"> <input
					type="button" value="추가하기" class="addButton1">

			</div>
		</div>
	</div>


</body>
</html>