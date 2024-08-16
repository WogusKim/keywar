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
			<div class="settings-container" style="display: flex; height: 100%; ">
				<div class="settingPage2" style="height: 55%;">
				    <div class="innerSetting" style="padding-bottom: 20px;">
				        <h2>색상 테마 설정</h2> 
				        <hr>
				        <div id="colors-choice-container">
				            <img class="colors-choice" data-color="pink" src="${pageContext.request.contextPath}/resources/images/1star-kiki.png">
				            <img class="colors-choice" data-color="lightgreen" src="${pageContext.request.contextPath}/resources/images/2star-agor.png">
				            <img class="colors-choice" data-color="brown" src="${pageContext.request.contextPath}/resources/images/3star-bibi.png">
				            <img class="colors-choice" data-color="yellow" src="${pageContext.request.contextPath}/resources/images/4star-ramu.png">
				            <img class="colors-choice" data-color="green" src="${pageContext.request.contextPath}/resources/images/5star-coli.png">
				            <div id="highlight-box"></div>
				        </div>
				    </div>
				</div>
				<div class="settingPage" style="margin-left: 10px; height: 55%;">
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

document.addEventListener('DOMContentLoaded', function() {
    const colorsChoices = document.querySelectorAll('.colors-choice');
    const colorMap = {
        'green': '#A8E2D2',
        'pink': '#F4A6B8',
        'lightgreen': '#B7D98D',
        'brown': '#D1B7B0',
        'yellow': '#F9E59B'
    };

    // 세션에서 저장된 색상 값 가져오기
    var selectedColor = '${sessionScope.bgcolor}';

    function updateBackgroundColor(color) {
        colorsChoices.forEach((choice) => {
            if (choice.dataset.color === color) {
                choice.style.backgroundColor = colorMap[color];
            } else {
                choice.style.backgroundColor = '';
            }
        });
        // 페이지 배경색 즉시 변경
        document.body.style.backgroundColor = colorMap[color];
        document.documentElement.style.setProperty('--main-bgcolor', colorMap[color]);
    }

    function applyColor(color) {
        // 먼저 UI를 업데이트
        selectedColor = color;
        updateBackgroundColor(color);

        // 그 다음 서버에 변경사항 저장
        fetch('${pageContext.request.contextPath}/submitColor', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'setting_color=' + color
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                console.log(data.message);
            } else {
                console.error(data.message);
            }
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    }

    // 초기 선택된 색상 적용
    if (selectedColor) {
        updateBackgroundColor(selectedColor);
    }

    colorsChoices.forEach((choice) => {
        choice.addEventListener('mouseover', function() {
            const color = this.dataset.color;
            if (color !== selectedColor) {
                this.style.backgroundColor = colorMap[color];
            }
        });

        choice.addEventListener('mouseout', function() {
            if (this.dataset.color !== selectedColor) {
                this.style.backgroundColor = '';
            }
        });

        choice.addEventListener('click', function() {
            const color = this.dataset.color;
            applyColor(color);
        });
    });
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
