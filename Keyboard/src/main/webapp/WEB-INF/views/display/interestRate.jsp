<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 금리 상세 조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/display.css">
<style>
table {
    width: 90%; /* 테이블 너비 조정 */
    margin: 20px auto; /* 중앙 정렬 및 상하 여백 */
    border-collapse: collapse; /* 셀 간 경계선 병합 */
    background-color: #ffffff; /* 배경색 */
}

th, td {
    border: 1px solid #dddddd; /* 테두리 색상 변경 */
    padding: 12px 15px; /* 셀 내부 여백 */
    text-align: center; /* 텍스트 중앙 정렬 */
    font-size: 14px; /* 폰트 크기 */
}

th {
    background-color: #f2f2f2; /* 헤더 배경색 변경 */
    color: #333333; /* 헤더 폰트 색상 */
    font-weight: 600; /* 폰트 굵기 */
}

tr:nth-child(even) {
    background-color: #f9f9f9; /* 짝수 줄 배경색 */
}

tr:hover {
    background-color: #e9e9e9; /* 마우스 오버 시 배경색 변경 */
}

.toggle-button {
    background-color: #007bff; /* 버튼 배경색 */
    color: black; /* 버튼 텍스트 색상 */
    border: none; /* 테두리 제거 */
    padding: 10px 20px; /* 버튼 내부 여백 */
    border-radius: 5px; /* 버튼 둥근 모서리 */
    cursor: pointer; /* 커서 모양 */
    transition: background-color 0.3s; /* 배경색 변경 효과 */
}

.toggle-button:hover {
    background-color: #0056b3; /* 호버 시 버튼 배경색 변경 */
}

.toggle-button:focus {
    outline: none; /* 포커스 테두리 제거 */
}

.tabs {
    display: flex;
    justify-content: left;
    margin-top: 20px;
    margin-bottom: 0px;
    margin-left: 10px;
}


.tab-content {
    display: none;
    animation: fadeIn 0.5s;
}

.tab-button {
    background-color: #878787cf; /* 활성 탭의 배경색 */
    color: white; /* 활성 탭의 텍스트 색상 */

    border: 2px solid #ccc; /* 경계선 */
    padding: 10px 20px; /* 내부 여백 */
    cursor: pointer; /* 커서 스타일 */
    
    transition: background-color 0.3s; /* 배경색 전환 효과 */
    border-radius: 5px 5px 0 0; /* 위쪽 모서리 둥글게 */
    margin-right: 2px; /* 오른쪽 마진 */
}

.tab-button:hover {
    background-color: #e0e0e0; /* 호버 시 배경색 변경 */
}

.tab-button.active {
    background-color: #f2f2f2; /* 기본 배경색 */
    color: black;
    font-weight: bold; /* 폰트 굵기 */
    border-bottom: 4px solid #007bff; /* 활성 탭의 하단 테두리 강조 */
}

.Box {
	background-color: #dddddd47; /* 기본 배경색 */
    border: 3px solid #ccc; /* 경계선 */
    border-radius: 10px;
    height: 80%;
    padding: 20px;
    margin-top: 0px;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}
</style>
</head>

