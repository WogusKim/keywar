<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>
<style>
.alertSendTime{
color: gray; 
margin top: 0px;
}
.alerthr{
background:#CFCFCF;
height:1px;
border:0;
}
.alertContent{
width: 100%;
}
.alertContentArea{
width: 100%;
}
.spinner-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 반투명 검정 배경 */
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999; /* 다른 요소 위에 표시되도록 설정 */
    visibility: visible; /* 초기에는 숨겨진 상태 */
}

.custom-spinner {
    width: 100px; /* 원하는 크기로 조정 */
    height: 100px; /* 원하는 크기로 조정 */
    animation: spin 2s linear infinite; /* 추가적인 애니메이션이 필요하다면 */
}


</style>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">


    <script>
      document.addEventListener('DOMContentLoaded', (event) => {
    	  
        const notifyButton = document.getElementById('notifyButton');
        const notifyButton1 = document.getElementById('notifyButton1');
        const notificationBox = document.getElementById('notificationBox');

        notifyButton.addEventListener('click', (e) => {
            if (notificationBox.style.display === 'none' || notificationBox.style.display === '') {
            	e.stopPropagation();
                notificationBox.style.display = 'block'; // 박스 보이기
                alarmOff();
            } else {
                notificationBox.style.display = 'none'; // 박스 숨기기 
            }
        });
        notifyButton1.addEventListener('click', (e) => {
            if (notificationBox.style.display === 'none' || notificationBox.style.display === '') {
            	e.stopPropagation();
                notificationBox.style.display = 'block'; // 박스 보이기
                alarmOff();
            } else {
                notificationBox.style.display = 'none'; // 박스 숨기기
            }
        });
        
        // 알림창 외부를 클릭했을 때 알림창 닫기
        document.addEventListener('click', () => {
            if (notificationBox.style.display === 'block') {
                notificationBox.style.display = 'none';
                checkForNotifications();
            }
        });
        notificationBox.addEventListener('click', (e) => {
            e.stopPropagation();
            checkForNotifications();
        });
        
        
        // 세션에서 배경색 정보를 읽어옵니다.
        var bgColor = '${sessionScope.bgcolor}';

        // 색상 값을 매핑합니다.
        var colorMap = {
       		'green': '#A8E2D2',      // 파스텔 녹색
       		'pink': '#F4A6B8',       // 파스텔 핑크
       		'lightgreen': '#B7D98D', // 파스텔 연두색
       		'brown': '#D1B7B0',      // 파스텔 갈색
       		'yellow': '#F9E59B'      // 파스텔 노란색
        };

        // 루트 CSS 변수 업데이트
        document.documentElement.style.setProperty('--main-bgcolor', colorMap[bgColor] || colorMap['green']);
        
        //red의 경우 checked 글자도 변경
/*         if (bgColor === 'red' || bgColor === 'orange' || bgColor === 'blue') {
        	document.documentElement.style.setProperty('--todo-checked', '#fff');	
        } */
        
    });
    
    function checkForNotifications() {
    	
    	//알림창 켜져있으면 버튼 안바뀌게 처리.
    	if(notificationBox.style.display === 'block'){
    		return;
    	}
    	
    	fetch(`${pageContext.request.contextPath}/ajaxNotification`, {
            method: 'GET', // HTTP 메서드 설정
            headers: {
                'Accept': 'application/json', // 서버로부터 JSON 형식의 응답을 기대
          //      'Content-Type': 'application/json; charset=utf-8' // 클라이언트가 JSON 형식으로 데이터를 보낼 것임을 명시
            }
        })
        .then(response => {
        // 응답 상태가 OK(200)인지 확인
        if (!response.ok) {
            throw new Error('Network response was not ok.');
        }
        return response.json(); // JSON 형태로 응답 본문을 변환
	    })
	            .then(data => {
	        // 데이터를 성공적으로 가져왔을 때 실행
	        if (Array.isArray(data) && data.length > 0) {
	            // 새 알림이 있을 경우 처리
	             $('#alertContentArea').empty();

                // 알림 메시지 추가
                data.forEach(function(item) {
                	var alertNo = 'contentNo-'+item.alertid;
                    $('#alertContentArea').append('<div id="'+ alertNo +'" class="alertContent" onclick="getDetail('+item.alertid+',\''+ item.category+'\',\''+item.detail+'\')">  </div>');
                    $('#'+alertNo).append('<p>' + item.message + '</p>');
                    $('#'+alertNo).append('<p class="alertTimeStamp">' + item.senddate + '</div>');
                    $('#'+alertNo).append('<hr class="alerthr">');
                });

	            //console.log(data);
	            alarmOn(); // 알림 표시 기능 호출
	        } else {
	        	//알림이 없을 때
	            //console.log("No new notifications");
	        }
	    })
	    .catch(error => {
	        // 네트워크 오류나 JSON 변환 오류 등 예외 처리
	        console.error('Error:', error);
	    });
	        // 다음 체크 주기 설정 (예: 5초)  
	        setTimeout(checkForNotifications, 5000);
	    }

    
    // 페이지 로드 시 알림 체크 시작
    window.onload = checkForNotifications;
    
    
  	//알림이 있으면 알림 있는 이미지로 변경하는 내용.
    function alarmOn() {
    	 var img = document.getElementById('alarm');
        img.src = '${pageContext.request.contextPath}/resources/images/alarm2.png';
    }
    function alarmOff() {
    	 var img = document.getElementById('alarm');
        img.src = '${pageContext.request.contextPath}/resources/images/alarm.png';
    }
    
    //이동 url
    function getDetail(alertno1, category, detail){
    	
    	var nextpage = '${pageContext.request.contextPath}/testUrl?alertid='+alertno1+ '&nextpage=';
    	if(category == 'calendar'){
    		nextpage = nextpage + 'calendar';
    	}else if(category == 'wiki'){
    		nextpage = nextpage+ 'detailNote?id=' + detail;
    	}else if(category == 'like'){
    		nextpage = nextpage+ 'detailNote?id=' + detail;
    	}else if(category == 'comment'){
    		nextpage = nextpage+ 'detailNote?id=' + detail;
    	}else if(category == 'notice'){
    		nextpage = nextpage + 'notice';
    	}else if(category == 'subscribe'){
    		nextpage = nextpage + 'detailNote?id='  + detail;
    	}else if(category == 'follow'){
    		nextpage = nextpage + 'mypage';
    	}
    	
    	window.location.href = nextpage;
    }
    
    
    function logout(){
    	alert("정상적으로 로그아웃 되었습니다.");
    	window.location.href = "${pageContext.request.contextPath}/logout";
    }
    

    
    </script>

