<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">
<style>

.board_memo3 { /* yeji */
	border-radius: 10px;
	background-color: white;
	width: 100%; /* 좌우 각각의 메모가 절반씩 차지하도록 설정 */
	padding: 10px;
	margin-bottom: 10px;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
	height: 92%; /* 높이 설정 */
}

.board_memo4 { /* yeji */
	border-radius: 10px;
	background-color: white;
	width: 100%; /* 좌우 각각의 메모가 절반씩 차지하도록 설정 */
	padding: 10px;
	margin-bottom: 10px;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
	height: 92%; /* 높이 설정 */
}

/* 메모 리스트의 왼쪽 패딩 제거 */
.board_back1 ul {
	list-style-type: none; /* 리스트 항목 앞의 점을 없앰 */
	padding-left: 10px; /* 왼쪽 패딩을 제거하여 여백 없앰 */
	padding-right: 0; /* 왼쪽 패딩을 제거하여 여백 없앰 */
	margin-left: 0; /* 필요한 경우 왼쪽 마진도 제거 */
}

/* 메모 리스트 항목 스타일 */
.board_back1 ul li {
	position: relative;
	padding-right: 30px; /* 버튼 공간 확보를 위해 오른쪽 패딩 추가 */
	margin-bottom: 15px; /* li 요소 사이에 간격 추가 */
	padding: 20px 20px; /* 내용과 테두리 사이에 위아래 여백 증가 */
	border-radius: 5px; /* 테두리 모서리를 둥글게 처리 */
	background-color: #F7F8FB; /* 배경색 흰색으로 설정 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 더 뚜렷한 그림자 적용 */
	width: 95%; /* 너비를 95%로 설정하여 좀 더 넓게 만듬 */
}

