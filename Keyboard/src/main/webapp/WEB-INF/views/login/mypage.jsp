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
<% String userno = (String) session.getAttribute("userno"); %>
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
	background-color: #ffffff73;
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
	background-color: var(--main-bgcolor);
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

</style>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var box1 = document.getElementById('switchBox1');
        var box2 = document.getElementById('switchBox2');
        var box3 = document.getElementById('switchBox3');
        var box4 = document.getElementById('switchBox4');
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
            box4.style.display = 'none';
            updateButtonStyles(this);
        }
        function btn2() {
            box1.style.display = 'none';
            box2.style.display = 'block';
            box3.style.display = 'none';
            box4.style.display = 'none';
            updateButtonStyles(this);
        }
        function btn3() {
            box1.style.display = 'none';
            box2.style.display = 'none';
            box4.style.display = 'none';
            box3.style.display = 'block';
            updateButtonStyles(this);
        }
        function btn4() {
            box1.style.display = 'none';
            box2.style.display = 'none';
            box3.style.display = 'none';
            box4.style.display = 'block';
            updateButtonStyles(this);
        }
        document.querySelector('.mypageButton:nth-child(1)').addEventListener('click', btn1);
        document.querySelector('.mypageButton:nth-child(2)').addEventListener('click', btn2);
        document.querySelector('.mypageButton:nth-child(3)').addEventListener('click', btn3);
        document.querySelector('.mypageButton:nth-child(4)').addEventListener('click', btn4);
    });
</script>

</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="content_outline">
	<%@ include file="/WEB-INF/views/sidebar.jsp" %>
	<div class="content_right" >
		<div class="board_currency">
			<div class="board_currency_inner" style="background-color: #ffffff73; ">
				<div class="outlineBox">
					<div style="float: left;"><h2 class="card_title">마이페이지</h2></div><div style="float: right;">
						<%-- <a href="${pageContext.request.contextPath}/editProfile"> <img class="header_icon" style="margin-top: 5px;" src="${pageContext.request.contextPath}/resources/images/setting.png"> </a> --%>
					</div>
				</div>
				<hr>
				<div class="outlineBox" style="height: 40%">
				<div class="white_Box" style="width: 25%; text-align: center;"> 
				<div class="box" style="background: #BDBDBD; margin-bottom: 20px; ">
    				 <img class="profile" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=${dto.profile}" alt="Profile Picture">
				</div>
				<b class="stress_Text" style="" >${dto.username } ( ${dto.nickname } )</b>
				<a href="${pageContext.request.contextPath}/editProfile"><img  src="${pageContext.request.contextPath}/resources/images/icons/edit.png" style="width: 16px; height: 16px; vertical-align: middle; cursor: pointer;"></a>
				
				<!-- 좋아요 + 팔로우 표시 -->
				<div class="profileArea" style="margin-top: 20px;">
					<img src="${pageContext.request.contextPath}/resources/images/heart16.png" > <span>${myLikeCount}</span> 
					<img src="${pageContext.request.contextPath}/resources/images/follow16.png" > <span>${myFollowCount}</span>
				</div>
				
				<div> </div>
				
				
				</div>
				<div class="white_Box" style="width: 73%"> 
					<div class="outlineBox" ><h3 class="stress_Text" >나의 활동</h3> 
					<div>
					<button class="mypageButton pushedButton">내가 남긴 댓글</button><button class="mypageButton" >좋아하는 게시물</button><button class="mypageButton">팔로잉</button><button class="mypageButton">팔로워</button>
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
								<a class="aTag" href="${pageContext.request.contextPath}/detailNote?id=${comment.targetid}#comment-id-${comment.commentid}">${comment.content }</a>
							</td>
							<td style="color: gray; font-size: small; max-width:30%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; ">${comment.titleShare }</td>
							<td style="color: gray; font-size: small;">${comment.createdate }</td>
						</tr>
						</c:forEach>
					</table>
					</div>
					<div class="switchBox" id="switchBox2" style="display: none;">
					
						<table style="width: 100%; table-layout: fixed; padding: 5px;">
						<c:forEach var="likedpost" items="${likedpost}">
						<tr>
							<td><a class="aTag" href="${pageContext.request.contextPath}/detailNote?id=${likedpost.id}">${likedpost.titleShare} <span style="color: gray; font-size: small; margin-left: 10px;"> ${likedpost.nickname}</span></a></td>
						</tr>
						</c:forEach>
						</table>

					 
					 </div>
					 
					 
<style>
.writer_td {
	display: flex;
	align-items: center;
	justify-content: flex-start; /* 왼쪽 정렬 */	
}

.profile_link {
	cursor: pointer;
}

.profile-pic {
	width: 50px; /* 이미지 너비 설정 */
	height: 50px; /* 이미지 높이 설정 */
	border-radius: 50%; /* 이미지를 원형으로 만들기 */
	object-fit: cover; /* 이미지 비율 유지하면서 요소에 맞추기 */
	border: 2px solid #f4f4f4; /* 이미지 주변에 테두리 추가 */
	margin-right: 10px;
}
.styled-button {
    background-color: #6200ea;
    color: white;
	padding : 10px;
    font-size: 12px;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    text-transform: uppercase;
}

.styled-button:hover {
    background-color: #3700b3;
    transform: scale(1.05);
}

.styled-button:active {
    background-color: #1a00e6;
    transform: scale(1);
}

