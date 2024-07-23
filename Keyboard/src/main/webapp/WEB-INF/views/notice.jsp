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
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
	position: relative; /* 공지사항들이 기본적으로 나란히 정렬되도록 */
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
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}

.aa {
	display: flex;
	flex-wrap: wrap;
	border-radius: 10px;
	width: 100%;
	height: 80%;
	position: relative; /* 상대적 위치 설정 */
}
</style>
<!-- jQuery 및 jQuery UI 스크립트 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
$(function() {
    $(".notice").draggable({
        containment: ".aa", // 이동 영역을 흰 배경 안으로 제한
        scroll: false, // 드래그 중 스크롤 비활성화
        stop: function(event, ui) {
            // 드래그 종료 시 실행
            var noticeId = $(this).data("id"); // 공지사항 ID (data-id 속성에서 가져옴)
            var positionX = ui.position.left;
            var positionY = ui.position.top;
            
            console.log(positionX);
            console.log(positionY);
            console.log(noticeId);
            
            // fetch API로 위치를 서버에 저장
            fetch('${pageContext.request.contextPath}/updateNoticePosition', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    noticeid: noticeId,
                    positionX: positionX,
                    positionY: positionY
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    console.log('위치가 성공적으로 저장되었습니다.');
                } else {
                    console.error('위치 저장 중 오류가 발생했습니다.');
                }
            })
            .catch(error => console.error('Error:', error));
        }
    });
});

</script>
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
					<div class="aa">
						<c:forEach items="${notice}" var="dto">
							<div class="notice" data-id="${dto.noticeid}"
								style="position: absolute; left: ${dto.positionX}px; top: ${dto.positionY}px;">
								<br>${dto.title}<br>${dto.content} <a
									href="./noticeDelete?noticeid=${dto.noticeid}&userno=${dto.userno}"
									class="deleteButton1">X</a>
							</div>
						</c:forEach>
					</div>
				</div>
				<a href="noticeForm"> <input type="button" value="추가하기"
					class="addButton">
				</a>
			</div>
		</div>
	</div>

</body>
</html>
