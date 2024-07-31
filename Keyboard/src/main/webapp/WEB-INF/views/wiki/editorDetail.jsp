<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/wiki.css">
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
	<style>
	.resize-handle {
	    position: absolute;
	    bottom: 0;
	    right: 0;
	    width: 20px; /* Adjust size as needed */
	    height: 20px; /* Adjust size as needed */
	    margin: 5px;
	    background: url('${pageContext.request.contextPath}/resources/images/icons/resize.png') no-repeat center center;
	    cursor: nwse-resize; /* This cursor is typically used for resizing */
	    background-size: contain; /* Makes sure the image fits well in the div */
	}
	
	</style>
    	
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
			            <c:out value="${item}"/>
			            <c:if test="${!status.last}"> > </c:if>
			        </c:forEach>
			    </div>
		    </h2>
        	
        	<!-- Editor 영역 -->
            <div id="myEditor" class="editor_outline"></div>
            
            <!-- 버튼 영역 -->
            <div class="editor-button-area">
				<button onclick="saveData()">저장하기</button>
				<!-- <button onclick="loadData()">내용 불러오기</button> -->
            </div>

        </div>
    </div>
<script>

let editor;

async function saveData() {
	
	
    try {
        const savedData = await editor.save();
        console.log("저장된 데이터:", savedData);

        //테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
        const imagesData = Array.from(document.querySelectorAll('.image-tool__image img')).map(img => ({
            url: img.src,
            width: img.style.width
        }));
        const payload = {
                editorContent: savedData,
                images: imagesData
            };        
      	//테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
        
        // fetch API를 사용한 예제 POST 요청
        fetch('${pageContext.request.contextPath}/saveEditorData', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(payload)
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
        //테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
        onReady: function() {
            addResizeHandles();
            resizeImages();
        },
        //테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
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
/*             image: {
                class: ImageTool,
                config: {
                    // Your backend file uploader endpoint
                    byFile: '${pageContext.request.contextPath}/uploadFile',

                    // Your endpoint that provides uploading by Url
                    byUrl: '${pageContext.request.contextPath}/fetchUrl',
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
            }, */
            
            /* 테스트 */
			image: {
			    class: ImageTool,
			    config: {
			        uploader: {
			            uploadByFile(file) {
			                let formData = new FormData();
			                formData.append('file', file);
			
			                return fetch('${pageContext.request.contextPath}/uploadFile', {
			                    method: 'POST',
			                    body: formData
			                })
			                .then(response => response.json())
			                .then(data => {
			                    if (data && data.file && data.file.url) {
			                    	addResizeHandles();
			                        return {
			                            success: 1,
			                            file: {
			                                url: data.file.url
			                            }
			                        };
			                    } else {
			                        throw new Error('Failed to upload image');
			                    }
			                });
			            }
			        }
			    }
			},
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

	
	
	//테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
	//테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
	//테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
	//테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
	//테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
	
    // Function to add resize handles
	function addResizeHandles() {
	    const imageContainers = document.querySelectorAll('.image-tool__image');
	
	    imageContainers.forEach(container => {
	        const img = container.querySelector('img'); // Ensure it targets the image directly
	        const handle = document.createElement('div');
	        handle.className = 'resize-handle';
	        handle.style.cssText = 'position: absolute; bottom: 0; right: 0; width: 20px; height: 20px; cursor: nwse-resize;';
	
	        // Append handle directly to the container and position it over the image
	        container.style.position = 'relative'; // Ensures the handle positions correctly
	        container.appendChild(handle);
	
	        handle.addEventListener('mousedown', startResize);
	    });
	}


	function startResize(e) {
	    e.preventDefault();
	    const handle = e.target;
	    const container = handle.parentNode;
	    const img = container.querySelector('img');

	    const startX = e.pageX;
	    const startY = e.pageY;
	    const startWidth = img.offsetWidth;
	    const startHeight = img.offsetHeight;

	    function doResize(e) {
	        const currentX = e.pageX;
	        const currentY = e.pageY;
	        const newWidth = startWidth + (currentX - startX);
	        const newHeight = startHeight + (currentY - startY);

	        img.style.width = newWidth + 'px';
	        img.style.height = 'auto'; // Keeps the aspect ratio
	        // Update handle position if needed
	        handle.style.right = '0px';
	        handle.style.bottom = '0px';
	    }

	    function stopResize() {
	        window.removeEventListener('mousemove', doResize);
	        window.removeEventListener('mouseup', stopResize);
	    }

	    window.addEventListener('mousemove', doResize);
	    window.addEventListener('mouseup', stopResize);
	}

	
	function resizeImages() {
	    const imageSizeData = JSON.parse('${imageSizeList}');
	    console.log("이미지 사이즈 데이터:", imageSizeData); // 이미지 사이즈 데이터 로그

	    imageSizeData.forEach(imageInfo => {
	        console.log("처리중인 이미지 URL:", imageInfo.url, "사이즈대상:", imageInfo.width);
	        const imgElement = document.querySelector(`img[src*="\${imageInfo.url}"]`);
	        
	        if (imgElement) {
		        console.log("찾은마크업:",imgElement);
	            imgElement.style.width = imageInfo.width;
	            imgElement.style.height = 'auto'; 
	        }
	    });
	}

    
	
	//테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
	//테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
	//테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
	//테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중테스트중
	
	
	
	
});


</script>

</body>
</html>