.createdate {
	color: gray;
	font-size: 0.9em; /* 원하는 크기로 조정 */
	float: right; /* 오른쪽으로 배치 */
	margin-right: 30px; /* 오른쪽 마진 추가하여 조금 떨어지게 배치 */
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

.aaa {
	width: 100%;
	height: 40px; /* 적절한 높이 설정 */
	padding: 10px;
	font-size: 16px; /* 글씨 크기 조정 */
	border: 1px solid #ccc; /* 테두리 설정 */
	border-radius: 5px; /* 모서리 둥글게 */
	box-sizing: border-box; /* 박스 사이징 설정 */
}

.search-container {
	display: flex; /* 플렉스박스 레이아웃 적용 */
	align-items: center; /* 세로 중앙 정렬 */
	justify-content: center; /* 가로 중앙 정렬 */
	height: 50px; /* 검색바의 높이 명시적 설정 */
}

.search-container input[type="text"] {
	width: 80%; /* 입력 창 너비를 80%로 설정 */
	height: 35px; /* 높이 설정 */
	padding: 8px; /* 패딩 설정 */
	margin-left: 0;
	margin-right: 20px; /* 오른쪽 여백을 20px로 설정하여 버튼과의 간격을 늘림 */
	border: 1px solid #ccc; /* 경계선 설정 */
	border-radius: 4px; /* 모서리 둥글게 처리 */
	box-sizing: border-box;
	/* 박스 사이징을 border-box로 설정하여 패딩과 테두리가 너비에 포함되도록 함 */
	font-size: 16px; /* 폰트 크기 설정 */
	vertical-align: middle; /* 수직 정렬을 중앙으로 설정 */
}

.search-container input[type="image"] {
	width: 33px; /* 가로 크기 설정 */
	height: 33px; /* 세로 크기 설정 */
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
	
	$(document).ready(function() {
	    $('#searchButton').click(function() {
	        var keyword = $('#searchInput').val();
	        var userno = '${sessionScope.userno}'; // 세션에서 사용자 번호를 가져옴

	        $.ajax({
	            url: '${pageContext.request.contextPath}/searchMyMemo',
	            type: 'GET',
	            data: {
	                keyword: encodeURIComponent(keyword),
	                userno: userno
	            },
	            success: function(response) {
	                $('#memoList').empty();
	                if (response.memos && response.memos.length > 0) {
	                    $.each(response.memos, function(i, memo) {
	                        console.log('Color:', memo.color);
	                        console.log('Createdate:', memo.createdate);

	                        var color = memo.color || '#F7F8FB'; // 컬러가 없을 경우 기본값으로 설정
	                        var createdate = memo.createdate || '날짜 없음';

	                        var listItem = `<li style="background-color: \${color};">
	                                            \${memo.content}
	                                            <span class="createdate">\${createdate}</span>
	                                        </li>`;

	                                        
	                                        console.log(listItem);  // 생성된 HTML 요소를 콘솔에 출력
	                                        
	                        $('#memoList').append(listItem);
	                    });
	                } else {
	                    $('#memoList').append('<li>검색 결과가 없습니다.</li>');
	                }
	            },


	            error: function() {
	                alert('검색 처리 중 오류가 발생했습니다.');
	            }
	        });
	    });
	    
	    
	    $('#searchDeptButton').click(function() {
	        var keyword = $('#deptSearchInput').val();
	        var deptno = '${sessionScope.deptno}'; 

	        $.ajax({
	            url: '${pageContext.request.contextPath}/searchDeptMemo',
	            type: 'GET',
	            data: {
	                keyword: encodeURIComponent(keyword),
	                deptno: deptno
	            },
	            success: function(response) {
	                $('#deptMemoList').empty();
	                if (response.memos && response.memos.length > 0) {
	                    $.each(response.memos, function(i, memo) {
	                        var color = memo.color || '#F7F8FB';
	                        var createdate = memo.createdate || '날짜 없음';

	                        var listItem = `<li style="background-color: \${color};">
	                                            \${memo.content}
	                                            <span class="createdate">\${createdate}</span>
	                                        </li>`;
	                        $('#deptMemoList').append(listItem);
	                    });
	                } else {
	                    $('#deptMemoList').append('<li>검색 결과가 없습니다.</li>');
	                }
	            },
	            error: function() {
	                alert('검색 처리 중 오류가 발생했습니다.');
	            }
	        });
	    });
	    
	    
	    
	});




	
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
				name="mymemocontent" required><br> <label
				for="colorSelect">색상 선택:</label> <select class="aaa"
				id="colorSelect" name="memocolor"
				style="width: 100%; margin-top: 10px;">
				<option value="" disabled selected>색상을 선택하세요</option>
				<option value="#F5FFB9">노랑</option>
				<option value="#DADCFF">보라</option>
				<option value="#D8FFB9">연두</option>
				<option value="#D9FFFF">하늘</option>
				<option value="#FFE3FC">핑크</option>
			</select><br>


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

			<!-- 색상 선택 추가 -->
			<label for="colorSelect">색상 선택:</label> <select class="aaa"
				id="colorSelect" name="memocolor"
				style="width: 100%; margin-top: 10px;">
				<option value="" disabled selected>색상을 선택하세요</option>
				<option value="#F5FFB9">노랑</option>
				<option value="#DADCFF">보라</option>
				<option value="#D8FFB9">연두</option>
				<option value="#D9FFFF">하늘</option>
				<option value="#FFE3FC">핑크</option>
			</select><br>

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
				<div style="display: flex; width: 100%; height: 100%;">
					<!-- 나의메모와 부점메모 묶음 -->
					<div class="memoboardDiv">
						<div class="board_memo3">
							<!-- 흰 배경 -->
							<h2 class="card_title">나의 메모</h2>
							<hr>
							<!-- 검색바 추가 -->
							<div class="search-container">
								<input type="text" placeholder="나의 메모 검색어를 입력해주세요." name="search"
									id="searchInput"> <input type="image"
									src="${contextPath}/resources/images/icons/search.png" alt="검색"
									id="searchButton">
							</div>

							<!-- 검색 결과를 표시할 부분 -->
							<div id="searchResults"
								style="overflow-y: auto; height: calc(90% - 50px);">
								<ul id="memoList">
									<!-- 검색 결과가 여기에 동적으로 삽입됩니다 -->
									<c:forEach items="${memo1}" var="dto1">
										<li style="background-color: ${dto1.color};">${dto1.content}&nbsp;<span
											class="createdate">${dto1.createdate}</span> <a
											href="./mymemoDelete?memoid=${dto1.memoid}&userno=${dto1.userno}"
											class="deleteButton">X</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<input type="button" value="추가하기" class="addButton"
							onclick="openPopup('memoPopup');">
					</div>

					<div class="memoboardDiv">
						<div class="board_memo4">
							<!-- 흰 배경 -->
							<h2 class="card_title">부점 메모</h2>
							<hr>

							<div class="search-container">
								<input type="text" placeholder="부점 메모 검색어를 입력해주세요."
									name="deptSearch" id="deptSearchInput"> <input
									type="image"
									src="${contextPath}/resources/images/icons/search.png" alt="검색"
									id="searchDeptButton">
							</div>

							<div id="deptSearchResults"
								style="overflow-y: auto; height: calc(90% - 50px);">
								<ul id="deptMemoList">
									<c:forEach items="${memo2}" var="dto2">
										<li style="background-color: ${dto2.color};">
											${dto2.content}&nbsp; <span class="createdate">${dto2.createdate}</span>
											<a
											href="./deptmemoDelete?memoid=${dto2.memoid}&deptno=${dto2.deptno}"
											class="deleteButton">X</a>
										</li>
									</c:forEach>
								</ul>
							</div>
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