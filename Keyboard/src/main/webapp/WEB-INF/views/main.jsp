<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="kb.keyboard.warrior.dto.StockDTO"%>
<%@ page import="kb.keyboard.warrior.StockKoreaCrawler"%>
<%@ page import="kb.keyboard.warrior.StockInterCrawler"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 메인 페이지</title>

<!-- jQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jQuery UI 라이브러리 -->
<script defer src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/flag.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/todo.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var contextPath = '${pageContext.request.contextPath}';

document.addEventListener('DOMContentLoaded', function() {
    var flagElements = document.querySelectorAll('.flag');
    flagElements.forEach(function(elem) {
        elem.style.backgroundImage = 'url(' + contextPath + '/resources/images/flags/flag_all.png)';
    });
});
</script>
</head>
<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<jsp:include page="/WEB-INF/views/sidebar.jsp" />
		<div class="content_right">

			<div class="board_top">
				<div class="board_inner" id="currency">
					<div class="card_top">
						<div class="title_and_link div_underline">
							<h2 class="card_title No-line-break">환율</h2>
							<a href="${pageContext.request.contextPath}/currency"
								class="link-icon">바로가기</a>
						</div>

						<div class="currency-body">
							<div class="currency-row1">
								<span>&nbsp;</span> <span class="No-line-break">국가</span> <span
									class="No-line-break">매도</span> <span class="No-line-break">매입</span>
								<span class="No-line-break">기준환율</span>
							</div>
							<c:forEach var="rate" items="${ratesFavorite}">
								<div class="currency-row">
									<div class="flag flag-${fn:toLowerCase(rate.currencyCode)}"></div>
									<span>${rate.currencyCode}</span> <span><fmt:formatNumber
											value="${rate.cashBuy}" type="number" /></span> <span><fmt:formatNumber
											value="${rate.cashSell}" type="number" /></span> <span><fmt:formatNumber
											value="${rate.standardRate}" type="number" /></span>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="board_inner" id="stock">
					<div class="card_top">
						<div class="title_and_link div_underline">
							<h2 class="card_title No-line-break">증시</h2>
							<a href="${pageContext.request.contextPath}/stock"
								class="link-icon">바로가기</a>
						</div>

						<div class="stock-body">
							<div class="stock-row1">
								<span class="No-line-break">지수</span> <span
									class="No-line-break">현재가</span> <span class="No-line-break">변동수치</span>
								<span class="No-line-break">변동폭</span>
							</div>

							<c:forEach var="stockrate" items="${stockFavorite}">
								<div class='stock-row'>
									<span class="No-line-break">${stockrate.indexName}</span> <span
										class="${stockrate.changePercentage >= 0 ? 'positive' : 'negative'}">
										<fmt:formatNumber value="${stockrate.currentPrice}"
											pattern="#,##0.00" />
									</span> <span
										class="${stockrate.changePercentage >= 0 ? 'positive' : 'negative'}">
										<fmt:formatNumber value="${stockrate.priceChange}"
											pattern="${stockrate.changePercentage >= 0 ? '+' : ''}#,##0.00" />
									</span> <span
										class="${stockrate.changePercentage >= 0 ? 'positive' : 'negative'}">
										<fmt:formatNumber value="${stockrate.changePercentage}"
											pattern="${stockrate.changePercentage >= 0 ? '+' : ''}#,##0.00" />%
									</span>
								</div>
							</c:forEach>

							<%
							/*  StockKoreaCrawler koreaCrawler = new StockKoreaCrawler();
							 List<StockDTO> koreaStocks = koreaCrawler.fetchIndexData();

							 StockInterCrawler interCrawler = new StockInterCrawler();
							 List<StockDTO> interStocks = interCrawler.fetchIndexData();
							 
							 // 숫자 포맷터 생성
							 NumberFormat numberFormat = NumberFormat.getNumberInstance();

							 for (StockDTO stock : koreaStocks) {
							     if (stock.getIndexName().contains("코스피") || stock.getIndexName().contains("코스닥")) {
							         String changeClass = stock.getChangePercentage() >= 0 ? "positive" : "negative";
							         // 결정된 부호를 붙일 변수
							         String priceChangePrefix = stock.getChangePercentage() >= 0 ? "+" : "-";
							         // String formattedPriceChange = priceChangePrefix + numberFormat.format(stock.getPriceChange());
							         
							         out.println("<div class='stock-row'>");
							         out.println("<span>" + stock.getIndexName() + "</span>");
							         out.println("<span class='" + changeClass + "'>" + numberFormat.format(stock.getCurrentPrice()) + "</span>");
							         out.println("<span class='" + changeClass + "'>" + priceChangePrefix + numberFormat.format(stock.getPriceChange()) + "</span>");
							         out.println("<span class='" + changeClass + "'>" + numberFormat.format(stock.getChangePercentage()) + "%</span>");
							         out.println("</div>");
							     }
							 }

							 for (StockDTO stock : interStocks) {
							     if (stock.getIndexName().contains("S&P 500") || stock.getIndexName().contains("나스닥")) {
							         String changeClass = stock.getChangePercentage() >= 0 ? "positive" : "negative";
							         out.println("<div class='stock-row'>");
							         out.println("<span>" + stock.getIndexName() + "</span>");
							         out.println("<span class='" + changeClass + "'>" + numberFormat.format(stock.getCurrentPrice()) + "</span>");
							         out.println("<span class='" + changeClass + "'>" + numberFormat.format(stock.getPriceChange()) + "</span>");
							         out.println("<span class='" + changeClass + "'>" + numberFormat.format(stock.getChangePercentage()) + "%</span>");
							         out.println("</div>");
							     }
							 } */
							%>
						</div>




					</div>
				</div>
				<div class="board_inner" id="interests">
					<div class="card_top">
						<div class="title_and_link d iv_underline">
							<h2 class="card_title">금리</h2>
							<a href="${pageContext.request.contextPath}/interestRate"
								class="link-icon">바로가기</a>
						</div>
						<div class="rates_box">
							<!-- Toggle -->
							<div class="rate-toggle-buttons"
								style="display: flex; overflow: hidden;">
								<button class="toggle-button No-line-break"
									onclick="toggleRateTable('mor')">MOR</button>
								<button class="toggle-button No-line-break"
									onclick="toggleRateTable('cofix')">COFIX</button>
								<button id="kookmin-btn" class="toggle-button No-line-break">국민수퍼정기예금</button>
								<button id="kbstar-btn" class="toggle-button No-line-break">KB
									STAR</button>
							</div>

							<!-- Table -->
							<table id="loanRate" class="rate-table">
								<thead>
									<tr>
										<th class="rate-header"></th>
										<th class="rate-header No-line-break">구분</th>
										<th class="rate-header No-line-break">as-is</th>
										<th class="rate-header No-line-break">to-be</th>
										<th class="rate-header No-line-break">증감</th>
									</tr>
								</thead>
								<tbody id="morRates" class="rate-content">
									<tr>
										<th class="rate-header No-line-break" rowspan="4">MOR</th>
										<td class="rate-cell No-line-break">3개월</td>
										<td class="rate-cell">${mor[0].previousWeekRate}</td>
										<td class="rate-cell">${mor[0].currentWeekRate}</td>
										<td class="rate-cell">${mor[0].change}</td>
									</tr>
									<tr>
										<td class="rate-cell No-line-break">6개월</td>
										<td class="rate-cell">${mor[1].previousWeekRate}</td>
										<td class="rate-cell">${mor[1].currentWeekRate}</td>
										<td class="rate-cell">${mor[1].change}</td>
									</tr>
									<tr>
										<td class="rate-cell No-line-break">12개월</td>
										<td class="rate-cell">${mor[2].previousWeekRate}</td>
										<td class="rate-cell">${mor[2].currentWeekRate}</td>
										<td class="rate-cell">${mor[2].change}</td>
									</tr>
									<tr>
										<td class="rate-cell No-line-break">60개월</td>
										<td class="rate-cell">${mor[5].previousWeekRate}</td>
										<td class="rate-cell">${mor[5].currentWeekRate}</td>
										<td class="rate-cell">${mor[5].change}</td>
									</tr>
								</tbody>
								<tbody id="cofixRates" class="rate-content"
									style="display: none;">
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
							<table class="rate-table" id="kookminRate"
								style="font-size: small; display: none;">
								<tr>
									<td colspan="4" class="rate-header">국민수퍼정기예금</td>
								</tr>
								<tr>
									<th class="rate-header">기간(개월)</th>
									<th class="rate-header">만기지급식</th>
									<th class="rate-header">월이자지급식</th>
									<th class="rate-header">월이자복리식</th>
								</tr>
								<tr>
									<td class="rate-header">1~3개월 미만</td>
									<td class="rate-cell">${superRates[0].fixedRate}</td>
									<td class="rate-cell">${superRates[0].monthlyInterestRate}</td>
									<td class="rate-cell">${superRates[0].compoundMonthlyRate}</td>
								</tr>
								<tr>
									<td class="rate-header">3~6개월 미만</td>
									<td class="rate-cell">${superRates[1].fixedRate}</td>
									<td class="rate-cell">${superRates[1].monthlyInterestRate}</td>
									<td class="rate-cell">${superRates[1].compoundMonthlyRate}</td>
								</tr>
								<tr>
									<td class="rate-header">6~12개월 미만</td>
									<td class="rate-cell">${superRates[2].fixedRate}</td>
									<td class="rate-cell">${superRates[2].monthlyInterestRate}</td>
									<td class="rate-cell">${superRates[2].compoundMonthlyRate}</td>
								</tr>

								<tr>
									<td class="rate-header">12~24개월 미만</td>
									<td class="rate-cell">${superRates[3].fixedRate}</td>
									<td class="rate-cell">${superRates[3].monthlyInterestRate}</td>
									<td class="rate-cell">${superRates[3].compoundMonthlyRate}</td>
								</tr>
								<!-- 일단 2년 이상은 굳이 안보여도 될듯 -->
								<%-- <tr>
						    	<td class="rate-header">24~36</td>
						    	<td class="rate-cell">${superRates[4].fixedRate}</td>
						    	<td class="rate-cell">${superRates[4].monthlyInterestRate}</td>
						    	<td class="rate-cell">${superRates[4].compoundMonthlyRate}</td>
						    </tr>
						    <tr>
						    	<td class="rate-header">36</td>
						    	<td class="rate-cell">${superRates[5].fixedRate}</td>
						    	<td class="rate-cell">${superRates[5].monthlyInterestRate}</td>
						    	<td class="rate-cell">${superRates[5].compoundMonthlyRate}</td>
						    </tr> --%>
							</table>
							<table class="rate-table" id="kbstarRate"
								style="font-size: small; display: none;">
								<tr>
									<td colspan="3" class="rate-header">KB STAR 정기예금</td>
								</tr>
								<tr>
									<th class="rate-header">기간(개월)</th>
									<th class="rate-header">기본이율</th>
									<th class="rate-header">고객적용이율</th>
								</tr>
								<tr>
									<td class="rate-header">1 ~ 3개월 미만</td>
									<td class="rate-cell">${kbStarRates[0].basicRate}</td>
									<td class="rate-cell">${kbStarRates[0].customerRate}</td>
								</tr>
								<tr>
									<td class="rate-header">3 ~ 6개월 미만</td>
									<td class="rate-cell">${kbStarRates[1].basicRate}</td>
									<td class="rate-cell">${kbStarRates[1].customerRate}</td>
								</tr>
								<tr>
									<td class="rate-header">6 ~ 12개월 미만</td>
									<td class="rate-cell">${kbStarRates[2].basicRate}</td>
									<td class="rate-cell">${kbStarRates[2].customerRate}</td>
								</tr>
								<tr>
									<td class="rate-header">12 ~ 24개월 미만</td>
									<td class="rate-cell">${kbStarRates[4].basicRate}</td>
									<td class="rate-cell">${kbStarRates[4].customerRate}</td>
								</tr>
							</table>


						</div>
					</div>
				</div>
			</div>

			<style>
