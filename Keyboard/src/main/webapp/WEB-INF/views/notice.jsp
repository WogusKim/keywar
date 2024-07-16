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
.notice {
	background-color: #FFFB88; /* 포스트잇 같은 밝은 노란색 */
	width: 300px; /* 고정된 너비 설정 */
	height: 150px; /* 고정된 높이 설정 */
	padding: 10px;
	box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
	font-size: 15px;
	color: #333; /* 글자 색을 약간 어둡게 */
	margin: 10px; /* 포스트잇 간 간격 */
	position: relative; /* 상대적 위치 설정 */
}

.notice .deleteButton1 {
	width: 20px;
    height: 20px;
	position: absolute;
	top: 10px;
	right: 10px;
	background-color: #E65050;
	border: none;
	color: white;
	padding: 0;
	border-radius: 50%;
	cursor: pointer;
	 font-size: 14px;
	 text-align: center;
    line-height: 20px; /* 버튼 높이와 동일하게 설정하여 텍스트를 중앙에 배치 */
}
.deleteButton1:hover { /* yeji */
    background-color: #B53D3D;
}

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
					<h2 class="card_title">부점 공지사항</h2>
					<hr>
						<div class="aa" >
							<div class="notice">포스트잇입니다.<button class="deleteButton1" onclick="deleteNotice(this)">X</button></div>
							<div class="notice">포스트잇두개야 두개~ 두개<button class="deleteButton1" onclick="deleteNotice(this)">X</button></div>
							<div class="notice">포스트잇 세개야 세개 세개째 작성했어<button class="deleteButton1" onclick="deleteNotice(this)">X</button></div>
							<div class="notice">포스트잇 네개~~~네개!!!<button class="deleteButton1" onclick="deleteNotice(this)">X</button></div>
							<div class="notice">포스트잇 네개~~~네개!!!<button class="deleteButton1" onclick="deleteNotice(this)">X</button></div>
							<div class="notice">포스트잇두개야 두개~ 두개<button class="deleteButton1" onclick="deleteNotice(this)">X</button></div>
							<div class="notice">포스트잇 세개야 세개 세개째 작성했어<button class="deleteButton1" onclick="deleteNotice(this)">X</button></div>
							<div class="notice">포스트잇두개야 두개~ 두개<button class="deleteButton1" onclick="deleteNotice(this)">X</button></div>
							<div class="notice">포스트잇 세개야 세개 세개째 작성했어<button class="deleteButton1" onclick="deleteNotice(this)">X</button></div>
						</div>
					
				</div>
				<input type="button" value="추가하기" class="addButton">
			</div>
		</div>
	</div>


</body>
</html>