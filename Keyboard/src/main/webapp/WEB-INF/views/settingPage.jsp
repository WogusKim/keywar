<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/setting.css">
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