.styled-button:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(98, 0, 234, 0.5);
}
</style>
					 
					 <!-- 팔로우 영역 잡아놈 -->
					<div class="switchBox" id="switchBox3" style="display: none;">
				
						<c:forEach var="myFollowing" items="${myFollowing}">
						 <div class="writer_td" style="display: flex; justify-content: space-between;">
                    		<div class="profile_link" style="display: flex; " onclick="goToProfile(${myFollowing.userno})">
	                    		<div>
	                    			<img class="profile-pic" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=${myFollowing.userno}" />
	                    		</div>
	                    		<div style="margin-top: 5px; margin-left: 5px;">
	                    		${myFollowing.nickname} <br>
	                    		<span style="color: gray; font-size: small; margin-left: 2px;"> ${myFollowing.username} </span>
	                    		</div>
                    		</div>
                    		<!-- 팔로우, 언팔로우 영역123 -->
                    		<div>
                    		<button class="styled-button" onclick="followUp('${myFollowing.userno}')">구독취소</button>
                    		</div>
                    	
               	 		</div>
						</c:forEach>
						<c:if test="${ empty myFollowing}">
							<div style="text-align: center">
								<iframe src="https://giphy.com/embed/lmefcS3U29GrsmXu5D" width="130px;" height="130px;" style="pointer-events: none; margin: 0;" frameBorder="0"
									class="giphy-embed" allowFullScreen></iframe>
							</div>
							<div style="color:gray; text-align: center">
							구독한 사용자가 없습니다. <br>사람들을 구독하고 게시물 등록 알림을 받아보세요 !
							</div>
						</c:if>
					</div>
					<div class="switchBox" id="switchBox4" style="display: none;">
					
					<c:forEach var="myFollower" items="${myFollower}">
						 <div class="writer_td" style="display: flex; justify-content: space-between;">
                    		<div style="display: flex; " onclick="goToProfile(${myFollower.userno})">
	                    		<div>
	                    			<img class="profile-pic" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=${myFollower.userno}" />
	                    		</div>
	                    		<div style="margin-top: 5px; margin-left: 5px;">
	                    		${myFollower.nickname} <br>
	                    		<span style="color: gray; font-size: small; margin-left: 2px;"> ${myFollower.username} </span>
	                    		</div>
                    		</div>
                    		<!-- 팔로우, 언팔로우 영역123 -->
                    		<div>
                    	
                    		</div>
                    	
               	 		</div>
						</c:forEach>
					
					</div>
				</div>
				</div>
				
				<div class="outlineBox" style="height: 45%">
				<div class="white_Box" style="width: 100%; margin-top: 20px;"> 
				<h3 class="stress_Text">내가 공유한 업무노트 </h3>
				<div style="overflow-y: auto; height: 85%; margin-top: 20px; width: 100%; padding: 5px;">
				<table style="width: 100%; padding: 5px;">
				<colgroup>
       	 			<col style="width: 56%;">
       	 			<col style="width: 10%;">
       	 			<col style="width: 10%;">
       	 			<col style="width: 10%;">
       	 			<col style="width: 7%;">
       	 			<col style="width: 7%;">
    			</colgroup>
    			<tbody>
    			<c:forEach var="post" items="${mypost}">

					<tr><!-- 여기 DB에서 가져와서 포문 돌릴거임 !! -->
					<td style="max-width:50%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><a href="${pageContext.request.contextPath}/detailNote?id=${post.id}" class="aTag">${post.titleShare} <span style="color: gray; font-size: small;">${post.title}</span></a></td> 
					<td><img class="mini_icon" src="${pageContext.request.contextPath}/resources/images/heart16.png"><a href="${pageContext.request.contextPath}/detailNote?id=${post.id}#likeUp" class="aTag"> 좋아요 ${post.like_count}</a></td>
					<td ><img class="mini_icon" src="${pageContext.request.contextPath}/resources/images/chat16.png"><a href="${pageContext.request.contextPath}/detailNote?id=${post.id}#commentArea1" class="aTag"> 댓글 ${post.comment_count}</a></td> <!-- 여기 한글 대신 DB에 저장된 다른 숫자 등 보이게 할 거임. -->
					<td><img class="mini_icon" src="${pageContext.request.contextPath}/resources/images/eyes.png"><a href="${pageContext.request.contextPath}/detailNote?id=${post.id}" class="aTag"> 조회수 ${post.hits_count}</a></td>
					<td style="text-align: center;"><img class="mini_icon" src="${pageContext.request.contextPath}/resources/images/edit.png"><a href="${pageContext.request.contextPath}/wikiDetail?id=${post.id}" class="aTag"> 수정</a></td>
					<!-- 삭제기능 아직 안되어있음/ -->
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
<script>
//팔로우
function followUp(userno1){
	
	var userno = '<%= userno %>';
	console.log(userno);
	
	if(userno == userno1){
		alert("자기 자신은 구독할 수 없습니다.");
		return;
	}
	
    fetch('${pageContext.request.contextPath}/followUp', {   
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
        	targetUserno : userno1,
            userno: userno,
            status : '1'
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        if(data.status == 'success'){
        	alert("정상적으로 구독하였습니다.");
        	location.reload();
        }else if(data.status == 'unFollow'){
        	alert("구독이 취소되었습니다.");
        	location.reload();
        }
    })
    .catch((error) => {
        console.error('Error:', error);
        alert("작업 중 오류가 발생하였습니다.");
    }); 
	
}
// 여기로 이동 ! (프로필 상세 페이지)
function goToProfile(userno){
	window.location.href = '${pageContext.request.contextPath}/profile?userno='+userno;
}

</script>
</body>
</html>