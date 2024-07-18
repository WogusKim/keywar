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
                    <h2 class="card_title">환율 리스트</h2>
                    <hr>
					<table class="all_currency" summary="환율조회표">
						<colgroup>
						    <col style="width: 10%;">
						    <col style="width: 20%;">
						    <col style="width: 12%;">
						    <col style="width: 12%;">
						    <col style="width: 12%;">
						    <col style="width: 12%;">
						    <col style="width: 12%;">
						    <col style="width: 10%;">
						</colgroup>
					    <thead>
					        <tr>
					            <th scope="col" rowspan="3" colspan="2">통화종류</th>
					            <th scope="col" rowspan="3">매매기준율</th>
					            <th scope="col" colspan="2">송금(전신환)</th>
					            <th scope="col" colspan="2">현찰</th>
					            <th scope="col" rowspan="3">USD<br/>환산율</th>
					        </tr>
					        <tr>
					            <th scope="col" rowspan="2">보내실 때</th>
					            <th scope="col" rowspan="2">받으실 때</th>
					            <th scope="col" rowspan="2">사실 때</th>
					            <th scope="col" rowspan="2">파실 때</th>
					        </tr>				            
					    </thead>
					    <tbody>
					    	<c:forEach var="rate" items="${rates}" begin="1">
						        <tr>
						            <td>${rate.currencyCode}</td>
						            <td>${rate.currencyName}</td>
									<td>
									    <c:choose>
									        <c:when test="${rate.standardRate == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.standardRate}" pattern="#,##0.00"/>
									        </c:otherwise>
									    </c:choose>
									</td>
									<td>
									    <c:choose>
									        <c:when test="${rate.transferSend == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.transferSend}" pattern="#,##0.00"/>
									        </c:otherwise>
									    </c:choose>
									</td>
									<td>
									    <c:choose>
									        <c:when test="${rate.transferReceive == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.transferReceive}" pattern="#,##0.00"/>
									        </c:otherwise>
									    </c:choose>
									</td>
									<td>
									    <c:choose>
									        <c:when test="${rate.cashBuy == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.cashBuy}" pattern="#,##0.00"/>
									        </c:otherwise>
									    </c:choose>
									</td>
									<td>
									    <c:choose>
									        <c:when test="${rate.cashSell == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.cashSell}" pattern="#,##0.00"/>
									        </c:otherwise>
									    </c:choose>
									</td>
									<td>
									    <c:choose>
									        <c:when test="${rate.usdRate == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.usdRate}" pattern="#,##0.0000"/>
									        </c:otherwise>
									    </c:choose>
									</td>
						       </tr>
					    	</c:forEach>
					    </tbody>
					</table>
                </div>
            </div>
        </div>
    </div>


</body>
</html>