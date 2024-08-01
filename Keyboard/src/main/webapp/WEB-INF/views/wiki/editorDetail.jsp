<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<!-- jQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- jQuery UI 라이브러리 -->
<script defer src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/wiki.css">
<link
	href="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@latest/dist/editorjs.min.css"
	rel="stylesheet">



<!-- Core  include only Paragraph block -->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@latest"></script>
<!-- Header Plug-in-->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/header@latest"></script>
<!-- Link embeds-->
<script
	src="https://cdn.jsdelivr.net/npm/@editorjs/link@2.5.0/dist/bundle.min.js"></script>
<!-- Raw Html -->
<script
	src="https://cdn.jsdelivr.net/npm/@editorjs/raw@2.4.0/dist/bundle.min.js"></script>
<!-- Simple Image -->
<script
	src="https://cdn.jsdelivr.net/npm/@editorjs/simple-image@1.5.1/dist/bundle.min.js"></script>
<!-- Image -->
<script
	src="https://cdn.jsdelivr.net/npm/@editorjs/image@2.8.1/dist/bundle.min.js"></script>
<!-- CheckList -->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/checklist@latest"></script>
<!-- List -->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/list@latest"></script>
<!-- Embed -->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/embed@latest"></script>
<!-- Quote -->
<script
	src="https://cdn.jsdelivr.net/npm/@editorjs/quote@2.5.0/dist/bundle.min.js"></script>
<!-- Table -->
<script
	src="https://cdn.jsdelivr.net/npm/@editorjs/table@2.2.1/dist/table.min.js"></script>
<!-- Nested List -->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/nested-list@latest"></script>
<!-- Delimiter -->
<script
	src="https://cdn.jsdelivr.net/npm/@editorjs/delimiter@1.3.0/dist/bundle.min.js"></script>
<!-- Warning -->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/warning@latest"></script>
<!-- Code -->
<script
	src="https://cdn.jsdelivr.net/npm/@editorjs/code@2.8.0/dist/bundle.min.js"></script>
<!--  Attach -->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/attaches@latest"></script>
<!-- Marker-->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/marker@latest"></script>
<!-- Inline Code -->
<script
	src="https://cdn.jsdelivr.net/npm/@editorjs/inline-code@1.4.0/dist/bundle.min.js"></script>
<!-- UnderLine -->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/underline@latest"></script>
<!-- Alert -->
<script src="https://cdn.jsdelivr.net/npm/editorjs-alert@latest"></script>
<!-- Mermaid 안씀 -->
<!--script src="https://cdn.jsdelivr.net/npm/editorjs-mermaid@latest"></script -->
<!-- Codeflask -->
<script
	src="https://cdn.jsdelivr.net/npm/@calumk/editorjs-codeflask@latest"></script>


</head>

<body>

	<!-- 헤더 -->
	<%@ include file="/WEB-INF/views/header.jsp"%>

	<!-- 컨텐츠영역 -->
	<div class="content_outline">
		<!-- 메뉴영역 -->
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>

		<!-- 우측 컨텐츠 영역 -->
		<div class="content_right_wiki">
			<!-- 제목, 메뉴경로 -->
			<h2 class="menu_direction">
				<div>
					<c:forEach var="item" items="${direction}" varStatus="status">
						<c:out value="${item}" />
						<c:if test="${!status.last}"> > </c:if>
					</c:forEach>
				</div>
			</h2>

			<!-- Editor 영역 -->
			<div id="myEditor" class="editor_outline"></div>

			<!-- 버튼 영역 -->
			<div class="editor-button-area">
				<button onclick="saveData()">저장하기</button>
				<button onclick="loadData()">내용 불러오기</button>
			</div>

		</div>
	</div>
	<script>
let editor;

function makeImagesResizable() {
    $('#myEditor img').resizable({
        aspectRatio: true,
        handles: 'se',
        stop: function(event, ui) {
            const imgElement = $(this);
            const blockId = imgElement.closest('[data-id]').data('id');
            if (blockId) {
                const newSize = {
                    width: ui.size.width,
                    height: ui.size.height
                };
                updateBlockData(blockId, newSize);
            }
        }
    });
}

