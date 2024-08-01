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
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />

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
	overflow-y: auto; 
}
.profileArea{
width:40%; 
margin:auto; 
display: flex; 
justify-content: space-between;
min-width: 100px;
}
.aTag{
    text-decoration: none;
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

<div class="content_outline">
	<%@ include file="/WEB-INF/views/sidebar.jsp" %>
	<div class="content_right" >
		<div class="board_currency">
			<div class="board_currency_inner" style="background-color: #92D1BA; ">
				<div class="outlineBox">
					<div style="float: left;"><h2 class="card_title">마이페이지</h2></div><div style="float: right;">
						<a href="${pageContext.request.contextPath}/editProfile"> <img class="header_icon" style="margin-top: 5px;" src="${pageContext.request.contextPath}/resources/images/setting.png"> </a></div>
				</div>
				<hr>
				<div class="outlineBox" style="height: 40%">
				<div class="white_Box" style="width: 25%; text-align: center;"> 
				<div class="box" style="background: #BDBDBD; ">
    				 <img class="profile" src="${pageContext.request.contextPath}/getUserProfilePicture?userno=${dto.userno}" alt="Profile Picture">
				</div>
				<h3 class="stress_Text" style="margin-top: 15px;" >${dto.username } </h3>
				
				<!-- 좋아요 + 팔로우 표시 -->
				<div class="profileArea" >
					<img src="${pageContext.request.contextPath}/resources/images/heart16.png" > <span>${myLikeCount}</span> 
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
					<div class="switchBox" id="switchBox1" style="display: block;">
					<table style="width: 100%; table-layout: fixed; padding: 5px;">
						<colgroup>
							<col style="width: 50%;">
						    <col style="width: 30%;">
						    <col style="width: 20%;">
						</colgroup>
						
						<c:forEach var="comment" items="${comment}">
						<tr>
							<td style="max-width:50%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; ">
								<a href="${pageContext.request.contextPath}/detailNote?id=${comment.targetid}#comment-id-${comment.commentid}">${comment.content }</a>
							</td>
							<td style="color: gray; font-size: small; max-width:30%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; ">${comment.titleShare }</td>
							<td style="color: gray; font-size: small;">${comment.createdate }</td>
						</tr>
						</c:forEach>
					</table>
					</div>
					<div class="switchBox" id="switchBox2" style="display: none;"> 2 2 2 2 2 2 2 2 2 2 2</div>
					<div class="switchBox" id="switchBox3" style="display: none;"> 3 3 3 3 3 3 3 3 3 3 </div>
				
				</div>
				</div>
				
				<div class="outlineBox" style="height: 45%">
				<div class="white_Box" style="width: 100%; margin-top: 20px;"> 
				<h3 class="stress_Text">내가 공유한 업무노트 </h3>
				<div style="overflow-y: auto; height: 85%; margin-top: 20px; width: 100%; padding: 5px;">
				<table style="width: 100%; ">
				<colgroup>
       	 			<col style="width: 65%;">
       	 			<col style="width: 7%;">
       	 			<col style="width: 7%;">
       	 			<col style="width: 7%;">
       	 			<col style="width: 7%;">
       	 			<col style="width: 7%;">
    			</colgroup>
    			<tbody>
    			<c:forEach var="post" items="${mypost}">

					<tr><!-- 여기 DB에서 가져와서 포문 돌릴거임 !! -->
					<td style="max-width:50%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${post.titleShare}</td>
					<td><img class="mini_icon" src="${pageContext.request.contextPath}/resources/images/heart16.png"><a href="#" class="aTag"> 좋아요 ${post.like_count}</a></td>
					<td ><img class="mini_icon" src="${pageContext.request.contextPath}/resources/images/chat16.png"><a href="#" class="aTag"> 댓글 ${post.comment_count}</a></td> <!-- 여기 한글 대신 DB에 저장된 다른 숫자 등 보이게 할 거임. -->
					<td><img class="mini_icon" src="${pageContext.request.contextPath}/resources/images/eyes.png"><a href="#" class="aTag"> 조회수</a></td>
					<td style="text-align: center;"><img class="mini_icon" src="${pageContext.request.contextPath}/resources/images/edit.png"><a href="${pageContext.request.contextPath}/wikiDetail?id=${post.id}" class="aTag"> 수정</a></td>
					<td style="text-align: center;"><img class="mini_icon" src="${pageContext.request.contextPath}/resources/images/delete.png"><a href="#" class="aTag"> 삭제</a></td>
					</tr>
				</c:forEach>
				</tbody>
				</table>
				</div>
				
				
				</div>
				</div>
			</div>
		</div>

	</div>
</div>

</body>
</html>