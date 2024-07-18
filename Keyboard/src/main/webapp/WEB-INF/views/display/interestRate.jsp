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
					<div class="interestRates">
						<div class="half_box">
							<h3>대출금리</h3>
							<hr>
							<table class="mor_table">
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
							<table class="cofix_table">
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
							<table class="kookminSuperTable">
							    <thead>
							        <tr>
							            <th>기간</th>
							            <th>만기지급식(확정금리)</th>
							            <th>월이자지급식(확정금리)</th>
							            <th>월이자복리식(확정금리)</th>
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
							<table class="KbStarTable">
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


</body>
</html>