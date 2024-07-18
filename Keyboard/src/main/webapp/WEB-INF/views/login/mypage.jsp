<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 마이페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/display.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

.content_innerBox {
    border-radius: 10px;
	width: 100%; 
	height: 100%;
	background-color: #BDE2CE;
	padding: 18px;
    margin-bottom: 10px;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}
.outlineBox{
	display: flex; 
	justify-content: space-between;
}   
.white_Box{
	background-color: white;
	border-radius: 10px;
	height: 100%;
	padding: 20px;
	margin-bottom: 15px;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
	margin: 5px;
}
.stress_Text{
	margin: 5px;
}
.mypageButton{
	background-color: #EBF8FE;
	border-radius: 10px;
	border: none;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
	margin : 5px;
	font-size: 15px;
	width: 130px;
	height: 27px;
	cursor: pointer;

}
.pushedButton{
	background-color: #92D1BA;
}
/* mypage profile box */
.box {
    width: 150px;
    height: 150px; 
    border-radius: 70%;
    overflow: hidden;
    margin: auto;
}
/* mypage profile image */
.profile {  
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.switchBox{
	width: 100%; 
	height: 80%; 
	margin-top: 10px; 
	padding: 10px;
}
.profileArea{
width:40%; 
margin:auto; 
display: flex; 
justify-content: space-between;
min-width: 100px;
}
</style>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var box1 = document.getElementById('switchBox1');
        var box2 = document.getElementById('switchBox2');
        var box3 = document.getElementById('switchBox3');
        var buttons = document.querySelectorAll('.mypageButton');

        function updateButtonStyles(activeButton) {
            buttons.forEach(function(button) {
                button.classList.remove('pushedButton');
            });
            activeButton.classList.add('pushedButton');
        }

        function btn1() {
            box1.style.display = 'block';
            box2.style.display = 'none';
            box3.style.display = 'none';
            updateButtonStyles(this);
        }

        function btn2() {
            box1.style.display = 'none';
            box2.style.display = 'block';
            box3.style.display = 'none';
            updateButtonStyles(this);
        }

        function btn3() {
            box1.style.display = 'none';
            box2.style.display = 'none';
            box3.style.display = 'block';
            updateButtonStyles(this);
        }

        document.querySelector('.mypageButton:nth-child(1)').addEventListener('click', btn1);
        document.querySelector('.mypageButton:nth-child(2)').addEventListener('click', btn2);
        document.querySelector('.mypageButton:nth-child(3)').addEventListener('click', btn3);
    });
</script>

</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="content_outline" style="height:  100%;">
	<%@ include file="/WEB-INF/views/sidebar.jsp" %>
	<div class="content_right" style="height:  90%;">
		<div class="board_currency">
			<div class="board_currency_inner" style="background-color: #92D1BA; ">
				<div class="outlineBox">
					<div style="float: left;"><h2 class="card_title">마이페이지</h2></div><div style="float: right;"><img class="header_icon" style="margin-top: 5px;" src="${pageContext.request.contextPath}/resources/images/setting.png"></div>
				</div>
				<hr>
				<div class="outlineBox" style="height: 40%">
				<div class="white_Box" style="width: 25%; text-align: center;"> 
				<div class="box" style="background: #BDBDBD; ">
    				<img class="profile" src="${pageContext.request.contextPath}/resources/images/background.jpg">
				</div>
				<h3 class="stress_Text" style="margin-top: 15px;" >${dto.username } </h3>
				
				<!-- 좋아요 + 팔로우 표시 -->
				<div class="profileArea" >
					<img src="${pageContext.request.contextPath}/resources/images/heart16.png" > <span>875</span>
					<img src="${pageContext.request.contextPath}/resources/images/follow16.png" > <span>74</span>
				</div>
				
				<div> </div>
				
				
				</div>
				<div class="white_Box" style="width: 73%"> 
					<div class="outlineBox" ><h3 class="stress_Text" >나의 활동</h3> 
					<div>
					<button class="mypageButton pushedButton">내가 남긴 댓글</button><button class="mypageButton" >좋아하는 게시물</button><button class="mypageButton">팔로우</button>
					</div>
					</div>
					<div class="switchBox" id="switchBox1" style="display: block;"> 1 1 11 1 11 1 1 </div>
					<div class="switchBox" id="switchBox2" style="display: none;"> 2 2 2 2 2 2 2 2 2 2 2</div>
					<div class="switchBox" id="switchBox3" style="display: none;"> 3 3 3 3 3 3 3 3 3 3 </div>
				
				</div>
				</div>
				
				<div class="outlineBox" style="height: 45%">
				<div class="white_Box" style="width: 100%; margin-top: 20px;"> 
				<h3 class="stress_Text">내가 작성한 업무노트 </h3>
				
				
				
				
				
				</div>
				</div>
			</div>
		</div>

	</div>
</div>

<!-- 
<script>
	var box1 = document.getElementById('switchBox1');
	var box2 = document.getElementById('switchBox2');
	var box3 = document.getElementById('switchBox3');
	
	function btn1(){
		box1.style.display ='block';
		box2.style.display ='none';
		box3.style.display ='none';
	}
	function btn2(){
		box1.style.display ='none';
		box2.style.display ='block';
		box3.style.display ='none';
	}
	function btn3(){
		box1.style.display ='none';
		box2.style.display ='none';
		box3.style.display ='block';
	}

</script> -->


</body>
</html>