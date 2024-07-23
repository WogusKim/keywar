<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 환율 상세보기 </title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/display.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flag.css"> --%>
<!-- 홈페이지 아이콘 -->
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />

<style>
.cruuencyCalbox{
	height: 35%; 
	width: 100%; 
	display: flex;  
	justify-content: space-between; 
	align-items: center;
}
.cruuencyCalinnerbox{
	background-color: #D9D9D9; 
	height: 100%; 
	width: 100%; 
	border-radius: 10px; 
	border-color: #CAC6C6; 
	border: 1px solid; 
	padding: 5px; 
	display: flex;  
	justify-content: space-between;
}
 .dropdown {
	position: relative;
	display: inline-block;
	width: 80%;
	height: 100%;
}
.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}
.dropdown-content div {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    cursor: pointer
}

.dropdown-content div:hover {
    background-color: #f1f1f1;
}

.show {
    display: block;
}


.flag {
    background: url(${pageContext.request.contextPath}/resources/images/flags/flag_all.png) no-repeat;
    display: inline-block;
    width: 50px; /* 새로운 너비 */
    height: 34px; /* 새로운 높이 */
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
						<!-- 여기 환율 입력 부분! -->
						<div style="width: calc(100% - 130px);height: 100%; text-align: center;">
						
						
							<div class="cruuencyCalbox"> <!-- 얘가 위에 넣을 거 겉에 박스임.  -->
							
							<div class="cruuencyCalinnerbox">
								<div style="width: 25%;  height: 100%; display: flex;  justify-content: space-between; align-items: center; border-right: 1px solid;	border-color: black; ">
								<!-- 국기 변경 입니다  -->
							<%-- 	<div class="flag flag-${fn:toLowerCase(rate.currencyCode)}"></div> --%>
								<div class="flag flag-usd" style="margin: auto;"></div><!-- 나오는 지 확인용, 미국 국기 나옴  -->
								
								
								
								<div class="dropdown" onclick="toggleDropdown()" style="margin: auto;"> 
									<span id="">USD</span><br>
									<span>미국(달러)</span>
									<div id="myDropdown" class="dropdown-content" style="margin: auto; overflow-y: auto; height: 200px;">
        								<c:forEach var="rate" items="${rates}" begin="1">
        								<!-- 받아온 데이터로 포문 돌려서 넣기 !!  일단 대충 해놈 -->
        								<div onclick="selectOption('${rate.currencyCode}')"> ${rate.currencyName}</div>
        								</c:forEach>
									</div>
								
								</div>
								
								</div>

								
								<div style="width: 75%;  height: 100%; text-align: right; padding-right: 10px;"><!-- background-color: pink;  -->
									<span id="">1</span><br>
									<span>1</span><span id="">미국(달러)</span>
								</div>
							</div>
							</div>
							
							<!-- 여기가 = 넣는 부분 -->
							<div style="height: 20%; width: 100%; text-align: center;">
							<span style="font-size: 30px;">=</span>
							</div>
							
							
							
							<!-- 결과 확인 창 -->
							<div class="cruuencyCalbox"> <!-- 얘가 위에 넣을 거 겉에 박스임.  -->
							
							<div class="cruuencyCalinnerbox">
								<div style="width: 25%;  height: 100%; display: flex;  justify-content: space-between; align-items: center; border-right: 1px solid;	border-color: black; ">
								<!-- 국기 변경 입니다  -->
							<%-- 	<div class="flag flag-${fn:toLowerCase(rate.currencyCode)}"></div> --%>
								<div class="flag flag-krw" style="margin: auto;"></div><!-- 나오는 지 확인용, 미국 국기 나옴  -->
								
								
								
								<div class="dropdown" onclick="toggleDropdown()" style="margin: auto;"> 
									<span id="">KRW</span><br>
									<span>대한민국(원)</span>
									<div id="myDropdown" class="dropdown-content" style="margin: auto; overflow-y: auto; height: 200px;">
        								<c:forEach var="rate" items="${rates}" begin="1">
        								<!-- 받아온 데이터로 포문 돌려서 넣기 !!  일단 대충 해놈 -->
        								<div onclick="selectOption('${rate.currencyCode}')"> ${rate.currencyName}</div>
        								</c:forEach>
									</div>
								
								</div>
								
								</div>

								
								<div style="width: 75%;  height: 100%; text-align: right; padding-right: 10px;"><!-- background-color: pink;  -->
									<span id="">1</span><br>
									<span>1</span><span id="">대한민국(원)</span>
								</div>
							</div>
							</div>
							
						
						</div>
						
						
						 
					
					</div>
					
					
                </div>
            </div>
        </div>
    </div>

    <script>
        function toggleDropdown() {
            document.getElementById("myDropdown").classList.toggle("show");
        }

        function selectOption(option) {
            alert("You selected: " + option);
            document.getElementById("myDropdown").classList.remove("show");
        }

        // 드롭다운 외부 클릭 시 닫기
        window.onclick = function(event) {
            // 드롭다운과 드롭다운 버튼을 클릭한 경우 제외
            if (!event.target.matches('.dropdown') && !event.target.matches('.dropdown *')) {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }
    </script>






    
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