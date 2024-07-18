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
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}

.aa {
	display: flex;
	flex-wrap: wrap;
	border-radius: 10px;
	width: 100%;
	height: 80%;
}

.aaa {
	width: 100%;
	height: 40px; /* 적절한 높이 설정 */
	padding: 10px;
	font-size: 16px; /* 글씨 크기 조정 */
	border: 1px solid #ccc; /* 테두리 설정 */
	border-radius: 5px; /* 모서리 둥글게 */
	box-sizing: border-box; /* 박스 사이징 설정 */
}
</style>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>
		<div class="content_right">
			<!-- 여기까지 기본세팅(흰 배경) -->

			<div class="board_back" style="height: 95%;"> <!-- 민트 배경 -->
				<form action="noticeWrite" method="post" style="width: 100%; height: 95%;">
				<div class="board_todo1"> <!-- 흰 배경 -->
					<h2 class="card_title">부점 공지사항 작성</h2>
					<hr>
						<div class="aa">
							<input class="aaa" type="text" name="title" placeholder="제목을 작성하세요">
							<input class="aaa" style="height: 80%;" type="text" name="content" placeholder="공지사항을 작성하세요">
						</div>
				</div>


				<input type="submit" value="추가하기" class="addButton">
				</form>
			</div>
		</div>
	</div>


</body>
</html>