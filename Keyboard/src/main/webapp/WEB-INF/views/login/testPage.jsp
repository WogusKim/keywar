<%@ page language="java" contentType="text/html; charset=UTF-8"                                                  
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 테스트 페이지</title>

<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.color-box{
	width: 18px;
	height: 18px;
	border-radius: 70%;
    overflow: hidden;
    margin: auto;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.color-box:hover {
    transform: scale(1.15); /* 크기를 20% 정도 확대 */
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3); /* 마우스 오버 시 그림자 추가 */
}
.color-box-container {
    display: grid;
    grid-template-columns: repeat(6, 1fr); /* 각 행에 6개의 div */
    grid-template-rows: repeat(4, auto);   /* 4줄을 자동으로 생성 */
    gap: 5px; /* div 사이의 간격 */
    width : 170px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
    padding: 5px; /* 그림자가 더 잘 보이도록 여백 추가 */
    border-radius: 8px; /* 모서리 둥글게 (선택 사항) */
    padding-top: 20px;
    padding-bottom: 20px;
    z-index: 100;
}
.check-icon-inner-color{
	display: none;
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<div class="content_outline">
	<%@ include file="/WEB-INF/views/sidebar.jsp" %>
	<div class="content_right">
 		<div class="color-box-container" >
			<div class="color-box" style="background-color: #AD1457;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #F4511E;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #E4C441;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #0B8043;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #3F51B5;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #8E24AA;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			                                                        
			<div class="color-box" style="background-color: #D81B60;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #EF6C00;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #C0CA33;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #009688;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #7986CB;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #795548;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			                                                        
			<div class="color-box" style="background-color: #D50000;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #F09300;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #7CB342;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #039BE5;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #B39DDB;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #616161;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>

			<div class="color-box" style="background-color: #E67C73;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #F6BF26;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #33B679;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #4285F4;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #9E69AF;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
			<div class="color-box" style="background-color: #A79B8E;"><img class="check-icon-inner-color"  src="${pageContext.request.contextPath}/resources/images/check-mark.png"></div>
		</div>
	</div>	
</div>   	
<script>
$(document).ready(function() {
    $('.color-box').on('click', function() {
    	var bgColor = $(this).css('background-color');
        alert("bgcolor : " +bgColor);
        // 모든 color-box 내부의 img 요소를 숨김
        $('.color-box .check-icon-inner-color').css('display', 'none');
        // 클릭된 color-box 내부의 img 요소만 보이도록 설정
        $(this).find('.check-icon-inner-color').css('display', 'block');
        $('.color-box-container').css('display', 'none');
      	$('#color-viewer').css('background-color', bgColor);
        $('#colorPicker').val(bgColor);
        alert($('#colorPicker').val());
    });
});
</script>
</body>
</html>
