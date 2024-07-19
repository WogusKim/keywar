<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.util.List" %>
<%@ page import="kb.keyboard.warrior.dto.StockDTO" %>
<%@ page import="kb.keyboard.warrior.StockKoreaCrawler" %>
<%@ page import="kb.keyboard.warrior.StockInterCrawler" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<style>
.flag {
    display: inline-block;
    width: 50px; /* 새로운 너비 */
    height: 34px; /* 새로운 높이 */
    background: url('${pageContext.request.contextPath}/resources/images/flags/flag_all.png') no-repeat;
    background-size: 290px 760px; /* background-size 조정 */
}
.flag-krw {
    background-position: 0 0;
}
.flag-usd {
    background-position: 0 -64px;
}
.flag-jpy {
    background-position: 0 -128px;
}
.flag-cny {
    background-position: 0 -192px;
}
.flag-aud {
    background-position: 0 -256px;
}
.flag-gbp {
    background-position: 0 -320px;
}
.flag-cad {
    background-position: 0 -384px;
}
.flag-php {
    background-position: 0 -448px;
}
.flag-hkd {
    background-position: 0 -512px;
}
.flag-thb {
    background-position: 0 -576px;
}
.flag-eur {
    background-position: 0 -640px;
}
.flag-sgd {
    background-position: -80px 0;
}
.flag-inr {
    background-position: -80px -64px;
}
.flag-brl {
    background-position: -80px -128px;
}
.flag-twd {
    background-position: -80px -192px;
}
.flag-myr {
    background-position: -80px -256px;
}
.flag-chf {
    background-position: -80px -320px;
}
.flag-vnd {
    background-position: -80px -384px;
}
.flag-rub {
    background-position: -80px -448px;
}
.flag-idr {
    background-position: -80px -512px;
}
.flag-bdt {
    background-position: -80px -576px;
}
.flag-sek {
    background-position: -80px -640px;
}
.flag-nok {
    background-position: -160px 0;
}
.flag-huf {
    background-position: -160px -64px;
}
.flag-mxn {
    background-position: -160px -128px;
}
.flag-kwd {
    background-position: -160px -192px;
}
.flag-dkk {
    background-position: -160px -256px;
}
.flag-egp {
    background-position: -160px -320px;
}
.flag-pln {
    background-position: -160px -384px;
}
.flag-sar {
    background-position: -160px -448px;
}
.flag-ils {
    background-position: -160px -512px;
}
.flag-pkr {
    background-position: -160px -576px;
}
.flag-bhd {
    background-position: -160px -640px;
}
.flag-jod {
    background-position: -240px 0;
}
.flag-bnd {
    background-position: -240px -64px;
}
.flag-aed {
    background-position: -240px -128px;
}
.flag-mnt {
    background-position: -240px -192px;
}
.flag-kzt {
    background-position: -240px -256px;
}
.flag-try {
    background-position: -240px -320px;
}
.flag-czk {
    background-position: -240px -384px;
}
.flag-qar {
    background-position: -240px -448px;
}
.flag-nzd {
    background-position: -240px -512px;
}
.flag-zar {
    background-position: -240px -576px;
}
.flag-clp {
    background-position: 0 -704px;
}
.flag-omr {
    background-position: -240px -640px;
}
.flag-npr {
    background-position: -80px -704px;
}
.flag-mop {
    background-position: -160px -704px;
}
</style>
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
				        <a href="${pageContext.request.contextPath}/currency" class="link-icon">바로가기</a>
				    </div>

				    <div class="currency-body">
						<div class="currency-row1">
							<span>&nbsp;</span>
							<span>통화</span>
						    <span>매도</span>
						    <span>매입</span>
						    <span>기준환율</span>
						</div>
					    <c:forEach var="rate" items="${ratesFavorite}">
					        <div class="currency-row">
					        <!-- 
					            <img src="${pageContext.request.contextPath}/resources/images/flags/${rate.currencyCode}.png" alt="${rate.currencyCode}">
					         -->
					         	<div class="flag flag-${fn:toLowerCase(rate.currencyCode)}"></div>
					            <span>${rate.currencyCode}</span>
					            <span>${rate.cashBuy}</span>
					            <span>${rate.cashSell}</span>
					            <span>${rate.standardRate}</span>
					        </div>
					    </c:forEach>
				    </div>
				</div>
	    	</div>
	    	<div class="board_inner">
	    		<div class="card_top">
				    <div class="title_and_link div_underline">
				        <h2 class="card_title">증시</h2>
				        <a href="#" class="link-icon">바로가기</a>
				    </div>
				    
				    <div class="stock-body">
				        <div class="stock-row1">
				            <span>&nbsp;</span>
				            <span>지수</span>
				            <span>현재가</span>
				            <span>변동수치</span>
				            <span>변동폭</span>
				        </div>
				        <%
				            StockKoreaCrawler koreaCrawler = new StockKoreaCrawler();
				            List<StockDTO> koreaStocks = koreaCrawler.fetchIndexData();
				
				            StockInterCrawler interCrawler = new StockInterCrawler();
				            List<StockDTO> interStocks = interCrawler.fetchIndexData();
				
				            for (StockDTO stock : koreaStocks) {
				                if (stock.getIndexName().contains("코스피") || stock.getIndexName().contains("코스닥")) {
				                    out.println("<div class='stock-row'>");
				                    out.println("<span>" + stock.getIndexName() + "</span>");
				                    out.println("<span>" + stock.getCurrentPrice() + "</span>");
				                    out.println("<span>" + stock.getPriceChange() + "</span>");
				                    out.println("<span>" + stock.getChangePercentage() + "%</span>");
				                    out.println("</div>");
				                }
				            }
				
				            for (StockDTO stock : interStocks) {
				                if (stock.getIndexName().contains("S&P 500") || stock.getIndexName().contains("나스닥")) {
				                    out.println("<div class='stock-row'>");
				                    out.println("<span>" + stock.getIndexName() + "</span>");
				                    out.println("<span>" + stock.getCurrentPrice() + "</span>");
				                    out.println("<span>" + stock.getPriceChange() + "</span>");
				                    out.println("<span>" + stock.getChangePercentage() + "%</span>");
				                    out.println("</div>");
				                }
				            }
				        %>
				    </div>
				    
				    
				    
				    
		    	</div>
	    	</div>
	    	<div class="board_inner">
	    		<div class="card_top">
				    <div class="title_and_link div_underline">
				        <h2 class="card_title">금리</h2>
				        <a href="${pageContext.request.contextPath}/interestRate" class="link-icon">바로가기</a>
				    </div>
					<div class="rates_box">				  
						<!-- Toggle -->
						<div class="rate-toggle-buttons">
						    <button class="toggle-button" onclick="toggleRateTable('mor')">MOR</button>
						    <button class="toggle-button" onclick="toggleRateTable('cofix')">COFIX</button>
						</div>
						
						<!-- Table -->
						<table class="rate-table">
						    <thead>
						        <tr>
						            <th class="rate-header"></th>
						            <th class="rate-header">구분</th>
						            <th class="rate-header">as-is</th>
						            <th class="rate-header">to-be</th>
						            <th class="rate-header">증감</th>
						        </tr>
						    </thead>
						    <tbody id="morRates" class="rate-content">
						        <tr>
						            <th class="rate-header" rowspan="4">MOR</th>
						            <td class="rate-cell">3개월</td>
						            <td class="rate-cell">${mor[0].previousWeekRate}</td>
						            <td class="rate-cell">${mor[0].currentWeekRate}</td>
						            <td class="rate-cell">${mor[0].change}</td>
						        </tr>
						        <tr>
						            <td class="rate-cell">6개월</td>
						            <td class="rate-cell">${mor[1].previousWeekRate}</td>
						            <td class="rate-cell">${mor[1].currentWeekRate}</td>
						            <td class="rate-cell">${mor[1].change}</td>
						        </tr>
						        <tr>
						            <td class="rate-cell">12개월</td>
						            <td class="rate-cell">${mor[2].previousWeekRate}</td>
						            <td class="rate-cell">${mor[2].currentWeekRate}</td>
						            <td class="rate-cell">${mor[2].change}</td>
						        </tr>
						        <tr>
						            <td class="rate-cell">60개월</td>
						            <td class="rate-cell">${mor[5].previousWeekRate}</td>
						            <td class="rate-cell">${mor[5].currentWeekRate}</td>
						            <td class="rate-cell">${mor[5].change}</td>
						        </tr>
						    </tbody>
						    <tbody id="cofixRates" class="rate-content" style="display: none;">
						        <tr>
						            <th class="rate-header" rowspan="2">COFIX</th>
						            <td class="rate-cell">신규</td>
						            <td class="rate-cell">${cofix[0].previousWeekRate}</td>
						            <td class="rate-cell">${cofix[0].currentWeekRate}</td>
						            <td class="rate-cell">${cofix[0].change}</td>
						        </tr>
						        <tr>
						            <td class="rate-cell">신잔액</td>
						            <td class="rate-cell">${cofix[2].previousWeekRate}</td>
						            <td class="rate-cell">${cofix[2].currentWeekRate}</td>
						            <td class="rate-cell">${cofix[2].change}</td>
						        </tr>
						    </tbody>
						</table>
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
					        <a href="${pageContext.request.contextPath}/todo" class="link-icon">바로가기</a>
					    </div>
			    	</div>
			    	<hr>
			    	<div class="todo_list">
			    	
						<ul>
						    <c:forEach var="todo" items="${todoList}">
						        <li class="todo_item ${todo.isdone == 1 ? 'checked' : ''}">
						            <input type="checkbox" onclick="checkTodo(${todo.todoid}, this.checked)" ${todo.isdone == 1 ? 'checked' : ''} data-todoid="${todo.todoid}" data-done="${todo.isdone}">
						            ${todo.todoid} / ${todo.task}
						        </li>
						    </c:forEach>
						</ul>
						<div class="todo_rate">
						    <span id="todo_rate" style="text-align: center;">0 / ${todoList.size()}</span>
						</div>

			        </div>
				</div>
				<div class="board_inner_inner">
		    		<div class="card_top">
					    <div class="title_and_link">
					        <h2 class="card_title">My Memo</h2>
					        <a href="${pageContext.request.contextPath}/memo" class="link-icon">바로가기</a>
					    </div>					    
			    	</div>
			    	<hr>
			    	<div class="memo_list">
			    		<ul>
			    			<c:forEach var="memo" items="${memoList}" begin="0" end="4">
			    				<li>${memo.content} (${memo.createdate})</li>
			    			</c:forEach>
			    		</ul>
			    	</div>
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
						        <a href="${pageContext.request.contextPath}/notice" class="link-icon">바로가기</a>
						    </div>
				    	</div>
			    		<hr>
			    		<div class="tab_table">
				    		<table style="width: 100%;">
							    <colgroup>
							        <col style="width: 30%;">  <!-- 첫 번째 열의 너비를 30%로 설정 -->
							        <col style="width: 70%;">  <!-- 두 번째 열의 너비를 70%로 설정 -->
							    </colgroup>
							    <c:forEach var="notice" items="${noticeList}">
								    <tr>
								    	<td>${notice.createdate}</td>
								    	<td>${notice.title}</td>
								    </tr>
							    </c:forEach>
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

    // 할 일 목록의 체크박스 상태에 따라 클래스 적용
    const todos = document.querySelectorAll('.todo_list input[type="checkbox"]');
    todos.forEach(checkbox => {
        const listItem = checkbox.parentNode;
        if (checkbox.checked) {
            listItem.classList.add('checked');  // 체크된 항목에 클래스 추가
        }
        checkbox.addEventListener('change', function() {
            if (this.checked) {
                listItem.classList.add('checked');
            } else {
                listItem.classList.remove('checked');
            }
            checkTodo(this.getAttribute('data-todoid'), this.checked);
        });
    });

    // 첫 번째 탭 자동 활성화
    const firstTab = document.querySelector('.tab:first-child');
    if (firstTab) {
        firstTab.click(); // 이벤트를 강제로 호출하여 첫 탭을 활성화
    }
});