/* 기본 체크박스 감춤 */
input[type="checkbox"][id^="check"] {
	display: none;
}
/* off */
input[type="checkbox"][id^="check"]+label {
	background-repeat: no-repeat; /* 반복 방지 */
	background-image:
		url('${pageContext.request.contextPath}/resources/images/checkbox.png');
	/* off 이미지 */
}
/* on */
input[type="checkbox"][id^="check"]:checked+label {
	background-repeat: no-repeat; /* 반복 방지 */
	background-image:
		url('${pageContext.request.contextPath}/resources/images/checked.png');
	/* on 이미지 */
}

label {
	display: block;
	width: 30px;
	height: 30px;
}
</style>


			<div class="board_bottom">
				<div class="board_inner2" style="width: 64%;">
					<div class="board_inner_inner">
						<div class="card_top">
							<div class="title_and_link">
								<h2 class="card_title No-line-break">Today's tasks</h2>
								<a href="${pageContext.request.contextPath}/todo"
									class="link-icon">바로가기</a>
							</div>
						</div>
						<hr>
						<div class="todo_list" style="height: 85%;">
							<c:choose>
								<c:when test="${empty todoList}">
									<div class="mainTodoNotFountOutline" style="overflow-y : auto;">
										<div
											style="width: 50%; height: 0; padding-bottom: 50%; position: relative;">
											<iframe src="https://giphy.com/embed/SkJRWt1Mo9CSlgrHcE"
												width="100%" height="100%"
												style="position: absolute; pointer-events: none;"
												frameBorder="0" class="giphy-embed" allowFullScreen>
											</iframe>
											<div
												style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
										</div>
										<%-- <img src="${pageContext.request.contextPath}/resources/images/not-found.png" /> --%>
										<div style="color: #727272;">
											오늘이 마감일인 <br> 미완료 상태의 할 일이 없습니다.<br> 자세한 오늘의 할 일을
											보고 싶으시면 <br> 위의 상세보기를 눌러주세요.
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="mainTodoInnerBox">
										<c:forEach var="dto" items="${todoList}">
											<div
												class="mainTodoContentOutline ${dto.checkstatus == 0 ? 'past-to-do' : ''}">
												<div class="arrangeBox" style="width: 100%;">
													<div
														style="display: flex; text-align: center; text-align: center; width: 100%;">
														<input type="checkbox"
															onclick="checkTodo(${dto.todoid}, this.checked)"
															${dto.isdone == 1 ? 'checked' : ''}
															data-todoid="${dto.todoid}" data-done="${dto.isdone}"
															id="check-${dto.todoid}"> <label
															for="check-${dto.todoid}"></label>
														<div
															style="text-align: left; height: 30px; vertical-align: middle; width: 90%;"
															class="No-line-break">${dto.task}</div>
													</div>
												</div>
												<div
													style="color: gray; font-size: small; margin-left: 5px;"
													class="No-line-break">마감 기일 : ${dto.duedate}</div>
											</div>
										</c:forEach>
									</div>

								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<!-- 메모 영역 -->
					<div class="board_inner_inner">
						<div class="card_top">
							<div class="title_and_link">
								<h2 class="card_title No-line-break">My Memo</h2>
								<a href="${pageContext.request.contextPath}/memo"
									class="link-icon">바로가기</a>
							</div>
						</div>
						<hr>
						<!--  탭 버튼 영역 -->
						<div
							style="background-color: #ffffff73; widows: 100%; display: flex; justify-content: space-between; border-radius: 10px; margin-bottom: 10px;">
							<div id="myMemoButton"
								style="width: 50%; padding: 10px; text-align: center; cursor: pointer;"
								class="No-line-break">
								<b>나의 메모</b>
							</div>
							<div id="branchMemoButton"
								style="width: 50%; padding: 10px; text-align: center; cursor: pointer;"
								class="No-line-break">
								<b>부점 메모</b>
							</div>
						</div>
						<div class="memo_list"
							style="padding: 0px; margin: 0px; height: 65%; padding: 0px; padding-right: 5px;">
							<!-- 탭 전환시 보여질 영역(1, 나의 메모) -->
							<div id="myMemoArea" style="padding-bottom: 10px;">
								<c:forEach var="memo" items="${memo1}" begin="0" end="4">
									<div class="mainTodoContentOutline">
										<div class="arrangeBox" style="width: 100%;">
											<div
												style="text-align: left; vertical-align: middle; width: 100%; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; white-space: normal; line-height: 1.5;">
												${memo.content}</div>
										</div>
										<div style="color: gray; font-size: small;"
											class="No-line-break">메모 등록일자 : ${memo.createdate}</div>
									</div>
								</c:forEach>
								<c:if test="${empty memo1 }">
									<div style="text-align: center;">
										<iframe src="https://giphy.com/embed/xEpP5fhLTLNMnXLkeQ"
											width="130px;" height="130px;"
											style="pointer-events: none; margin: 0;" frameBorder="0"
											class="giphy-embed" allowFullScreen></iframe>
									</div>
									<div style="text-align: center;">
										<p id="alertTitle" style="color: #727272; margin: 0px;">
											등록된 나의 메모가 없습니다.<br> 업무에 필요한 메모를 등록하고 <br> 한 눈에
											확인해보세요 !
										</p>
									</div>
								</c:if>

							</div>
							<!-- 탭 전환시 보여질 영역2, 부점 메모) -->
							<div id="branchMemoArea"
								style="display: none; padding-bottom: 10px;">
								<c:forEach var="memo" items="${memo2}" begin="0" end="4">
									<div class="mainTodoContentOutline">
										<div class="arrangeBox" style="width: 100%;">
											<div
												style="text-align: left; vertical-align: middle; width: 100%; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; white-space: normal; line-height: 1.5;">
												${memo.content}</div>
										</div>
										<div style="color: gray; font-size: small;"
											class="No-line-break">메모 등록일자 : ${memo.createdate}</div>
									</div>
								</c:forEach>
								<c:if test="${empty memo2 }">
									<div style="text-align: center;">
										<iframe src="https://giphy.com/embed/C88XS01rDVHsoDxIrZ"
											width="130px;" height="130px;"
											style="pointer-events: none; margin: 0;" frameBorder="0"
											class="giphy-embed" allowFullScreen></iframe>
									</div>
									<div style="text-align: center;">
										<p id="alertTitle" style="color: #727272; margin: 0px;">
											등록된 부점 메모가 없습니다.<br> 업무에 필요한 메모를 등록하고 <br> 한 눈에
											확인해보세요 !
										</p>
									</div>
								</c:if>
							</div>

						</div>
					</div>

					<!-- 공지 영역 시작 -->
					<div class="board_inner_inner">
						<div class="card_top">
							<div class="title_and_link">
								<h2 class="card_title No-line-break">Notice</h2>
								<a href="${pageContext.request.contextPath}/notice"
									class="link-icon">바로가기</a>
							</div>
						</div>
						<hr>
						<div class="todo_list">
							<c:choose>
								<c:when test="${empty noticeList}">
									<div class="mainTodoNotFountOutline">
										<div
											style="width: 50%; height: 0; padding-bottom: 50%; position: relative;">
											<iframe src="https://giphy.com/embed/lmefcS3U29GrsmXu5D"
												width="100%" height="100%"
												style="position: absolute; pointer-events: none;"
												frameBorder="0" class="giphy-embed" allowFullScreen>
											</iframe>
											<div
												style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
										</div>
										<%-- <img src="${pageContext.request.contextPath}/resources/images/not-found.png" /> --%>
										<div style="color: #727272;">
											등록된 부점 공지가 없습니다. <br> 필요한 공지를 등록하여<br> 부점 사람들과 소식을
											<br> 간편하게 공유해보세요.

										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="mainTodoInnerBox" style="padding: 0px;">
										<div style="padding: 5px; overflow-y: auto; height: 100%;">
											<c:forEach var="notice" items="${noticeList}">
												<div class="mainTodoContentOutline">
													<div class="arrangeBox" style="width: 100%;">
														<div
															style="text-align: left; vertical-align: middle; width: 100%; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; white-space: normal; line-height: 1.5;">
															${notice.title}</div>
													</div>
													<div style="color: gray; font-size: small;"
														class="No-line-break">공지 등록일자 : ${notice.createdate}</div>
												</div>
											</c:forEach>
										</div>
									</div>


								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<!--  탭3 끝 -->

				</div>
