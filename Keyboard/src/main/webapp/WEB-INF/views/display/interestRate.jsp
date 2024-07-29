<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/display.css">
<style>
.mor_table, .cofix_table{
    width: 100%;
    text-align: center;
    border-collapse: collapse; /* 테이블의 테두리 겹침 */
    margin-bottom: 10px;
}

.mor_table, .mor_table th, .mor_table td, .cofix_table, .cofix_table th, .cofix_table td{
    border: 1px solid black; /* 테두리 설정 */
}

.mor_table th, .mor_table td, .cofix_table th, .cofix_table td {
    padding: 8px;
}


.kookminSuperTable {
    width: 100%;
    text-align: center;
    border-collapse: collapse; /* 테이블의 테두리 겹침 */
}

.kookminSuperTable, .kookminSuperTable th, .kookminSuperTable td {
    border: 1px solid black; /* 테두리 설정 */
}

.kookminSuperTable th, .kookminSuperTable td {
    padding: 8px;
}

.KbStarTable {
    width: 100%;
    text-align: center;
    border-collapse: collapse; /* 테이블의 테두리 겹침 */
}

.KbStarTable, .KbStarTable th, .KbStarTable td {
    border: 1px solid black; /* 테두리 설정 */
}

.KbStarTable th, .KbStarTable td {
    padding: 8px;
}


    </style>
</head>

<body>

    <%@ include file="/WEB-INF/views/header.jsp"%>

    <div class="content_outline">
        <%@ include file="/WEB-INF/views/sidebar.jsp"%>        
        <div class="content_right">
            <div class="board_currency">
                <div class="board_currency_inner">
                    <h2 class="card_title">금리 조회</h2>
                    <hr>
					<div class="interestRates" style="margin-top: 10px;">
						<div class="half_box" >
							<h3>대출금리</h3>
							<hr>
							<div style="margin-top: 10px;"><h3> MOR</h3></div>
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
							<h3> COFIX</h3>
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
						<div class="half_box">
							<h3>수신금리</h3>
							
							<hr>
							<div style="margin-bottom: 10px;">
								<button id="kookmin-btn" class="toggle-button">국민수퍼 정기예금</button>
								<button id="kbstar-btn" class="toggle-button">KB STAR 정기예금</button>
							</div>
							<div id="kookminSuperTable-div">
							<h3> &nbsp; 국민수퍼 정기예금</h3>
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
							<div id="KbStarTable-div" style="display: none;">
							<h3>&nbsp;  KB Star 정기예금</h3>
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

   <script>
        $(document).ready(function(){
            $("#kookmin-btn").click(function(){
                $("#kookminSuperTable-div").show();
                $("#KbStarTable-div").hide();
            });
            $("#kbstar-btn").click(function(){
                $("#kookminSuperTable-div").hide();
                $("#KbStarTable-div").show();
            });
        });
    </script>
</body>
</html>