function toggleRateTable(table) {
    const morRates = document.getElementById('morRates');
    const cofixRates = document.getElementById('cofixRates');

    if (table === 'mor') {
        morRates.style.display = '';
        cofixRates.style.display = 'none';
    } else if (table === 'cofix') {
        cofixRates.style.display = '';
        morRates.style.display = 'none';
    }
}

//TODOLIST 업데이트로직
function checkTodo(todoid, isChecked) {
    console.log("Todo ID:", todoid); // 확인용 로그
    var isCheckedNum = isChecked ? 1 : 0;
    console.log("Is Done:", isCheckedNum); // 확인용 로그
    
    var checkbox = document.querySelector('input[data-todoid="' + todoid + '"]');
    checkbox.dataset.done = isCheckedNum; // 체크박스 상태 업데이트
    updateTodoCount();
    
    // 서버에 업데이트 요청
    fetch('${pageContext.request.contextPath}/todolistCheck',{   
        
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
        	todoid: todoid,
        	isdone: isCheckedNum
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data); // 성공 시 로그
    })
    .catch((error) => {
        console.error('Error:', error); // 오류 시 로그
    });
}

function updateTodoCount() {
    var checkboxes = document.querySelectorAll('.todo_list input[type="checkbox"]');
    var total = checkboxes.length;
    var completed = Array.from(checkboxes).filter(cb => cb.checked).length;

    // 완료된 개수와 전체 개수 업데이트
    document.getElementById('todo_rate').textContent = completed + ' / ' + total;
}
</script>
</body>
</html>