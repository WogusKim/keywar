<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 노트 훔쳐보기 </title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

    <link href="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@latest/dist/editorjs.min.css" rel="stylesheet">
    <!-- Core  include only Paragraph block -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@latest"></script>
    <!-- Header Plug-in-->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/header@latest"></script>
    <!-- Link embeds-->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/link@2.5.0/dist/bundle.min.js"></script>
    <!-- Raw Html -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/raw@2.4.0/dist/bundle.min.js"></script>
    <!-- Simple Image -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/simple-image@1.5.1/dist/bundle.min.js"></script>
    <!-- Image -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/image@2.8.1/dist/bundle.min.js"></script>
    <!-- CheckList -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/checklist@latest"></script>
    <!-- List -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/list@latest"></script>
    <!-- Embed -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/embed@latest"></script>
    <!-- Quote -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/quote@2.5.0/dist/bundle.min.js"></script>
    <!-- Table -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/table@2.2.1/dist/table.min.js"></script>
    <!-- Nested List -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/nested-list@latest"></script>
    <!-- Delimiter -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/delimiter@1.3.0/dist/bundle.min.js"></script>
    <!-- Warning -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/warning@latest"></script>
    <!-- Code -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/code@2.8.0/dist/bundle.min.js"></script>
    <!--  Attach -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/attaches@latest"></script>
    <!-- Marker-->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/marker@latest"></script>
    <!-- Inline Code -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/inline-code@1.4.0/dist/bundle.min.js"></script>
    <!-- UnderLine -->
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/underline@latest"></script>
    <!-- Alert -->
    <script src="https://cdn.jsdelivr.net/npm/editorjs-alert@latest"></script>
    <!-- Mermaid 안씀 -->
    <!--script src="https://cdn.jsdelivr.net/npm/editorjs-mermaid@latest"></script -->
    <!-- Codeflask -->
    <script src="https://cdn.jsdelivr.net/npm/@calumk/editorjs-codeflask@latest"></script>

<% 
   String userno = (String) session.getAttribute("userno");
	String errormessage = (String) session.getAttribute("errormessage");
	if (errormessage != null) {
%>
	<script>
	alert("<%= errormessage %>");
	</script>    	
<%
    // 세션에서 errormessage를 제거하여 다시 표시되지 않도록 함
    session.removeAttribute("errormessage");
	}
%>    	
    	
    
</head>
<style>
.final-outline{
	overflow-y: auto;
	width: 100%;
	height: 100%;
	
}

.others_wikiTitle {
    width: 90%;
    margin: auto;
    border-radius: 75px;
    padding: 20px 10px; /* 위아래 패딩으로 공간 추가 */
    border-bottom: 1px solid #ccc; /* 하단 경계선 추가 */
    background-color: #f9f9f9; /* 배경색 설정 */
    box-shadow: 0 2px 5px rgba(0,0,0,0.1); /* 그림자 효과 */
}

.otherWikiTitle {
	text-align: center; /* 모든 내용을 가운데 정렬 */
}

.writer_profile {
    width: 50px; /* 이미지 크기 설정 */
    height: 50px; /* 이미지 높이 설정 */
    border-radius: 50%; /* 원형으로 표시 */
    object-fit: cover; /* 이미지 비율 유지 */
    margin-bottom: 10px; /* 이미지와 텍스트 간 간격 */
    display: inline-block; /* 이미지를 인라인 블록으로 설정 */
}

.others_wikiTitle img.mini_icon {
    vertical-align: middle; /* 아이콘을 텍스트 중간에 위치 */
    margin-right: 5px; /* 아이콘 간 간격 */
}

.others_wikiTitle span {
    display: inline-block; /* 스팬을 인라인 블록으로 설정 */
    margin: 0 10px; /* 좌우 마진 설정 */
    font-size: 14px; /* 폰트 크기 설정 */
}