<style>
.box {
    width: 60px;
    height: 60px; 
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
</style>
				
				<div class="board_inner3">
					<!-- 탭(선택영역) -->
					<div class="tab_area">
						<span class="tab No-line-break" data-tab="tab1">랭킹</span> <span class="tab No-line-break"
							data-tab="tab2">댓글/좋아요</span> 
					</div>
					<!-- 선택된 영역에 따라 노출되는 컨텐츠 영역 -->
					<!-- tab 1 -->
					<div id="tab1" class="tab_content active">
						<div class="tab_rank">
							<div class="rankbox">
								<h4 class="card_title">BEST 저자</h4>
								<hr>
									<!-- 1등 영역 -->
									<div style="text-align: center;">
									<div class="box" id="profilepicture">
			            				<img class="profile" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=${bestWriter[0].userno}" alt="Profile Picture">
			            			</div>1등 -  ${bestWriter[0].nickname} <br>
			            			좋아요 ${bestWriter[0].like_count}개
									</div>
									<!-- 2, 3등 영역 -->
									<div class="arrangeBox">
									<div style="text-align: center;">
									<div class="box" id="profilepicture">
			            				<img class="profile" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=${bestWriter[1].userno}" alt="Profile Picture">
			            			</div>
			            			2등 - ${bestWriter[1].nickname} <br>
			            			좋아요 ${bestWriter[1].like_count}개
			            			</div>
			            			<div style="text-align: center;">
									<div class="box" id="profilepicture">
			            				<img class="profile" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=${bestWriter[2].userno}" alt="Profile Picture">
			            			</div>
			            			3등 - ${bestWriter[2].nickname} <br>
			            			좋아요 ${bestWriter[2].like_count}개
			            			</div>
									</div>
							</div>
							<div class="rankbox">
								<div style="display: flex; justify-content: space-between;">
									<h4 class="card_title">BEST 게시글</h4>
									<a href="${pageContext.request.contextPath}/hotNote"
										class="link-icon">바로가기</a>
								</div>
								<hr>
								<div style=" height: 80%; overflow-y: auto;">
								<ul>
									<c:forEach var="bestPost" items="${bestPost}">
										<li><a class="aTag"
											href="${pageContext.request.contextPath}/detailNote?id=${bestPost.id}">${bestPost.titleShare }
												- ${bestPost.nickname }</a></li>

									</c:forEach>
								</ul>
								</div>
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
							<c:choose>
								<c:when test="${empty comment}">
									<div style="width: 100%; height: 80%; text-align: center;">
										<div style="text-align: center;">
											<iframe src="https://giphy.com/embed/3glE7zIDgW2JrPIr7l"
												width="130px;" height="130px;"
												style="pointer-events: none; margin: 0;" frameBorder="0"
												class="giphy-embed" allowFullScreen></iframe>
										</div>
										<div style="color: #727272;">
											등록된 댓글과 좋아요가 없습니다. <br>
											나만의 업무노트를 작성해 더 많은 꿀팁을 공유해보세요 !
										</div>
									</div>
								</c:when>
								<c:otherwise>
								
							<div class="tab_table">
								<c:forEach var="comment" items="${comment}">
								<div class="mainTodoContentOutline" onclick="goToDeatil('${comment.detail}')">
									<div class="arrangeBox" style="width: 100%;">
										<div
											style="text-align: left; vertical-align: middle; width: 100%; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; white-space: normal; line-height: 1.5;">
											${comment.message}</div>
									</div>
									<div style="color: gray; font-size: small;"
										class="No-line-break">등록일자 : ${comment.senddate}</div>
								</div>
								</c:forEach>
							</div>
							</c:otherwise>
							</c:choose>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<script>
    $(document).ready(function() {
        $('#kookmin-btn').click(function() {
            $('#loanRate').hide();
            $('#kbstarRate').hide();
            $('#kookminRate').show();
        });
        $('#kbstar-btn').click(function() {
            $('#loanRate').hide();
            $('#kookminRate').hide();
            $('#kbstarRate').show();
        });
    });
</script>
	<script>
document.addEventListener('DOMContentLoaded', function() {

    var displayOrder = JSON.parse('${displayOrderJson}'); // JSON 문자열을 JavaScript 객체로 파싱
    var boardTop = document.querySelector('.board_top');

    displayOrder.forEach(function(sectionId) {
        var sectionElement = document.getElementById(sectionId);
        if (sectionElement) {
            boardTop.appendChild(sectionElement);
        } else {
            console.error('Element not found:', sectionId);
        }
    });
	

    
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
    
    // 완료 현황 업데이트
  //  updateTodoCount();
});




function toggleRateTable(table) {
    const morRates = document.getElementById('morRates');
    const cofixRates = document.getElementById('cofixRates');

    if (table === 'mor') {
        $('#kookminRate').hide();
        $('#loanRate').show();
        $('#kbstarRate').hide();
        morRates.style.display = '';
        cofixRates.style.display = 'none';
    } else if (table === 'cofix') {
        $('#kookminRate').hide();
        $('#loanRate').show();
        $('#kbstarRate').hide();
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
   // updateTodoCount();
    
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

function goToDeatil(detail){
	console.log(detail);
	window.location.href =  "${pageContext.request.contextPath}/detailNote?id="+detail;
}
/* function updateTodoCount() {
    var checkboxes = document.querySelectorAll('.todo_list input[type="checkbox"]');
    var total = checkboxes.length;
    var completed = Array.from(checkboxes).filter(cb => cb.checked).length;

    // 완료된 개수와 전체 개수 업데이트
    document.getElementById('todo_rate').textContent = completed + ' / ' + total;
} */
</script>

	<!-- 드래그앤드랍을 위한 테스트중 -->
	<script>

function updateSectionOrder(newOrder) {
    console.log("Updating order to:", newOrder); // 로그 출력으로 확인
    $.ajax({
        url: contextPath + '/updateDisplayOrder',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({order: newOrder}),
        success: function(response) {
            console.log("Order update response:", response);
        },
        error: function(xhr, status, error) {
            console.error("Error updating order:", error);
        }
    });
}


$(document).ready(function() {
    $(".board_top").sortable({
        placeholder: "ui-state-highlight",
        update: function(event, ui) {
            var newOrder = $(this).sortable('toArray').toString();
            updateSectionOrder(newOrder);
        }
    });
    $(".board_inner").disableSelection();
});

document.getElementById("myMemoButton").onclick = function() {
    document.getElementById("myMemoArea").style.display = "block";
    document.getElementById("branchMemoArea").style.display = "none";
};

document.getElementById("branchMemoButton").onclick = function() {
    document.getElementById("myMemoArea").style.display = "none";
    document.getElementById("branchMemoArea").style.display = "block";
};
</script>
</body>
</html>