<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>증시 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/display.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

<body>

    <%@ include file="/WEB-INF/views/header.jsp"%>

    <div class="content_outline">
        <%@ include file="/WEB-INF/views/sidebar.jsp"%>        
        <div class="content_right">
        <div class="tab_area">
				        <span class="tab" data-tab="tab1">국내증시</span>
				        <span class="tab" data-tab="tab2">해외증시</span>
				    </div>
               		<hr>
                
	                <!-- tab 1 -->
				    <div id="tab1" class="tab_content active">
					    <div class="tab_rank">
						    <div class="rankbox">
						    	<h4 class="card_title">BEST 저자</h4>
						    	<hr>
								<ul>
									<li>김wogus</li>
									<li>무느재우그</li>
								</ul>
						    </div>
						    <div class="rankbox">
						    	<h4 class="card_title">BEST 게시글</h4>
						    	<hr>
								<ul>
									<li>꿘예지 - 개인여신총정리</li>
									<li>꿘예지</li>
								</ul>
						    </div>
					    </div>
				    </div>
	
				    <!-- tab 2 -->
				    <div id="tab2" class="tab_content">
				    	<div class="reply_like">
				    		<div class="card_top">
							    <div class="title_and_link">
							        <h3 class="card_title">댓글/좋아요</h3>
							        <a href="#" class="link-icon">바로가기</a>
							    </div>
					    	</div>
				    		<hr>
				    		
				    		<div class="tab_table">
					    		<table style="width: 100%;">
								    <colgroup>
								        <col style="width: 30%;">  <!-- 첫 번째 열의 너비를 30%로 설정 -->
								        <col style="width: 70%;">  <!-- 두 번째 열의 너비를 70%로 설정 -->
								    </colgroup>
					    			<tr>
					    				<td>2024.07.12 15:07</td>
					    				<td>꿘예지님이 내 메뉴얼을 좋아합니다.</td>
					    			</tr>
					    			<tr>
					    				<td>2024.07.12 09:35</td>
					    				<td>성은초이님이 댓글을 남겼습니다.</td>
					    			</tr>
					    		</table>
				    		</div>
				    	</div>
				    </div>
                
                    <!-- <h2 class="card_title">국내증시</h2>
                    <hr>
                    
                    <h2 class="card_title">해외증시</h2>
                    <hr> -->
        </div>
    </div>
    
<script>

document.addEventListener('DOMContentLoaded', function () {
    const tabs = document.querySelectorAll('.tab');
    const contents = document.querySelectorAll('.tab_content');

    tabs.forEach(tab => {
        tab.addEventListener('click', function () {
            tabs.forEach(item => item.classList.remove('active'));
            contents.forEach(content => content.classList.remove('active'));

            tab.classList.add('active');
            document.getElementById(tab.dataset.tab).classList.add('active');
        });
    });

    // 첫 번째 탭 자동 활성화
    const firstTab = document.querySelector('.tab:first-child');
    if (firstTab) {
        firstTab.click(); // 이벤트를 강제로 호출하여 첫 탭을 활성화
    }
});

 /* 
 document.addEventListener('DOMContentLoaded', function() {
	    // 완료 현황 업데이트
	    updateTodoCount();
	    
	    // 탭 활성화 로직
	    const tabs = document.querySelectorAll('.tab');
	    tabs.forEach(tab => {
	        tab.addEventListener('click', function() {
	            // 모든 탭에서 'active' 클래스 제거
	            tabs.forEach(t => {
	                t.classList.remove('active');
	                const content = document.querySelector('#' + t.getAttribute('data-tab'));
	                if (content) {
	                    content.classList.remove('active');
	                }
	            });
	            // 클릭된 탭에 'active' 클래스 추가
	            this.classList.add('active');
	            const targetContent = document.querySelector('#' + this.getAttribute('data-tab'));
	            if (targetContent) {
	                targetContent.classList.add('active');
	            }
	        });
	    });

	    // 첫 번째 탭 자동 활성화
	    const firstTab = document.querySelector('.tab:first-child');
	    if (firstTab) {
	        firstTab.click(); // 이벤트를 강제로 호출하여 첫 탭을 활성화
	    }
	}); */



</script>

</body>
</html>