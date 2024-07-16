<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="content_outline">
	<%@ include file="/WEB-INF/views/sidebar.jsp" %>
	<div class="content_right">
	    
	    <div class="board_top">
	    	<div class="board_inner">
				<div class="card_top">
				    <div class="title_and_link div_underline">
				        <h2 class="card_title">환율</h2>
				        <a href="#" class="link-icon">바로가기</a>
				    </div>
				    
				    <div class="currency-body">
						<div class="currency-row1">
							<span>&nbsp;</span>
						    <span>매입</span>
						    <span>매도</span>
						    <span>기준환율</span>
						</div>
				        <div class="currency-row">
				            <img src="${pageContext.request.contextPath}/resources/images/flags/us.png" alt="USA">
				            <span>1,373.60</span>
				            <span>1,349.57</span>
				            <span>1,349.57</span>
				        </div>
				        <div class="currency-row">
				            <img src="${pageContext.request.contextPath}/resources/images/flags/jp.png" alt="Japan">
				            <span>1,373.60</span>
				            <span>1,349.57</span>
				            <span>1,349.57</span>
				        </div>
				        <div class="currency-row">
				            <img src="${pageContext.request.contextPath}/resources/images/flags/cn.png" alt="China">
				            <span>1,373.60</span>
				            <span>1,349.57</span>
				            <span>1,349.57</span>
				        </div>
				    </div>
				</div>
	    	</div>
	    	<div class="board_inner">
	    		<div class="card_top">
				    <div class="title_and_link div_underline">
				        <h2 class="card_title">증시</h2>
				        <a href="#" class="link-icon">바로가기</a>
				    </div>
		    	</div>
	    	</div>
	    	<div class="board_inner">
	    		<div class="card_top">
				    <div class="title_and_link div_underline">
				        <h2 class="card_title">금리</h2>
				        <a href="#" class="link-icon">바로가기</a>
				    </div>
		    	</div>
	    	</div>
	    </div>
	    
	    <div class="board_bottom">
	    	<div class="board_inner2">
				<div class="board_inner_inner">
		    		<div class="card_top">
					    <div class="title_and_link">
					        <h2 class="card_title">To Do List</h2>
					        <a href="#" class="link-icon">바로가기</a>
					    </div>
			    	</div>
			    	<hr>
				</div>
				<div class="board_inner_inner">
		    		<div class="card_top">
					    <div class="title_and_link">
					        <h2 class="card_title">My Memo</h2>
					        <a href="#" class="link-icon">바로가기</a>
					    </div>					    
			    	</div>
			    	<hr>
				</div>
	    	</div>
	    	<div class="board_inner3">
	    		<!-- 탭(선택영역) -->
			    <div class="tab_area">
			        <span class="tab" data-tab="tab1">랭킹</span>
			        <span class="tab" data-tab="tab2">댓글/좋아요</span>
			        <span class="tab" data-tab="tab3">울지점 공지</span>
			    </div>
			    
			    <!-- 선택된 영역에 따라 노출되는 컨텐츠 영역 -->
			    
			    <!-- tab 1 -->
			    <div id="tab1" class="tab_content active">
				    <div class="tab_rank">
					    <div class="rankbox">
					    	<h4 class="card_title">BEST 저자</h4>
					    	<hr>
							<ul>
								<li>김wogus</li>
								<li>무느재우그</li>
								<li>성은초이</li>
								<li>꿘예지</li>
							</ul>
					    </div>
					    <div class="rankbox">
					    	<h4 class="card_title">BEST 게시글</h4>
					    	<hr>
							<ul>
								<li>꿘예지 - 개인여신총정리</li>
								<li>꿘예지</li>
								<li>성은초이</li>
								<li>무느재우그</li>
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
				    			<tr>
				    				<td>2024.07.11 12:33</td>
				    				<td>재현킴님이 댓글을 남겼습니다.</td>
				    			</tr>
				    			<tr>
				    				<td>2024.07.09 12:35</td>
				    				<td>문쟁국님이 내 노트를 좋아합니다.</td>
				    			</tr>
				    			<tr>
				    				<td>2024.07.09 12:35</td>
				    				<td>문쟁국님이 내 노트를 좋아합니다.</td>
				    			</tr>
				    			<tr>
				    				<td>2024.07.09 12:35</td>
				    				<td>문쟁국님이 내 노트를 좋아합니다.</td>
				    			</tr>
				    		</table>
			    		</div>
			    	</div>
			    </div>
			    <!-- tab 3 -->
			    <div id="tab3" class="tab_content">
			    	<div class="reply_like">
			    		<div class="card_top">
						    <div class="title_and_link">
						        <h3 class="card_title">울지점 공지</h3>
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
				    				<td>(지점장) 오늘 열심히 일해봅시다.</td>
				    			</tr>
				    			<tr>
				    				<td>2024.07.12 09:35</td>
				    				<td>(상판팀장) 오늘은 이걸 팔아봅시다.</td>
				    			</tr>
				    			<tr>
				    				<td>2024.07.11 12:33</td>
				    				<td>(00대리) 오늘 커피먹고 일해요.</td>
				    			</tr>
				    			<tr>
				    				<td>2024.07.09 12:35</td>
				    				<td>(00계장) 회식장소 공지드립니다!!</td>
				    			</tr>
				    			<tr>
				    				<td>2024.07.09 12:35</td>
				    				<td>(00계장) 회식장소 공지드립니다!!</td>
				    			</tr>
				    			<tr>
				    				<td>2024.07.09 12:35</td>
				    				<td>(00계장) 회식장소 공지드립니다!!</td>
				    			</tr>
				    		</table>
			    		</div>
			    	</div>
			    </div>
	    	</div>
	    </div>
	</div> 
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 모든 탭에 클릭 이벤트 리스너 추가
    document.querySelectorAll('.tab').forEach(tab => {
        tab.addEventListener('click', function() {
            // 모든 탭에서 'active' 클래스 제거
            document.querySelectorAll('.tab').forEach(t => {
                t.classList.remove('active');
            });
            // 모든 탭 내용에서 'active' 클래스 제거
            document.querySelectorAll('.tab_content').forEach(content => {
                content.classList.remove('active');
            });
            // 클릭된 탭에 'active' 클래스 추가
            this.classList.add('active');
            const targetContent = document.querySelector('#' + this.getAttribute('data-tab'));
            if (targetContent) {
                targetContent.classList.add('active');
            }
        });
    });

    // 페이지 로드 시 첫 번째 탭 활성화
    const firstTab = document.querySelector('.tab:first-child');
    const firstContentId = firstTab ? firstTab.getAttribute('data-tab') : null;
    const firstContent = document.querySelector('#' + firstContentId);
    if (firstTab && firstContent) {
        firstTab.classList.add('active');
        firstContent.classList.add('active');
    }
});

</script>
</body>
</html>