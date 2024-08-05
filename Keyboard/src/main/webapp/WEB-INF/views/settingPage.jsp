<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<!--link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/setting.css"-->
<style>

/* 추후 css로 뺄 예정 */

:root {
    --main-bgcolor: #BDE2CE; /* 변수 선언 */
}

.settingPage {
	border-radius: 10px;
    background-color: var(--main-bgcolor);
    width: 30%;
    height: 50%;
    padding: 15px;
    margin-right: 10px;
    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}
.innerSetting {
	border-radius: 10px;
    background-color: white;
    width: 100%;
    height: 100%;
    padding: 10px;
    margin-right: 10px;
    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}
.color-circle {
    width: 70px; /* 원의 크기 */
    height: 70px; /* 원의 크기 */
    border-radius: 50%; /* 원형 만들기 */
    cursor: pointer;
    display: inline-block; /* 옆으로 나열 */
    margin-bottom: 15px; /* 하단 간격 조정 */
}

.color-selection {
    display: grid;
    grid-template-columns: repeat(3, 1fr); /* 3개의 열로 나누기 */
    gap: 10px; /* 각 원 사이의 간격 */
}

input[type="radio"] {
    display: none; /* 라디오 버튼 숨기기 */
}

input[type="radio"]:checked + .color-circle {
    border: 3px solid black; /* 선택 시 테두리 추가 */
}
</style>

</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>
		<div class="content_right">
			<!-- 주 콘텐츠 -->
			
			<div class="settingPage">
				<div class="innerSetting">
					<h3>색상설정</h3>
					<hr>
		            <form class="color-selection" action="${pageContext.request.contextPath}/submitColor" method="post">
		                <label>
		                    <input type="radio" name="setting_color" value="green" id="green-radio">
		                    <div class="color-circle" id="green" style="background-color: #BDE2CE;"></div>
		                </label>
		                <label>
		                    <input type="radio" name="setting_color" value="red" id="red-radio">
		                    <div class="color-circle" id="red" style="background-color: #ff1b1bcf;"></div>
		                </label>
		                <label>
		                    <input type="radio" name="setting_color" value="orange" id="orange-radio">
		                    <div class="color-circle" id="orange" style="background-color: #ef803bad;"></div>
		                </label>
		                <label>
		                    <input type="radio" name="setting_color" value="blue" id="blue-radio">
		                    <div class="color-circle" id="blue" style="background-color: #40a0e7;"></div>
		                </label>
		                <label>
		                    <input type="radio" name="setting_color" value="yellow" id="yellow-radio">
		                    <div class="color-circle" id="yellow" style="background-color: #e2ff005e;"></div>
		                </label>
		                <label>
		                    <input type="radio" name="setting_color" value="purple" id="purple-radio">
		                    <div class="color-circle" id="purple" style="background-color: #d862eb4f;"></div>
		                </label>
		                <button type="submit">저장</button>
		            </form>
				</div>
			</div>

		</div>
	</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 세션에서 저장된 색상 값 가져오기
    var selectedColor = '${sessionScope.bgcolor}';
    if (selectedColor) {
        var radioButton = document.getElementById(selectedColor + '-radio');
        if (radioButton) {
            radioButton.checked = true; // 해당 라디오 버튼을 체크 상태로 만듭니다.
        }
    }
});
</script>
</body>
</html>