.editor_outline {
	width : 75%;
	border: 1px solid #ccc; 
	padding: 10px;
	border-radius: 15px;
	margin: auto;
	margin-top : 20px;
	background-color: white;
/* 	height: 100%; */
}
 
.editor-button-area {
	margin: 20px 0;
	text-align: center;
}
.styled-button {
    background: linear-gradient(90deg, #007BFF, #007BFF);
    border: none;
    border-radius: 30px;
    color: white;
    cursor: pointer;
    font-size: 16px;
    padding: 15px 30px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.styled-button:hover {
    background: linear-gradient(#007BFF, #007BFF, #007BFF);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
    transform: translateY(-2px);
}
/* mypage profile image */
.profile {  
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.box {
    width: 40px;
    height: 40px; 
    border-radius: 70%;
    overflow: hidden;
}
.switchBox{
	width: 100%; 
	height: 80%; 
	margin-top: 10px; 
	padding: 10px;
}

.commentArea1 {
	background-color: #f9f9f9; 
	border-radius: 20px;
	width : 75%; 
	margin: auto; 
	padding: 10px 20px;
	box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
.styled-button {
    background: linear-gradient(to right, #6a82fb, #fc5c7d); /* 그라디언트 색상 업데이트 */
    border: none;
    border-radius: 30px;
    color: white;
    cursor: pointer;
    font-size: 16px;
    padding: 12px 25px; /* 패딩 조정 */
    text-align: center;
    text-decoration: none;
    display: inline-block;
    transition: all 0.3s ease;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    margin: 20px 0px; /* 마진 상단 추가 */
}

.styled-button:hover {
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
    transform: translateY(-3px); /* 변환 값 조정 */
}


/* 업무노트 훔쳐오기를 위한 모달 팝업 관련 css */
/* 모달 스타일 */
.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgb(0,0,0);
    background-color: rgba(0,0,0,0.4);
    padding-top: 60px;
}
.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 50%;
    height: 100%;
}
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}
.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.selectAndInput {
	display: flex;
	height: 100%;
}

.section1 {
	width : 50%;
	height: 70%;
	border-radius: 20px;
	padding: 20px 10px;
	background-color: #d9d9d985;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
	
}

.section2 {
	width: 40%;
	height: 100%;
	margin: auto 10px;
	border-radius: 20px;
	padding: 20px 10px;
	background-color: #d9d9d985;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.selected {
    background-color: #f0f8ff; /* 연한 파란색 배경 */
    border: 2px solid #007BFF; /* 파란색 테두리 */
    border-radius: 5px; /* 모서리를 둥글게 */
    box-shadow: 0 4px 8px rgba(0, 123, 255, 0.2); /* 파란색 그림자 */
    color: #007BFF; /* 파란색 텍스트 */
    font-weight: bold; /* 볼드체 */
    
}
/* 업무노트 훔쳐오기를 위한 모달 팝업 관련 css */


</style>
<body>

	<!-- 헤더 -->
    <%@ include file="/WEB-INF/views/header.jsp" %> 
	
	<!-- 컨텐츠영역 -->
    <div class="content_outline">
    	<!-- 메뉴영역 -->
        <%@ include file="/WEB-INF/views/sidebar.jsp"%>
          
	  <% String currentId = request.getParameter("id"); %>
        <!-- 우측 컨텐츠 영역 -->
        <div class="content_right">
        	<div id="finalOuter" class="final-outline" >
        	<!-- 제목 -->
			<div class="others_wikiTitle">
				<div class="otherWikiTitle">
				    <img class="writer_profile" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=${menuDto.userno}" alt="Writer's Profile Picture">
				    <div>
				        <h2>${writerNickName}님의 메뉴얼</h2>
				        <h1>${menuDto.titleShare}</h1>
				        <div>
				            <img class="mini_icon" src="/resources/images/heart16.png" alt="likes"> 좋아요 ${like}&nbsp;&nbsp;
				            <img class="mini_icon" src="/resources/images/chat16.png" alt="comments"> 댓글 <c:out value="${fn:length(comments)}" />&nbsp;&nbsp;
				            <img class="mini_icon" src="/resources/images/eyes.png" alt="views"> 조회수 ${hits}
				        </div>
				    </div>
				</div>
			        	
	        	<!-- Editor 영역 -->
	            <div id="myEditor" class="editor_outline"></div>
            </div>
            <!-- 버튼 영역 -->
            <div class="editor-button-area">
				<!-- <button onclick="saveData()">저장하기</button> -->  <!-- 저장은 불가능해야함. -->
				<button id="copyNoteBtn" class="styled-button">업무노트 훔치기</button><br>
				
				
				
				<div style="position:relative; display:inline-block;">
				    <a href="${pageContext.request.contextPath}/likeUp?id=<%= currentId %>" style="display:inline-block;">
				        <div style="width:150px; height:150px; position:relative;">
				            <iframe src="https://giphy.com/embed/05IRAGzP2Q6EY4E9eg" width="150" height="150" style="pointer-events:none;" frameBorder="0" allowFullScreen></iframe>
				            <div style="position:absolute;top:0;left:0;width:100%;height:100%;"></div>
				        </div>
				    </a>
				</div>
				
<%-- 			<a href="${pageContext.request.contextPath}/likeUp?id=<%= currentId %>"><img src="${pageContext.request.contextPath}/resources/images/like.png"  id="likeUp" ></a> --%>
				<p style="font-size: 30px; margin: 0px;">${like}</p>
				
            </div>
				  <c:set var="sessionUserno" value="<%= userno %>" />
				  
				
	            <div id="commentArea1" class="commentArea1"> 
	            	<div style="height: 40px; width: 100%;"></div>
	            	<c:forEach var="comment" items="${comments}">
	            	<div style="width: 100%; min-height: 80px; " id="comment-id-${comment.commentid }" >
	            	<div id="first-line" style=" display: flex; justify-content: space-between;">
		            	<div id="commentWriterArea"  style=" display: flex; height: 40px; width: 50%;" >
			            	<div class="box" id="profilepicture">
			            		<img class="profile" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=${comment.userno}" alt="Profile Picture">
			            	</div>	
			            	<div style="line-height: 40px; height: 40px; margin-left: 10px; " id="writer-nickname">${comment.nickname } </div>
		            	</div> 
		            	<div id="commentDelete-Btn" style="text-align: right; margin-right: 20px;">
		            	<c:if test="${sessionUserno eq comment.userno}">
		            	<a href="${pageContext.request.contextPath}/deleteComment?commentid=${comment.commentid}&id=<%= currentId %>" > 삭제 </a>
		            	</c:if>
		            	</div>
	            	</div>
	            	<div style="width: 100%;  text-align: left; margin-top: 10px;"> ${comment.content} </div>
	            	<div style="width: 100%; color: gray; text-align: left; font-size: smaller;">  ${comment.createdate}</div>
	            	<hr> 
	            	</div>
	            	
	           
	            	</c:forEach>
	            	<br>
	           	<!-- 댓글 남기기 영역 -->
	            <div style="width: 80%; display: flex;  justify-content: space-between; margin: auto;">
	            <textarea id="comment-input" rows="4" cols="50" placeholder="댓글을 입력하세요" style="width : 85%; height: 60px; resize: none; "></textarea>
	            <button id="comment-btn" class="styled-button" onclick="test()">등록하기</button> 
	            </div>
	            <div style="background-color: #FAFAFA; width: 100%; height: 40px; " id="footer"></div>
	            </div> <!-- 댓글 영역 끝 -->
	            <div style="width: 100%; height: 70px;"><!-- 댓글 밑 조금의 여백 추가 -->
		            <div style="text-align: center; margin-top: 20px;">
		            <a href="${pageContext.request.contextPath}/hotNote"><button id="goBack-btn" class="styled-button" style="margin: auto;">게시판으로 돌아가기</button></a>
		            </div>
	            </div>
			</div><!-- 여기가 바깥 범위 끝 -->
			
        </div>  <!-- 우측 컨텐츠 영역 끝 -->
    </div>
    
    
    
    <form id="addCommentForm" method="post"  action="${pageContext.request.contextPath}/addCommentForm">
    	<input type="hidden" id="content" name="content"  value="">
    	<input type="hidden" id="targetid" name="targetid"  value="${id}">
    	<input type="hidden" id="userno" name="userno"  value="<%= userno %>">
    </form>
    
    <!-- 모달 팝업 HTML 추가 -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>업무노트 훔치기</h3>
            <form id="copyNoteForm" action="${pageContext.request.contextPath}/copyNote?copyId=${menuDto.id}" method="post">
                <hr>
                <div class="selectAndInput">
	                <div class="menu-tree section1">
	                    <h4>폴더 선택</h4>
						
						<!-- 세션에서 로그인 사용자의 메뉴 리스트보여주기 -->
				        <ul>
				            <c:forEach var="menu" items="${menus}">
				                <li>
				                	<div class="menu_list">
					                    <div class="icon ${menu.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${menu.menuType}" onclick="toggleFolder(this)"></div>
							            <span onclick="selectFolder(this, ${menu.id}, '${menu.menuType}', ${menu.depth})">${menu.title}</span>
				                    </div>
				                    <c:if test="${not empty menu.children}">
				                        <ul>
				                            <c:forEach var="child1" items="${menu.children}">
				                                <li>
				                                	<div class="menu_list">
					                                    <div class="icon ${child1.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child1.menuType}" onclick="toggleFolder(this)"></div>
											            <span onclick="selectFolder(this, ${child1.id}, '${child1.menuType}', ${child1.depth})">${child1.title}</span>
				                                    </div>
				                                    <c:if test="${not empty child1.children}">
				                                        <ul>
				                                            <c:forEach var="child2" items="${child1.children}">
				                                                <li>
				                                                	<div class="menu_list">
					                                                    <div class="icon ${child2.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child2.menuType}" onclick="toggleFolder(this)"></div>
															            <span onclick="selectFolder(this, ${child2.id}, '${child2.menuType}', ${child2.depth})">${child2.title}</span>
				                                                    </div>
				                                                    <c:if test="${not empty child2.children}">
				                                                        <ul>
				                                                            <c:forEach var="child3" items="${child2.children}">
				                                                                <li><div class="menu_list">
					                                                                    <div class="icon ${child3.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child3.menuType}" onclick="toggleFolder(this)"></div>
																			            <span onclick="selectFolder(this, ${child3.id}, '${child3.menuType}', ${child3.depth})">${child3.title}</span>
				                                                                    </div>
				                                                                    <c:if test="${not empty child3.children}">
				                                                                        <ul>
				                                                                            <c:forEach var="child4" items="${child3.children}">
				                                                                                <li>
				                                                                                	<div class="menu_list">
					                                                                                    <div class="icon ${child4.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child4.menuType}" onclick="toggleFolder(this)"></div>
																							            <!-- menuType에 따라 다른 처리 -->
																							            <span onclick="selectFolder(this, ${child4.id}, '${child4.menuType}', ${child4.depth})">${child4.title}</span>
				                                                                                    </div>
				                                                                                </li>
				                                                                            </c:forEach>
				                                                                        </ul>
				                                                                    </c:if>
				                                                                </li>
				                                                            </c:forEach>
				                                                        </ul>
				                                                    </c:if>
				                                                </li>
				                                            </c:forEach>
				                                        </ul>
				                                    </c:if>
				                                </li>
				                            </c:forEach>
				                        </ul>
				                    </c:if>
				                </li>
				            </c:forEach>
				        </ul>
				        <!-- 세션에서 로그인 사용자의 메뉴 리스트보여주기 -->
	                </div>
	                <div class="input_outer section2">
	                    <input type="hidden" id="selectedId" name="id">
	                    <input type="hidden" id="selectedType" name="type" value="item">
	                    <input type="hidden" id="selectedDepth" name="depth">
	
	                    <div class="edit_field">
	                        <label class="label-fixed-width">노트 제목:</label>
	                        <input type="text" id="title" name="title" class="edit_input" required>
	                    </div>
	
	                    <div class="edit_field">
	                        <label class="label-fixed-width">공유용 제목:</label>
	                        <input type="text" name="sharedTitle" class="edit_input">
	                    </div>
	                </div>
                </div>
                <div class="submit_buttonArea">
                    <button type="submit" class="styled-button">확인</button>
                </div>
            </form>
        </div>
    </div>
    
    
<script type="text/javascript"> 

// 모달 열기/닫기 스크립트
var modal = document.getElementById("myModal");
var btn = document.getElementById("copyNoteBtn");
var span = document.getElementsByClassName("close")[0];

btn.onclick = function() {
    modal.style.display = "block";
}

span.onclick = function() {
    modal.style.display = "none";
}

window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

function selectFolder(element, id, menuType, depth) {
	
	console.log('뎁스는 ', depth);
	
	if (depth >= 4) {
		alert('해당 폴더에는 더 메뉴를 만들 수 없습니다.');
	} else {
		
	    if (menuType === 'folder') {
	        document.getElementById('selectedId').value = id;
	        document.getElementById('selectedType').value = menuType;
	        document.getElementById('selectedDepth').value = depth;

	        // 선택된 폴더 스타일 변경
	        var selected = document.querySelectorAll('.selected');
	        selected.forEach(function(el) {
	            el.classList.remove('selected');
	        });
	        element.classList.add('selected');
	    }
	}
}


// URL에서 게시글 번호 가져오기
function getQueryParameter(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}
function collapseSpaces(input) {
    return input.replace(/\s+/g, ' ').trim();
}

function test(){
	const id = getQueryParameter('id');
	const content = $("textarea#comment-input").val();

	
	if(content==""||collapseSpaces(content)==""){
		alert("등록하실 댓글을 입력해주세요.");
		return; 
	}
	const data = {
            "content" : content,
            "targetid" : id,
            "userno" : '<%= userno %>'
        };
	
	
	$.ajax({
		"url" : "${pageContext.request.contextPath}/addConmment",
		method: "POST",
		contentType : "application/json",
		data : JSON.stringify(data),
		//통신 성공시 실행할 것
		success : function(result){
			console.log(result);
			if(result.result == "success"){
				alert("댓글이 정상적으로 등록되었습니다.");
				$("textarea#comment-input").val("");
				window.location.href = window.location.href.split('#')[0] + '#footer'; // URL의 해시 부분을 설정
	            setTimeout(function() {
	                window.location.reload(); // 강제 새로 고침
	            }, 100); // 해시 설정 후 잠시 대기
			}else{
				alert(result.result);
				$("textarea#comment-input").val("");
			}
			
		}, 
		// 통신 실패시 작동할 것 
		error : function(){
            console.error(error); 
            alert("댓글 등록 중 오류가 발생하였습니다.");
      }
		
	})
}




let editor;

document.addEventListener('DOMContentLoaded', function () {
	
	const editorData = JSON.parse('${editorData}');
	console.log('${editorData}'); //추후에 얘를 서버에서 받아서 뿌려주고싶음.
    
    editor = new EditorJS({
        holder: 'myEditor',
        readOnly: true,
        data: editorData,
        tools: {
            // Header 설정
            header: {
                class: Header,
                config: {
                    placeholder: '헤더를 넣으삼',
                    levels: [1, 2, 3, 4, 5, 6],
                    defaultLevel: 3,
                },
                shortcut: 'CMD+SHIFT+H',
            },
            linkTool: {
                class: LinkTool,
                config: {
                    header: '', // get request header 선택사항
                    //백엔드 데이터 가져오깅( Cross Origin에 주의)
                    endpoint: 'http://localhost:9004/editor/link',
                }
            },
            raw: {
                class: RawTool,
                config: {
                    placeholder: "플레이스 홀더랑"
                }
            },
            simImg: {
                class: SimpleImage
                //No Config
            },
            image: {
                class: ImageTool,
                config: {
                    // Your backend file uploader endpoint
                    byFile: 'http://localhost:9004/uploadFile',

                    // Your endpoint that provides uploading by Url
                    byUrl: 'http://localhost:9004/fetchUrl',
                    buttonContent: "파일을 올립니다.",
                    actions: [
                        {
                            name: 'new_button',
                            icon: '<svg>...</svg>',
                            title: 'New Button',
                            toggle: true,
                            action: (name) => {
                                alert(`${name} button clicked`);
                            }
                        }
                    ]
                }
            },
            checklist: {
                class: Checklist,
                inlineToolbar: true
                // No Config
            },
            list: {
                class: List,
                inlineToolbar: true,
                config: {
                    defaultStyle: 'unordered'
                }
            },
            embed: {
                class: Embed,
                inlineToolbar: true,
                config: {
                    services: {
                        youtube: true,
                        coub: true
                    }
                }
            },
            quote: {
                class: Quote,
                inlineToolbar: true,
                shortcut: 'CMD+SHIFT+O',
                config: {
                    quotePlaceholder: 'Quote 입력',
                    captionPlaceholder: 'Quote\'s 작성자들',
                },
            },
            table: {
                class: Table,
                inlineToolbar: true,
                config: {
                    rows: 2,
                    cols: 3,
                    withHeadings: true
                },
            },
/*             nestedlist: {
                class: NestedList,
                inlineToolbar: true,
                config: {
                    defaultStyle: 'unordered'
                },
            }, */
            delimiter: {
                class: Delimiter
                //No Config
            },
            warning: {
                class: Warning,
                inlineToolbar: true,
                shortcut: 'CMD+SHIFT+W',
                config: {
                    titlePlaceholder: '제목',
                    messagePlaceholder: '메시지',
                },
            },
            code: {
                class: CodeTool,
                placeholder: "소스코드를 입력할 수 있습니다."
            },
            attaches: {
                class: AttachesTool,
                config: {
                    /**
                     * Custom uploader
                     */
                    uploader: {
                        /**
                         * Upload file to the server and return an uploaded image data
                         * @param {File} file - file selected from the device or pasted by drag-n-drop
                         * @return {Promise.<{success, file: {url}}>}
                         */
                        uploadByFile(file) {
                            // your own uploading logic here
                            return MyAjax.upload(file).then((response) => {
                                return {
                                    success: 1,
                                    file: {
                                        url: response.fileurl,
                                        // any data you want
                                        // for example: name, size, title
                                    }
                                };
                            });
                        },
                    }
                }
            },
            marker: {
                class: Marker,
                shortcut: 'CMD+SHIFT+M',
                //No Config
            },
            inlineCode: {
                class: InlineCode,
                shortcut: 'CMD+SHIFT+C',
                //No Config
            },
            underline: {
                class: Underline
                //No Config
            },
            alert: {
                class: Alert,
                inlineToolbar: true,
                shortcut: 'CMD+SHIFT+A',
                config: {
                    defaultType: 'primary',
                    messagePlaceholder: 'Enter something',
                }
            },
            code2 : {
                class: editorjsCodeflask,
            }
        }
        
    });
});

/* function copyNote() {
    const noteId = '${menuDto.id}'; // JSP에서 서버 측 변수를 사용
    const redirectUrl = '${pageContext.request.contextPath}/copyNote?id=' + noteId; // 이 URL은 실제 애플리케이션의 로직에 맞게 조정되어야 함
    window.location.href = redirectUrl;
} */
</script>
</body>
</html>
