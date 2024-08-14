<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 전체 설정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/setting.css">
<% String userno = (String) session.getAttribute("userno"); %>
</head>
<style>
.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
  
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
.display-flex{
	display: flex;
	justify-content:space-between; 
	margin-bottom: 10px;
}
.alertSetting{
	font-weight: bold; 
	font-size: 20px;
}
</style>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="content_outline">
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>
		<div class="content_right">
			<!-- 주 콘텐츠 -->
			<div style="display: flex; height: 100%; ">
			<div class="settingPage" style=" height: 53%;">
				<div class="innerSetting">
					<h2>색상설정</h2> 
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
				<div class="settingPage" style="margin-left: 10px; height: 53%;">
					<div class="innerSetting" style="padding-bottom: 20px;">
						<h2>알림 설정</h2>
						<hr>
						<div style="padding: 10px;">
							<div class="display-flex">
								<div class="alertSetting"  style="justify-content: center;"><div style="margin: auto;">좋아요</div> </div>
								<label class="switch"><input type="checkbox" ${alert.like == 1 ? 'checked' : ''} onclick="switchAlert('like', this.checked)"><span class="slider round"></span></label>
							</div>
							<div class="display-flex">
								<span  class="alertSetting">댓글 </span>
								<label class="switch"><input type="checkbox" ${alert.comment == 1 ? 'checked' : ''} onclick="switchAlert('comment', this.checked)"><span class="slider round"></span></label>
							</div>
							<div class="display-flex">
								<span  class="alertSetting">공지사항 </span>
								<label class="switch"><input type="checkbox" ${alert.notice == 1 ? 'checked' : ''} onclick="switchAlert('notice', this.checked)"><span class="slider round"></span></label>
							</div>
							<div class="display-flex">
								<span  class="alertSetting">일정</span>
								<label class="switch"><input type="checkbox" ${alert.calendar == 1 ? 'checked' : ''} onclick="switchAlert('calendar', this.checked)"><span class="slider round"></span></label>
							</div>
							<div class="display-flex">
								<span  class="alertSetting">구독</span>
								<label class="switch"><input type="checkbox" ${alert.subscribe == 1 ? 'checked' : ''} onclick="switchAlert('subscribe', this.checked)"><span class="slider round"></span></label>
							</div>
							<div class="display-flex">
								<span  class="alertSetting">팔로우</span>
								<label class="switch"><input type="checkbox" ${alert.follow == 1 ? 'checked' : ''} onclick="switchAlert('follow', this.checked)"><span class="slider round"></span></label>
							</div>
						</div>
					</div>
				</div><!-- 알림 설정 끝 -->
			
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

function switchAlert(alertCategory, isChecked) {
    console.log("Todo ID:", alertCategory);
    var isCheckedNum = isChecked ? 1 : 0;
    console.log("상태확인", isChecked);
    console.log("Is Done:", isCheckedNum);
    
/*      var checkbox = document.querySelector('input[data-todoid="' + todoid + '"]'); */
/*     checkbox.dataset.done = isCheckedNum; */
    
    fetch('${pageContext.request.contextPath}/changeAlertStatus', {   
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
        	
            userno: '<%= userno %>',
            category : alertCategory,
            checkStatus: isCheckedNum
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
    })
    .catch((error) => {
        console.error('Error:', error);
        alert("알림 설정 중 오류가 발생하였습니다.");
    }); 
}

</script>
</body>
</html>