function updateBlockData(blockId, newSize) {
    const blockAPI = editor.blocks.getById(blockId);
	console.log(blockAPI);
    if (!blockAPI) {
        console.error("Block not found");
        return;
    }
    


    blockAPI.save().then(data => {
        // 데이터 수정
        
        console.log("변경전",data);
        
        console.log(data.data.file);
        
        console.log("기존 width",data.data.file.width);
        console.log("기즌 height",data.data.file.height);
        
        console.log("뉴 width", newSize.width);
        console.log("뉴 height", newSize.height);
        
        data.data.file.width = newSize.width;
        data.data.file.height = newSize.height;
        
        console.log("변경후",data);

        // 블록 업데이트
/*         editor.blocks.update(blockId, data).then(() => {
            console.log("Block updated successfully");
        }).catch(error => {
            console.error("Error updating block:", error);
        }); */
    }).catch(error => {
        console.error("Failed to save block data:", error);
    });
}



async function saveData() {
    try {
        const savedData = await editor.save();
        
        // Fetch API를 사용하여 서버로 전송
        fetch('${pageContext.request.contextPath}/saveEditorData', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(savedData)
        })
        .then(response => response.json())
        .then(data => {
            console.log('저장 성공:', data);
        })
        .catch(error => {
            console.error('저장 실패:', error);
        });
    } catch (error) {
        console.error('에디터 데이터 저장 실패:', error);
    }
}

document.addEventListener('DOMContentLoaded', function () {
	
	makeImagesResizable();
	
	const editorData = JSON.parse('${editorData}');
	console.log("서버에서 불러온 데이터", '${editorData}'); //추후에 얘를 서버에서 받아서 뿌려주고싶음.
    
    editor = new EditorJS({
        holder: 'myEditor',
        data: editorData,
        onReady: function () {
            // 모든 이미지 블록에 대해 실행
            const blocks = editorData.blocks;
            console.log("블록확인",blocks);
            blocks.forEach(block => {
            	console.log("블록타입확인",block.type);
                if (block.type === 'image') {
                    // 데이터베이스에서 불러온 크기 정보로 이미지 사이즈를 설정
                    console.log("이미지url", block.data.file.url);
                    const imageElement = document.querySelector(`img[src="\${block.data.file.url}"]`);
                    console.log("이미지url확인",imageElement);
                    if (imageElement) {
                    	
                    	var newWidth = block.data.file.width;
                    	var newHeight = block.data.file.height;
                    	
                    	console.log("FROM DB WIDTH", newWidth);
                    	console.log("FROM DB HEIGHT", newHeight);
                    	
                        console.log("width before?",imageElement.style.width);
                        console.log("height before?",imageElement.style.height);
                        
                        imageElement.style.width = newWidth + "px";
                        imageElement.style.height = newHeight + "px";
                        
                        console.log("width after?",imageElement.style.width);
                        console.log("height after?",imageElement.style.height);
                        
                        const wrapperDiv = imageElement.parentNode;
                        if (wrapperDiv) {
                            wrapperDiv.style.width = newWidth + "px";
                            wrapperDiv.style.height = newHeight + "px";
                        }

                    }
                }
            });
        },
        // 도구 설정...
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
            
            /* 테스트 */
			/* 테스트 */
			image: {
			    class: ImageTool,
			    config: {
			        uploader: {
			            uploadByFile(file) {
			                return new Promise((resolve, reject) => {
			                    const reader = new FileReader();
			                    reader.onload = (event) => {
			                        const img = new Image();
			                        img.onload = () => {
			                            const width = img.width;
			                            const height = img.height;
			
			                            const formData = new FormData();
			                            formData.append('file', file);
			                            formData.append('width', width);
			                            formData.append('height', height);
			                            
			                            console.log('@width : ', width, '@height :', height);
			
			                            fetch('${pageContext.request.contextPath}/uploadFile', {
			                                method: 'POST',
			                                body: formData
			                            })
			                            .then(response => response.json())
			                            .then(data => {
			                                if (data && data.file && data.file.url) {
			                                    resolve({
			                                        success: 1,
			                                        file: {
			                                            url: data.file.url,
			                                            width: width,  // 실제 이미지 너비
			                                            height: height // 실제 이미지 높이
			                                        }
			                                    });
			                                    setTimeout(makeImagesResizable, 100);
			                                } else {
			                                    reject(new Error('Failed to upload image'));
			                                }
			                            })
			                            .catch(error => {
			                                reject(error);
			                            });
			                        };
			                        img.src = event.target.result;
			                    };
			                    reader.readAsDataURL(file);
			                });
			            }
			        }
			    }
			}
			,

            /* 테스트 */
            
            
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

$(document).ready(function() {
    makeImagesResizable(); // 페이지 완전 로드 후 다시 확인
});

</script>

</body>
</html>