<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
.notice {
    background-color: #FFFB88;
    width: 300px;
    height: 150px;
    padding: 10px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
    font-size: 15px;
    color: #333;
    margin: 10px;
    position: relative;
}
.notice .title {
    font-weight: bold;
    display: block;
    margin-top: 5px;
    margin-bottom: 5px;
}
.notice .createdate {
    position: absolute;
    bottom: 10px;
    right: 10px;
    font-size: 12px;
    color: #666;
}
.notice .deleteButton1 {
    width: 20px;
    height: 20px;
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: #E65050;
    text-decoration: none;
    border: none;
    color: white;
    padding: 0;
    border-radius: 50%;
    cursor: pointer;
    font-size: 14px;
    text-align: center;
    line-height: 20px;
}
.deleteButton1:hover {
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
    position: relative;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
$(function() {
    var maxZ = 100; // 초기 z-index 최대값 설정
    // 서버에서 최대 z-index 값 로드
    fetch('${pageContext.request.contextPath}/getMaxZindex')
        .then(response => response.text())
        .then(data => {
            maxZ = parseInt(data); // 서버에서 받은 최대값에 1을 더해 초기화
        })
        .catch(error => console.error('Error loading max z-index:', error));

    $(".notice").draggable({
        containment: ".aa",
        scroll: false,
        start: function(event, ui) {
            $(this).css("z-index", ++maxZ); // 드래그 시작 시 z-index를 증가
        },
        stop: function(event, ui) {
            var noticeId = $(this).data("id");
            var positionX = ui.position.left;
            var positionY = ui.position.top;
            var zindex = $(this).css("z-index");
            // 위치 업데이트를 서버에 전송
            fetch('${pageContext.request.contextPath}/updateNoticePosition', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    noticeid: noticeId,
                    positionX: positionX,
                    positionY: positionY,
                    zindex: zindex
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    console.log('위치가 성공적으로 저장되었습니다.');
                } else {
                    console.error('위치 저장 중 오류가 발생했습니다.', data);
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
        <div class="board_back">
            <div class="board_todo1">
                <h2 class="card_title">부점 공지사항</h2>
                <hr>
                <div class="aa">
                    <c:forEach items="${notice}" var="dto">
                        <div class="notice" data-id="${dto.noticeid}"
                             style="position: absolute; left: ${dto.positionX}px; top: ${dto.positionY}px; background-color: ${dto.color}; z-index: ${dto.zindex};">
                            <div class="title">${dto.title}</div>
                            ${dto.content}
                            <div class="createdate">${dto.createdate}</div>
                            <a href="./noticeDelete?noticeid=${dto.noticeid}&userno=${dto.userno}" class="deleteButton1">X</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <a href="noticeForm"> <input type="button" value="추가하기" class="addButton"></a>
        </div>
    </div>
</div>
</body>
</html>
