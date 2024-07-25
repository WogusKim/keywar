<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.util.*" %>
	<%@ page import="java.text.NumberFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="kb.keyboard.warrior.dto.StockDTO" %>
<%@ page import="kb.keyboard.warrior.StockCrawler" %>
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
            <div class="board_currency">
                <div class="board_currency_inner">
                    <h2 class="card_title">국가별 지수 리스트</h2>
                    <hr>
                    <div style=" overflow-y: auto; height: 90%;">
                    
					<table class="all_currency" summary="환율조회표">
						<colgroup>
							<col style="width: 10%;">
						    <col style="width: 7%;">
						    <col style="width: 23%;">
						    <col style="width: 15%;">
						    <col style="width: 13%;">
						    <col style="width: 12%;">
						    <col style="width: 15%;">
						</colgroup>
					    <thead>
					        <tr>
					            <th scope="col" rowspan="3">즐겨찾기</th>
					            <th scope="col" colspan="2">지수종류</th>
					            <th scope="col" rowspan="2">현재가</th>
					            <th scope="col" rowspan="2">전일대비</th>
					            <th scope="col" rowspan="2">등락률</th>
					            <th scope="col" rowspan="2">52주최고</th>
					            <th scope="col" rowspan="2">52주최저</th>
					        </tr>
					        <tr>
					            <th scope="col">국가</th>
					            <th scope="col">지수</th>
					        </tr>
					    </thead>
					     <tbody>
					        <c:forEach var="stock" items="${allStocks}">
					            <tr>
					                <td>

					                    <input type="checkbox" name="favorite" value="${stock.indexName}"  ${stock.isFavorite == '1' ? 'checked' : ''}
					                           data-name="${stock.indexName}"  data-favorite="${stock.isFavorite}"

					                           onclick="changeFavorite('${stock.indexName}', this, event)"/>
					                </td>
					                <td>${stock.country}</td>
					                <td>${stock.indexName}</td>
					                <td class="${stock.changePercentage >= 0 ? 'positive' : 'negative'}">
					                    <fmt:formatNumber value="${stock.currentPrice}" pattern="#,##0.00"/>
					                </td>
					                <td class="${stock.changePercentage >= 0 ? 'positive' : 'negative'}">
					                    <fmt:formatNumber value="${stock.priceChange}" pattern="${stock.changePercentage >= 0 ? '+' : ''}#,##0.00"/>
					                </td>
					                <td class="${stock.changePercentage >= 0 ? 'positive' : 'negative'}">
					                    <fmt:formatNumber value="${stock.changePercentage}" pattern="${stock.changePercentage >= 0 ? '+' : ''}#,##0.00"/>%
					                </td>
					                <td>
					                    <fmt:formatNumber value="${stock.weekHigh52}" pattern="#,##0.00"/>
					                </td>
					                <td>
					                    <fmt:formatNumber value="${stock.weekLow52}" pattern="#,##0.00"/>
					                </td>
					            </tr>
					        </c:forEach>
					    </tbody>
					</table>
					</div>
                </div>
            </div>
        </div>
    </div>
    
<script>
function changeFavorite(indexName, checkboxElement, event) {
    var isChecked = checkboxElement.checked;
    var totalFavorites = document.querySelectorAll('input[name="favorite"]:checked').length;
    

    if (isChecked && totalFavorites > 4) { // 이미 4개가 체크되어 있고, 또 추가하려고 한다면
        alert('즐겨찾기는 최대 4개까지만 가능합니다.');

        event.preventDefault(); // 체크박스 변경 이벤트 중지
        checkboxElement.checked = false; // 체크박스 체크 해제
        return; // 함수 종료
    }
    
    // 서버에 업데이트 요청
    fetch('${pageContext.request.contextPath}/favoriteStock', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            indexName: indexName,
            isFavorite: isChecked ? '1' : '0'
        })
    })

    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
        console.log('Success:', data); // 성공 시 로그
        if (data.status !== 'success') {
            // 서버 처리 실패 시, 사용자에게 알림
            alert('즐겨찾기 변경에 실패했습니다.');
            checkboxElement.checked = !isChecked; // 체크박스 원래 상태로 복원
        }
    })
    .catch(error => {
        console.error('Error:', error); // 오류 시 로그
        alert('네트워크 오류가 발생했습니다: ' + error.message); // 오류 메시지를 포함하여 알림
        checkboxElement.checked = !isChecked; // 체크박스 원래 상태로 복원
    });
}  
</script>

</body>
</html>