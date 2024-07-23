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
ul li {
	position: relative;
	padding-right: 30px; /* 버튼 공간 확보를 위해 오른쪽 패딩 추가 */
	margin-bottom: 10px; /* li 요소 사이에 간격 추가 */
}

#memoPopup, #deptMemoPopup {
	display: none; /* 기본적으로 숨김 */
	position: fixed;
	z-index: 1000;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	width: 400px;
	padding: 20px;
	background-color: #ffffff;
	box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	text-align: center;
}

#popupOverlay {
	display: none; /* 기본적으로 숨김 */
	position: fixed;
	z-index: 999;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
}

#memoPopup h3, #deptMemoPopup h3 {
	margin-bottom: 20px;
	color: #333;
	font-size: 24px;
}

#memoPopup form, #deptMemoPopup form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

#memoPopup label, #deptMemoPopup label {
	margin-bottom: 10px;
	font-weight: bold;
	color: #555;
}

#memoPopup input[type="text"], #deptMemoPopup input[type="text"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

#buttonContainer {
	display: flex;
	justify-content: space-between;
	width: 100%;
}

#memoPopup input[type="submit"], #memoPopup button, #deptMemoPopup input[type="submit"],
	#deptMemoPopup button {
	width: 45%;
	padding: 10px;
	margin: 5px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}

#memoPopup input[type="submit"] {
	background-color: #4CAF50;
	color: white;
}

#memoPopup button {
	background-color: #f44336;
	color: white;
}

#deptMemoPopup input[type="submit"] {
	background-color: #4CAF50;
	color: white;
}

#deptMemoPopup button {
	background-color: #f44336;
	color: white;
}

#memoPopup input[type="submit"]:hover, #memoPopup button:hover,
	#deptMemoPopup input[type="submit"]:hover, #deptMemoPopup button:hover
	{
	opacity: 0.8;
}
</style>
<script>
	function openPopup(popupId) {
		document.getElementById("popupOverlay").style.display = "block";
		document.getElementById(popupId).style.display = "block";
	}

	function closePopup(popupId) {
		document.getElementById("popupOverlay").style.display = "none";
		document.getElementById(popupId).style.display = "none";
	}
</script>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>



	<div id="popupOverlay"
		onclick="closePopup('memoPopup'); closePopup('deptMemoPopup');"></div>

	<div id="memoPopup">
		<h3>나의 메모작성</h3>
		<form action="mymemoWrite" method="post">
			<input type="hidden" name="memoType" id="memoType" value="myMemo">
			<label for="content">내용:</label> <input type="text"
				name="mymemocontent" required><br>
			<div id="buttonContainer">
				<input type="submit" value="저장">
				<button type="button" onclick="closePopup('memoPopup')">취소</button>
			</div>
		</form>
	</div>

	<div id="deptMemoPopup">
		<h3>부점 메모작성</h3>
		<form action="deptmemoWrite" method="post">
			<input type="hidden" name="memoType" id="memoType" value="deptMemo">
			<label for="content">내용:</label> <input type="text"
				name="deptmemocontent" required><br>
			<div id="buttonContainer">
				<input type="submit" value="저장">
				<button type="button" onclick="closePopup('deptMemoPopup')">취소</button>
			</div>
		</form>
	</div>

	<div class="content_outline">
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>
		<div class="content_right">
			<!-- 여기까지 기본세팅(흰 배경) -->

			<div class="board_back1">
				<!-- 민트 배경 -->
				<div style="display: flex; width: 100%;">
					<!-- 나의메모와 부점메모 묶음 -->
					<div class="memoboardDiv">
						<div class="board_memo1">
							<!-- 흰 배경 -->
							<h2 class="card_title">나의 메모</h2>
							<hr>
							<ul>
								<c:forEach items="${memo1}" var="dto1">
									<li>${dto1.content}&nbsp;${dto1.createdate}
									<a
										href="./mymemoDelete?memoid=${dto1.memoid}&userno=${dto1.userno}"
										class="deleteButton">X</a>
									</li>
								</c:forEach>
							</ul>
						</div>
						<input type="button" value="추가하기" class="addButton"
							onclick="openPopup('memoPopup');">
					</div>

					<div class="memoboardDiv">
						<div class="board_memo2">
							<!-- 흰 배경 -->
							<h2 class="card_title">부점 메모</h2>
							<hr>
							<ul>
								<c:forEach items="${memo2}" var="dto2">
									<li>${dto2.content}&nbsp;${dto2.createdate}<a
										href="./deptmemoDelete?memoid=${dto2.memoid}&deptno=${dto2.deptno}"
										class="deleteButton">X</a></li>
								</c:forEach>
							</ul>
						</div>

						<input type="button" value="추가하기" class="addButton"
							onclick="openPopup('deptMemoPopup');">
					</div>
				</div>



			</div>
		</div>
	</div>


</body>
</html>