<!-- 로그인 정합성 체크 멈추려면 여기 밑에 스크립트 주석하기 ! -->
<%
	String userno1 = (String) session.getAttribute("userno");
%>
<script type="text/javascript">
 window.onload = function() {
     var currentPath = window.location.pathname;
     var loginPath = '/login';
     var findPassword = '/findPassword'
     var setNewPassword = '/setNewPassword'
     var resetPassword = '/resetPassword'
     
     var userno = '<%= userno1 %>';

     // 현재 페이지가 로그인 페이지가 아니면 로그인 상태를 확인
     if (currentPath == loginPath||currentPath == findPassword||currentPath == setNewPassword||currentPath == resetPassword) {
     }else{
     	 if(userno == null || userno == "null"){
			alert("로그인 후 이용하세요.");
			window.location.href = '${pageContext.request.contextPath}/login'
         }else{ 
         }
     }
     
     checkForNotifications();
 };
 
 function loginCheck(){
     var currentPath = window.location.pathname;
     var loginPath = '/login';
     var findPassword = '/findPassword'
     var setNewPassword = '/setNewPassword'
     var resetPassword = '/resetPassword'
     
     var userno = '<%= userno1 %>';

     // 현재 페이지가 로그인 페이지가 아니면 로그인 상태를 확인
     if (currentPath == loginPath||currentPath == findPassword||currentPath == setNewPassword||currentPath == resetPassword) {
     }else{
     	 if(userno == null || userno == "null"){
			alert("로그인 후 이용하세요.");
			window.location.href = '${pageContext.request.contextPath}/login'
         }else{ 
         }
     }
     
     checkForNotifications();
	 
 }
</script>

</head>

<body>
<header>
<div class="header_outline">
<div class="header_innerBox">
<a href="${pageContext.request.contextPath}/main" > <img  class="header_logo" src="${pageContext.request.contextPath}/resources/images/mainLogo.png"></a>
 <div class="header_innerText"><a href="${pageContext.request.contextPath}/main" style="color: inherit; font-family: inherit; font-size: inherit; text-decoration: none; ">김국민의 업무노트</a></div>
</div>
 <div class="header_iconArea">
 	<c:choose>
        <c:when test="${not empty sessionScope.userno}">
		 	<img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/logout.png" onclick="logout()">
        </c:when>
        <c:otherwise>
        	<a href="${pageContext.request.contextPath}/login" > <img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/login.png"></a>
        </c:otherwise>
    </c:choose>
 
    <a href="${pageContext.request.contextPath}/calendar"><img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/calendar.png"></a>
    <a href="${pageContext.request.contextPath}/mypage"> <img  class="header_icon" src="${pageContext.request.contextPath}/resources/images/mypage.png"></a>
    <a href="#;"  id="notifyButton"><img id="alarm" class="header_icon" src="${pageContext.request.contextPath}/resources/images/alarm.png"></a>
    <a href="${pageContext.request.contextPath}/setting"><img class="header_icon" src="${pageContext.request.contextPath}/resources/images/setting2.png"></a>
       
 </div>
</div>
</header>
    <div id="notificationBox" class="notification-box1" style="width: 320px;">
    <div><a href="#;" class="deleteButton11" id="notifyButton1">X</a></div>
    <div id="alertContentArea" class="alertContentArea" > 
    	<div class="alertContent">
	    	<div style="margin-top: 50px; text-align: center;">
			<iframe src="https://giphy.com/embed/EDgXbeWptb15W9Ed3j" width="150" height="150" style="pointer-events: none;"  frameBorder="0" class="giphy-embed" allowFullScreen></iframe>
	        <p id="alertTitle">새로운 알림이 없습니다!</p>
			</div>
        </div>
        
    </div>
    </div>


</body>
</html>