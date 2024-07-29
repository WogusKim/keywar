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
<!-- 홈페이지 아이콘 -->
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
<style>
.cruuencyCalbox{
	height: 30%; 
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
.transparent-input {
    background-color: transparent; /* 배경을 투명하게 설정 */
    border: none; /* 테두리 없애기 */
    outline: none; /* 클릭 시 나타나는 기본 테두리 없애기 */
    color: #000; /* 텍스트 색상 (필요에 따라 조정 가능) */
    font-size: 16px; /* 텍스트 크기 (필요에 따라 조정 가능) */
    text-align: right;
    font-weight: bold;
    font-size: large;
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
                	
					<!--  환율 계산기 영역 설정 --><!-- 환율계산기 이름 다는 왼쪽 + 계산기 있는 오른쪽 -->
					<div style="height: 30%; width: 100%; padding: 10px; display: flex;  justify-content: space-between; align-items: center; margin-top: 10px;"> 
						<!-- 제목 영역 -->
						<div style="width: 130px; height: 100%;"><h2 class="card_title">환율계산기</h2></div>
						<!-- 여기 환율 계산 영역 -->
						<div style="width: calc(100% - 130px);height: 100%; text-align: center;">
						<!--  오른쪽 부분 시작 -->
						<div style="width: 100%; height : 20%; padding: 5px;   display: flex;  justify-content: space-between; align-items: center;">
							<!-- 환율 기준 선택하는 창 -->
							<div style="width: 60%; height : 100%;">
								<input type="radio" id="baseRate-" name="exchangeRate" value="baseRate-" checked>
								<label for="baseRate-">매매기준율</label>
								<input type="radio" id="transferSend-" name="exchangeRate" value="transferSend-">
								<label for="transferSend-">전신환 매도율</label>
								<input type="radio" id="transferReceive-" name="exchangeRate" value="transferReceive-">
								<label for="transferReceive-">전신환 매수율</label>
								<input type="radio" id="cashBuy-" name="exchangeRate" value="cashBuy-">
								<label for="cashBuy-">현찰 매도율</label>
								<input type="radio" id="cashSell-" name="exchangeRate" value="cashSell-">
								<label for="cashSell-">현찰 매수율</label>
							</div>
							<!-- 환율우대여부 체크 -->
							<div style="width: 40%; height : 100%; ">
								환율 우대 여부<input type="checkbox" name="discount" id="discount" value="discount">
								<input type="number" placeholder="환율 우대율을 입력하세요." id="discountRate" readonly> %
							</div>
							
						</div>
						
							<!-- 얘가 위에 넣을 거 겉 박스  -->
							<div class="cruuencyCalbox">
							<!--  회색 테두리 영역  -->
							<div class="cruuencyCalinnerbox">
								<!--  통화 선택 영역 -->
								<div style="width: 25%;  height: 100%; display: flex;  justify-content: space-between; align-items: center; border-right: 1px solid;	border-color: black; ">
								<!-- 국기 표시되는 칸 -->
								<div id="first-flag" class="flag flag-usd" style="margin: auto;"></div><!-- 나오는 지 확인용, 미국 국기 나옴  -->
								<!-- select 창 div로 구현한 영역 -->								
								<div class="dropdown" onclick="toggleDropdown()" style="margin: auto;"> 
									<span id="select-result-1-1" onclick="toggleDropdown()">USD</span><br>
									<span id="select-result-1-2" onclick="toggleDropdown()">미국(달러)</span>
									<div id="myDropdown" class="dropdown-content" style="margin: auto; overflow-y: auto; height: 200px;">
										<div onclick="selectOption('KRW', '대한민국(원)')"> 대한민국(원)</div>
        								<c:forEach var="rate" items="${rates}" begin="1">
        								<!-- 받아온 데이터로 포문 돌려서 넣기 !!  일단 대충 해놈 -->
        								<div onclick="selectOption('${rate.currencyCode}', '${rate.currencyName}')"> ${rate.currencyName}</div>
        								</c:forEach>
									</div>
								
								</div>
								</div>

								
								<div style="width: 75%;  height: 100%; text-align: right; padding-right: 10px;">
									<input type="text" class="transparent-input" value="1" style="width: 100%" id="exchange-amount-1"><br>
									<span id="follow-amount-1">1</span> <span id="select-result-1-3"> 미국(달러)</span> <!-- 왼쪽에서 선택시 같이 바뀌어 버리게 ~~ -->
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
								<div style="width: 25%;  height: 100%; display: flex;  justify-content: space-between; align-items: center; border-right: 1px solid; border-color: black; ">
								<!-- 국기 변경   -->
								<div id="second-flag" class="flag flag-krw" style="margin: auto;"></div><!-- 나오는 지 확인용, 첨엔 한국 국기 나옴  -->
								
								
								
								<div class="dropdown" onclick="toggleDropdown1()" styl e="margin: auto;" > 
									<span id="select-result-2-1" onclick="toggleDropdown1()">KRW</span><br>
									<span id="select-result-2-2" onclick="toggleDropdown1()">대한민국(원)</span>
									
								
									<div id="myDropdown1" class="dropdown-content" style="margin: auto; overflow-y: auto; height: 200px;">
										<!-- <div onclick="selectOption2('KRW', '대한민국(원)')"> 대한민국(원)</div> -->
        								<c:forEach var="rate" items="${rates}" begin="1">
        								<!-- 받아온 데이터로 포문 돌려서 넣기 !!  일단 대충 해놈 -->
        								<div onclick="selectOption2('${rate.currencyCode}', '${rate.currencyName}')"> ${rate.currencyName}</div>
        								</c:forEach>
									</div>
								
								
								</div>	
								</div>  
								
								<div style="width: 75%;  height: 100%; text-align: right; padding-right: 10px;"><!-- background-color: pink;  -->
									<input type="text" class="transparent-input" value="1" style="width: 100%" id="exchange-amount-2" readonly><br>
									<span id="follow-amount-2">1</span><span id="select-result-2-3">대한민국(원)</span>
								</div>
							</div>
							</div>
							
						
						</div>
						
						
						 
					
					</div> <!-- 환율 계산기 영역 -->
					
					<hr>
                    <h2 class="card_title">환율 리스트</h2>
                    <hr>
                    <!--  환율리스트 스크롤  -->
                    <div style=" overflow-y: auto; height: 55%;">
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
									<td id="baseRate-${rate.currencyCode}">
									    <c:choose>
									        <c:when test="${rate.standardRate == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.standardRate}" pattern="#,##0.00"/>
									        </c:otherwise>
									    </c:choose>
									</td>
									<td id="transferSend-${rate.currencyCode}">
									    <c:choose>
									        <c:when test="${rate.transferSend == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.transferSend}" pattern="#,##0.00"/>
									        </c:otherwise>
									    </c:choose>
									</td>
									<td id="transferReceive-${rate.currencyCode}">
									    <c:choose>
									        <c:when test="${rate.transferReceive == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.transferReceive}" pattern="#,##0.00"/>
									        </c:otherwise>
									    </c:choose>
									</td>
									<td id="cashBuy-${rate.currencyCode}">
									    <c:choose>
									        <c:when test="${rate.cashBuy == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.cashBuy}" pattern="#,##0.00"/>
									        </c:otherwise>
									    </c:choose>
									</td>
									<td id="cashSell-${rate.currencyCode}">
									    <c:choose>
									        <c:when test="${rate.cashSell == 0}">
									            -
									        </c:when>
									        <c:otherwise>
									            <fmt:formatNumber value="${rate.cashSell}" pattern="#,##0.00"/>
									        </c:otherwise>
									    </c:choose>
									</td>
									<td id="usdRate-${rate.currencyCode}">
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
					<!-- 환율리스트 끝  -->

					
                </div>
            </div>
        </div>
    </div>

    <script>
	// 환전 금액 계산하는 메소드 
	function calExchangeAmount(){

		var num1  = $("#exchange-amount-1").val(); //환전 금액 입력되어 있는 거(100 (달러)) 
		var current1  = $("#select-result-1-1").text(); //환전 대상 통화 (ex : 미국 달러 USD)
		var current2  = $("#select-result-2-1").text(); // 환전 원하는 통화  (ex : 대한민국 원 KRW)
		var discountRate = 1;
		var exchangeRate = $('input[name="exchangeRate"]:checked').val();  //체크된 환율 기준
		
		var baseRate = $("#baseRate-"+current1).text();  //첫번째 통화의 매매기준율
		baseRate = keepNumbersAndDots(baseRate);  // 데이터 전처리 (숫자랑 . 빼고 제거)
		var finalRate = baseRate;
		//매매기준율을 선택했을 시 우대 적용 필요 X 또는 환산 할 필요 X 
		if(exchangeRate != 'baseRate-'){
			
			// 원화가 아니라면  현찰일 때, 전신환일 때만 구분해서 ㅇㅇ매수율 적용해서 원화로 환산함. 
			if(current2!='KRW'){
				if(exchangeRate == 'transferSend-' || exchangeRate == 'transferReceive-'){
					exchangeRate = 'transferReceive-';
				}else{
					exchangeRate = 'cashSell-';
				}
			}
			console.log("원화로 환산할 때의 환율 exchangeRate : " + exchangeRate);
			
			//  모든 경우의 환율 변환(원화든 외국돈이든)
			var chooseRateNum1 = $("#"+ exchangeRate + current1).text();  //첫번째 통화의 선택한 환율
			chooseRateNum1 = keepNumbersAndDots(chooseRateNum1);  // 데이터 전처리 
			finalRate = chooseRateNum1;
			
			//환율 우대 여부 체크 환율 우대시 적용할 환율 계산함. 
			if($('#discount').is(':checked') && ($('#discountRate').val()!="")){
				discountRate = $('#discountRate').val()/100;  //환율 우대율 곱할 거 / 없으면 그냥 그대로 나갑니다.
				discountRate = 1 - discountRate;
				var tempnum1 = (Math.round(((chooseRateNum1 - baseRate) * discountRate )*100) / 100);
				finalRate =  Number(tempnum1) + Number(baseRate);
				finalRate =  (Math.round((finalRate)*100) /100);
			}
		}
 
		//선택된 환율 적용(+ 환율우대 적용)해서 환산금액 계산. 		
		var KRWConvertedAmount = num1 * finalRate;
		console.log("KRWConvertedAmount : " + KRWConvertedAmount);
		// 원화로 환산 시 추가계산 필요 없이 데이터 넣어주고 끝
		if(current2 == 'KRW'){
			KRWConvertedAmount = KRWConvertedAmount.toFixed(2);
			KRWConvertedAmount = formatNumberWithCommasAndDecimal(KRWConvertedAmount);
			$("#exchange-amount-2").val(KRWConvertedAmount);
			$("span#follow-amount-2").html(KRWConvertedAmount+" ");
			return;
		}else{
			// 만약 원화로 환산하지 않고 다른 언어로 환산한다면 ?
			if(exchangeRate == 'transferReceive-'){
				exchangeRate = 'transferSend-';
			}else if(exchangeRate == 'cashSell-'){
				exchangeRate = 'cashBuy-';
			}
			
			var chooseRateNum2 = $("#"+ exchangeRate + current2).text();  //두 번째 통화의 선택한 환율
			chooseRateNum2 = keepNumbersAndDots(chooseRateNum2);  // 데이터 전처리 
			finalRate = chooseRateNum2;
			
			
			//환율 우대 여부 체크 환율 우대시 적용할 환율 계산함. 
			if(exchangeRate!=('baseRate-')||$('#discount').is(':checked') && ($('#discountRate').val()!="")){
				discountRate = $('#discountRate').val()/100;  //환율 우대율 곱할 거 / 없으면 그냥 그대로 나갑니다.
				discountRate = 1 - discountRate;
				baseRate = $("#baseRate-"+current2).text();  //두 번째 통화의 매매기준율
				baseRate = keepNumbersAndDots(baseRate); 
				
				var tempnum2 = (Math.round(((chooseRateNum2 - baseRate) * discountRate )*100) / 100);
				finalRate =  Number(tempnum2) + Number(baseRate);
				finalRate =  (Math.round((finalRate)*100) /100);
			}
			
			var finalAmount = KRWConvertedAmount.toFixed(2) / finalRate;
			finalAmount = finalAmount.toFixed(2);
			
			$("#exchange-amount-2").val(finalAmount);
			$("span#follow-amount-2").html(finalAmount+" ");
			return;
			
		}
		
	} 
	//환율우대율 변경시 실행 환율 계산됨.
	$("#discountRate").on('input', function() {
	    calExchangeAmount();
	});
    
    // 환율 선택하거나, 값 변경시 자동 실행. 	
    $(document).ready(function() {
        // 라디오 버튼 변경 시 calExchangeAmount 실행
        $("input[name='exchangeRate']").change(function() {
            calExchangeAmount();
        });

        // span 태그의 값 변경 시 calExchangeAmount 실행
        const targetNode = document.getElementById('select-result-2-3');
        const observerConfig = { childList: true, characterData: true, subtree: true };

        const observerCallback = function(mutationsList, observer) {
            for (let mutation of mutationsList) {
                if (mutation.type === 'characterData' || mutation.type === 'childList') {
                    calExchangeAmount();
                    break;
                }
            }
        };

        const observer = new MutationObserver(observerCallback);
        observer.observe(targetNode, observerConfig);
    });
    
    
    
    	// 첫 로딩시 미국 매매기준율 세팅해놓기.
	    $(document).ready(function() {
	        var sourceValue = $('#baseRate-USD').text();
	        sourceValue = keepNumbersAndDots(sourceValue);
	        $('#follow-amount-2').text(sourceValue);
	        $('#exchange-amount-2').val(sourceValue + " " );
	    });
	    
	    //환율 우대율 0~100까지만 입력가능!
	    document.getElementById('discountRate').addEventListener('input', function() {
            var value = parseInt(this.value);
            if (value < 0) {
                this.value = 0;
            } else if (value > 100) {
                this.value = 100;
            }
        });
	    
	    
	    
	    // 환율 우대 적용여부에 따라 환율 우대율 입력창 활성화/비활성화
	    $(document).ready(function() {
	        $('#discount').change(function() {
	            if (this.checked) {
	                $('#discountRate').prop('readonly', false);
	                calExchangeAmount();
	            } else {
	                $('#discountRate').prop('readonly', true).val('');
	                calExchangeAmount();
	            }
	        });
	    });   
	    
	    
	    
	    document.getElementById('exchange-amount-1').addEventListener('input', function(event) {
	        var inputValue = event.target.value;
	        // 숫자와 '.'만 남기기
	        var filteredValue = keepNumbersAndDot(inputValue);
	        // 천단위 구분기호 붙이기
	        var formattedValue = formatNumberWithCommasAndDecimal(filteredValue);
	        // 포맷된 값 업데이트
	        event.target.value = formattedValue;
	        
	        $("span#follow-amount-1").html(formattedValue);
	        calExchangeAmount();
	        
	    });


    	
    	//숫자랑 0 빼고 제거하는 함수
    	function keepNumbersAndDots(input) {
    	    return input.replace(/[^0-9.]/g, '');
    	}
	    
	    // 소숫점 고려해서 천단위 구분기호 붙이는 메소드
    	function formatNumberWithCommasAndDecimal(number) {
            var parts = number.split(".");
            var integerPart = parts[0];
            var decimalPart = parts.length > 1 ? parts[1] : "";
            var integerWithCommas = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, ",");

            return decimalPart ? integerWithCommas + "." + decimalPart : integerWithCommas;
        }
	    
	    
        function keepNumbersAndDot(input) {
        	// 입력값에서 숫자와 '.'만 남기기
            var filteredInput = input.replace(/[^0-9.]/g, '');
            // 첫 번째 '.' 이후에 나오는 모든 '.' 제거
            var parts = filteredInput.split('.');
            if (parts.length > 2) {
                filteredInput = parts[0] + '.' + parts.slice(1).join('');
            }
            return filteredInput;
        }
        

    	
	    
        function toggleDropdown() {
            document.getElementById("myDropdown").classList.toggle("show");
        }
        function toggleDropdown1() {
            document.getElementById("myDropdown1").classList.toggle("show");
        }
		// 첫 번째 꺼 옵션 선택시 실행되는 메소드
        function selectOption(code, name) {
            $("span#select-result-1-1").html(code);
            $("span#select-result-1-2").html(name);
            $("span#select-result-1-3").html(name);
            $("div#first-flag").removeClass();
            $("div#first-flag").addClass('flag');
            var lowerCode = code.toLowerCase();  
            $("div#first-flag").addClass('flag-'+lowerCode);
            $("#exchange-amount-1").val(1);
            $("span#follow-amount-1").html(1);
            
            calExchangeAmount();
            document.getElementById("myDropdown").classList.remove("show");
        }
        
    	 // 두 번째 꺼 옵션 선택시 실행되는 메소드
        function selectOption2(code, name) {
            $("span#select-result-2-1").html(code);
            $("span#select-result-2-2").html(name);
            $("span#select-result-2-3").html(name);
            $("div#second-flag").removeClass();
            $("div#second-flag").addClass('flag');
            var lowerCode = code.toLowerCase();  
            $("div#second-flag").addClass('flag-'+lowerCode);
            $("#exchange-amount-2").val(1);
            $("span#follow-amount-2").html(1);
            document.getElementById("myDropdown").classList.remove("show");
        }

        // 드롭다운 외부 클릭 시 닫기
        window.onclick = function(event) {
            // 드롭다운을 클릭한 경우 제외
            if (!event.target.matches('.dropdown') ) {
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