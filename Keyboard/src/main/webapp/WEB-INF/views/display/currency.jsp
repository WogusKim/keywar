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
                    <div style=" overflow-y: auto; height: 60%;">
					<table class="all_currency" summary="환율조회표">
						<colgroup>
							<col style="width: 7%;">
						    <col style="width: 10%;">
						    <col style="width: 13%;">
						    <col style="width: 12%;">
						    <col style="width: 12%;">
						    <col style="width: 12%;">
						    <col style="width: 12%;">
						    <col style="width: 12%;">
						    <col style="width: 10%;">
						</colgroup>
					    <thead>
					        <tr>
					        	<th scope="col" rowspan="3">즐겨찾기</th>
					            <th scope="col" rowspan="3" colspan="2">통화종류</th>
					            <th scope="col" rowspan="3">매매기준율</th>
					            <th scope="col" colspan="2">송금(전신환)</th>
					            <th scope="col" colspan="2">현찰</th>
					            <th scope="col" rowspan="3">USD<br/>환산율</th>
					        </tr>
					        <tr>
					            <th scope="col" rowspan="2">전신환 매도율</th>
					            <th scope="col" rowspan="2">전신환 매수율</th>
					            <th scope="col" rowspan="2">현찰 매도율</th>
					            <th scope="col" rowspan="2">현찰 매수율</th>
					        </tr>				            
					    </thead>
					    <tbody>
					    	<c:forEach var="rate" items="${rates}" begin="1">
						        <tr>
						            <td>
										<input type="checkbox" name="favorite" value="${rate.currencyCode}" ${rate.isFavorite == '1' ? 'checked' : ''}
										       data-code="${rate.currencyCode}" data-favorite="${rate.isFavorite}"
										       onclick="changeFavorite('${rate.currencyCode}', this, event)"/>
						            </td>
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
					<hr>
					<!--  환율 계산기 넣을거야 -->
					<div style="height: 30%; width: 100%; padding: 10px; display: flex;  justify-content: space-between; align-items: center;"> <!-- 여기 환율 계산기 영역임.  -->
						<div style="width: 130px; height: 100%;"><h2 class="card_title">환율계산기</h2></div>
						<div style="background-color: green; width: calc(100% - 130px);height: 100%; text-align: center;">
							<div style="background-color: yellow; height: 50%; width: 100%; display: flex;  justify-content: space-between; align-items: center;"> <!-- 얘가 위에 넣을 거 겉에 박스임.  -->
							
							<div style="background-color: #D9D9D9; height: 60%; width: 100%; border-radius: 10px; border-color: #CAC6C6; border: 1px solid; padding: 10px; display: flex;  justify-content: space-between;">
								<div style="width: 25%; background-color: blue;  height: 100%;">1</div><div style="width: 75%; background-color: pink;  height: 100%;">2</div>
							</div>
							</div>
								<p>=</p>
							<div style="background-color: red; height: 50%; width: 100%;"> 여기는 두 번째 div
							</div>
						
						</div>
						
						
						 
					
					</div>
					
					
                </div>
            </div>
        </div>
    </div>
    
<script>
function changeFavorite(currencyCode, checkboxElement, event) {
    var isChecked = checkboxElement.checked;
    var totalFavorites = document.querySelectorAll('input[name="favorite"]:checked').length;
    
    if (isChecked && totalFavorites > 3) { // 이미 3개가 체크되어 있고, 또 추가하려고 한다면
        alert('즐겨찾기는 최대 3개까지만 가능합니다.');
        event.preventDefault(); // 체크박스 변경 이벤트 중지
        checkboxElement.checked = false; // 체크박스 체크 해제
        return; // 함수 종료
    }
    
    // 서버에 업데이트 요청
    fetch('${pageContext.request.contextPath}/favoriteCurrency', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            currencyCode: currencyCode,
            isFavorite: isChecked ? '1' : '0'
        })
    })
    .then(response => response.json())
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
        alert('네트워크 오류가 발생했습니다.');
        checkboxElement.checked = !isChecked; // 체크박스 원래 상태로 복원
    });
}
</script>

</body>
</html>