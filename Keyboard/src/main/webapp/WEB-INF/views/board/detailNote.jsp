<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
%>
    	
</head>
<style>
.final-outline{
	overflow-y: auto;
	width: 100%;
	height: 100%;
	
}
.editor_outline {
	width : 75%;
	border: 1px solid #ccc; 
	padding: 10px;
	border-radius: 5px;
	margin: auto;
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

</style>
<body>

	<!-- 헤더 -->
    <%@ include file="/WEB-INF/views/header.jsp"%>
	
	<!-- 컨텐츠영역 -->
    <div class="content_outline">
    	<!-- 메뉴영역 -->
        <%@ include file="/WEB-INF/views/sidebar.jsp"%>
        
        <!-- 우측 컨텐츠 영역 -->
        <div class="content_right">
        	<div id="finalOuter" class="final-outline" >
        	<!-- Editor 영역 -->
            <div id="myEditor" class="editor_outline"></div>
            <!-- 버튼 영역 -->
            <div class="editor-button-area">
				<!-- <button onclick="saveData()">저장하기</button> -->  <!-- 저장은 불가능해야함. -->
				<button onclick="loadData()" style="margin-bottom: 10px;">업무노트 뺏어 오기 </button><br>
				
				<img src="${pageContext.request.contextPath}/resources/images/like.png"  id="likeUp" >
				<p style="font-size: 30px; margin: 0px;">좋아요 개수 표출(DB에서 가져올 거임)</p>
				
            </div>
				  <c:set var="sessionUserno" value="<%= userno %>" />
				  
				  
					  <% 
					    String currentId = request.getParameter("id");
						%>
	            <div id="commentArea1" style="background-color: #FAFAFA; width : 75%; margin: auto; padding-left: 20px;"> 
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
	            </div>
			</div><!-- 여기가 바깥 범위 끝 -->
			
        </div>  <!-- 우측 컨텐츠 영역 끝 -->
    </div>
    
    
    
    
    <form id="addCommentForm" method="post"  action="${pageContext.request.contextPath}/addCommentForm">
    	<input type="hidden" id="content" name="content"  value="">
    	<input type="hidden" id="targetid" name="targetid"  value="${id}">
    	<input type="hidden" id="userno" name="userno"  value="<%= userno %>">
    </form>
    
<script type="text/javascript"> 

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
async function saveData() {
	
    try {
        const savedData = await editor.save();
        console.log("저장된 데이터:", savedData);

        // fetch API를 사용한 예제 POST 요청
        fetch('${pageContext.request.contextPath}/saveEditorData', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(savedData)
        })
        .then(response => response.json())
        .then(data => console.log('성공:', data))
        .catch((error) => {
            console.error('오류:', error);
        });
    } catch (error) {
        console.error('저장 실패:', error);
    }
}

document.addEventListener('DOMContentLoaded', function () {
	
	const editorData = JSON.parse('${editorData}');
	console.log('${editorData}'); //추후에 얘를 서버에서 받아서 뿌려주고싶음.
    
    editor = new EditorJS({
        holder: 'myEditor',
        data: editorData,
/*         {
        	blocks: [
                {
                    "type": "header",
                    "data": {
                        "text": "이것은 첨부터 보이는 데이터",
                        "level": 2
                    }
                },
                {
                    "type": "list",
                    "data": {
                        "style": "ordered",
                        "items": [
                            "이거슨 리스트 아이템이예용",
                            "리스트라니까용",
                            "간단하고 파워풀하지용",
                            "비슷한 설정이 반복되는 게 못생겼어요"
                        ]
                    }
                }
        	]
        } */
    
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
</script>
</body>
</html>