<body>

    <%@ include file="/WEB-INF/views/header.jsp"%>

    <div class="content_outline">
        <%@ include file="/WEB-INF/views/sidebar.jsp"%>        
        <div class="content_right">
            <div class="board_currency">
                <div class="board_currency_inner" style="">
                    <h2 class="card_title">금리 조회</h2>
                    <hr>

					<div class="interestRates" style="margin-top: 10px; ">
						<div class="half_box" >
							<h3>대출금리</h3>
							<hr>
                            <div class="tabs">
								<button class="tab-button tab-button1" data-tab="mor" onclick="switchTab('mor')">MOR 금리</button>
								<button class="tab-button tab-button1" data-tab="cofix" onclick="switchTab('cofix')">COFIX 금리</button>
                            </div>
                            <div class="Box">
	                            <div id="mor" class="tab-content1">
	                                <table class="mor_table" style="text-align: center; width: 100%;">
	                                    <colgroup>
	                                        <col style="width: 40%;">
	                                        <col style="width: 20%;">
	                                        <col style="width: 20%;">
	                                        <col style="width: 20%;">
	                                    </colgroup>
	                                        <thead>
	                                            <tr>
	                                                <th>구분</th><th>종전기간(A)</th><th>적용기간(B)</th><th>증감(B-A)</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                            <c:forEach var="mor" items="${mor}">
	                                                <tr>
	                                                    <td>${mor.rateType}</td>
	                                                    <td>${mor.previousWeekRate}</td>
	                                                    <td>${mor.currentWeekRate}</td>
	                                                    <td>${mor.change}</td>
	                                                </tr>
	                                            </c:forEach>
	                                        </tbody>
	                                </table>
	                            </div>
	                            <div id="cofix" class="tab-content1" style="display: none;">
	                                <table class="cofix_table" style="text-align: center; width: 100%;">
	                                    <colgroup>
	                                        <col style="width: 40%;">
	                                        <col style="width: 20%;">
	                                        <col style="width: 20%;">
	                                        <col style="width: 20%;">
	                                    </colgroup>
	                                    <thead>
	                                        <tr>
	                                            <th>구분</th><th>종전기간(A)</th><th>적용기간(B)</th><th>증감(B-A)</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                        <c:forEach var="cofix" items="${cofix}">
	                                            <tr>
	                                                <td>${cofix.rateType}</td>
	                                                <td>${cofix.previousWeekRate}</td>
	                                                <td>${cofix.currentWeekRate}</td>
	                                                <td>${cofix.change}</td>
	                                            </tr>
	                                        </c:forEach>
	                                    </tbody>
	                                </table>
	                            </div>
                            </div>
						</div>
						
						
						<div class="half_box">
						    <h3>수신금리</h3>
						    <hr>
						    <div class="tabs">
								<button class="tab-button tab-button2" data-tab="kookminSuperTable-div" onclick="switchTab2('kookminSuperTable-div')">국민수퍼 정기예금</button>
								<button class="tab-button tab-button2" data-tab="KbStarTable-div" onclick="switchTab2('KbStarTable-div')">KB STAR 정기예금</button>
						    </div>
						    <div class="Box">
							    <div id="kookminSuperTable-div" class="tab-content2">
							        <table class="kookminSuperTable" style="text-align: center; width: 100%;">
										<colgroup>
											<col style="width: 40%;">
										    <col style="width: 20%;">
										    <col style="width: 20%;">
										    <col style="width: 20%;">
										</colgroup>
									    <thead>
									        <tr>
									            <th>기간</th>
									            <th>만기지급식<br>(확정금리)</th>
									            <th>월이자지급식<br>(확정금리)</th>
									            <th>월이자복리식<br>(확정금리)</th>
									        </tr>
									    </thead>
									    <tbody>
									    	<c:forEach var="rates" items="${superRates}">
										    	<tr>
										            <td>${rates.period}</td>
										            <td>${rates.fixedRate}</td>
										            <td>${rates.monthlyInterestRate}</td>
										            <td>${rates.compoundMonthlyRate}</td>
										        </tr>
									    	</c:forEach>
									    </tbody>
							        </table>
							    </div>
							    <div id="KbStarTable-div" class="tab-content2" style="display: none;">
							        <table class="KbStarTable" style="text-align: center; width: 100%;">
										<colgroup>
											<col style="width: 50%;">
										    <col style="width: 25%;">
										    <col style="width: 25%;">
										</colgroup>
									    <thead>
									        <tr>
									            <th>기간</th>
									            <th>기본이율</th>
									            <th>고객적용이율</th>
									        </tr>
									    </thead>
									    <tbody>
									    	<c:forEach var="rates" items="${kbStarRates}">
										    	<tr>
										            <td>${rates.period}</td>
										            <td>${rates.basicRate}</td>
										            <td>${rates.customerRate}</td>
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
    </div>

<script>

function switchTab(tabName) {
    var tabs = document.querySelectorAll('.tab-content1');
    for (var i = 0; i < tabs.length; i++) {
        tabs[i].style.display = 'none'; // 모든 탭 숨기기
    }
    document.getElementById(tabName).style.display = 'block'; // 선택된 탭 표시

    var buttons = document.querySelectorAll('.tab-button1');
    for (var i = 0; i < buttons.length; i++) {
        if (buttons[i].getAttribute('data-tab') === tabName) {
            buttons[i].classList.add("active");
        } else {
            buttons[i].classList.remove("active");
        }
    }
}

function switchTab2(tabName) {
    var tabs = document.querySelectorAll('.tab-content2');
    for (var i = 0; i < tabs.length; i++) {
        tabs[i].style.display = 'none'; // 모든 탭 숨기기
    }
    document.getElementById(tabName).style.display = 'block'; // 선택된 탭 표시

    var buttons = document.querySelectorAll('.tab-button2');
    for (var i = 0; i < buttons.length; i++) {
        if (buttons[i].getAttribute('data-tab') === tabName) {
            buttons[i].classList.add("active");
        } else {
            buttons[i].classList.remove("active");
        }
    }
}

// Initialize the first tab open
document.addEventListener("DOMContentLoaded", function() {
    switchTab('mor'); // Open the MOR tab by default
    switchTab2('kookminSuperTable-div');
});
</script>
</body>
</html>