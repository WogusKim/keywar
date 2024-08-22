<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 게시글 작성하기</title>
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
<script src="https://cdn.jsdelivr.net/npm/@editorjs/paragraph@latest"></script>
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

<style>
.image-tool__image {
    position: relative; /* 상대적 위치 설정 */
}

.button-container {
    background-color: #a3a3a33d;
    border-radius: 10px;
    position: absolute;
    top: 10px;
    right: 10px;
    z-index: 100;
    width: 110px;
    height: 30px;
    padding: 5px;
    display: flex; /* 플렉스 컨테이너 설정 */
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: space-around; /* 버튼 사이의 간격 균등 배분 */
}

.custom-button {
    width: 20px; /* 버튼 크기 */
    height: 20px; /* 버튼 높이 */
    background-size: cover; /* 배경 이미지 크기 조정 */
}


.image-tool__caption {
    width: 100%; /* 캡션 폭을 이미지 영역과 동일하게 설정 */
    padding: 8px; /* 패딩으로 내부 여백 추가 */
    box-sizing: border-box; /* 패딩을 너비에 포함 */
}

.wiki_fileIcon {
	width: 30px;
	height: 30px;
	margin-right: 12px;
}


.ce-block {
    position: relative;
    /* Other styles */
}

.drag-handle {
    display: none; /* 기본적으로 숨김 */
    position: absolute;
    top: 50%;
    right: 20%;
    transform: translateY(-50%);
    cursor: move;
    width: 25px;
    height: 25px;
    background: url('${pageContext.request.contextPath}/resources/images/icons/dragIcon2.png') no-repeat center center;
    background-size: cover;
}

.ce-block:hover .drag-handle {
    display: block; /* 호버 시에만 표시 */
}

.color-handle {
    display: none; /* 기본적으로 숨김 */
    position: absolute;
    top: 50%;
    right: 17%;
    transform: translateY(-50%);
    cursor: move;
    width: 25px;
    height: 25px;
    background: url('${pageContext.request.contextPath}/resources/images/icons/color.png') no-repeat center center;
    background-size: cover;
}

.ce-block:hover .color-handle {
    display: block; /* 호버 시에만 표시 */
}

.ce-header {
    padding: 6px 0 6px;
    margin: 0;
    line-height: 1.25em;
    outline: none;
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
				<!-- <button onclick="loadData()">내용 불러오기</button> -->
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
        	
        	console.log('여기좀보세요',ui);
        	
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
        console.log("★기존 align", data.data.file.align);
        
        console.log("뉴 width", newSize.width);
        console.log("뉴 height", newSize.height);
        
        data.data.file.width = newSize.width;
        data.data.file.height = newSize.height;
        
        console.log("변경후",data);

    }).catch(error => {
        console.error("Failed to save block data:", error);
    });
}



async function saveData() {
    try {
        const savedData = await editor.save();
        
        // 모든 'paragraph' 타입 블록에 color 속성을 추가
/*         savedData.blocks.forEach(block => {
            if (block.type === 'paragraph' && !block.data.color) {
                block.data.color = 'red';
            }
        }); */

        // 콘솔에 JSON 형태로 변환된 데이터 출력
        console.log("이게 맞아?", JSON.stringify(savedData));

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
            alert("성공적으로 저장하였습니다.");
        })
        .catch(error => {
            console.error('저장 실패:', error);
            alert("저장 중 에러가 발생하였습니다.");
        });
    } catch (error) {
        console.error('에디터 데이터 저장 실패:', error);
    }
}


document.addEventListener('DOMContentLoaded', function () {
	
/*     // 이미지 드래그 시 복사 방지
    document.addEventListener('dragstart', function(event) {
    if (event.target.tagName === 'IMG') {
        // 이미지의 URL을 사용하여 드래그 데이터를 설정합니다.
        event.dataTransfer.setData('text/plain', event.target.src);
        // 기본 이미지 드래그 동작을 방지합니다.
        event.preventDefault();
    }
});  */   
	
	const editorData = JSON.parse('${editorData}');
	console.log("서버에서 불러온 데이터", '${editorData}'); //추후에 얘를 서버에서 받아서 뿌려주고싶음.
	
	// Editor.js 초기화
    editor = new EditorJS({
        holder: 'myEditor',
        data: editorData,
        onChange: () => {
            console.log("Changes detected");
            // Debounce this function if necessary to avoid performance issues
            setTimeout(() => {
/*                 const blocks = editor.save().then(outputData => {
                    outputData.blocks.forEach(block => {
                        if (block.type === 'paragraph' && !block.data.color) {
                            block.data.color = "red"; // 각 단락에 색상 데이터 추가
                        }
                    });
                    console.log("바뀐내용" , JSON.stringify(outputData)); // 색상 데이터가 추가된 블록 구조를 콘솔에 출력
                }); */
                
                
            	addDragHandles();
            	addColorHandles();
            }, 300);
        },
        onReady: function () { // 에디터 준비 완료 후 모든 이미지 블록에 대해 실행
        	addClickButtons(); //이미지에 정렬 버튼 붙이기
        	applyImageAlignment(editorData.blocks);
        	applyColorToParagraphs(editorData.blocks);
        	
            updateFileIcons(); // 파일 아이콘 변경 로직        
            addDragHandles(); //드래그 아이콘 붙이기
            addColorHandles();
            initializeSorting(); //드래그기능 관련
        
            const blocks = editorData.blocks; // 블록 데이터 접근
            console.log("블록확인",blocks);
            blocks.forEach(block => {
            	console.log("블록타입확인",block.type);
            	
/*                 if (block.type === 'paragraph' && !block.data.color) {
                    block.data.color = "red";
                } */
                
                
                if (block.type === 'image') {
                    // 데이터베이스에서 불러온 크기 정보로 이미지 사이즈를 설정
                    console.log("이미지url", block.data.file.url);
                    const imageElement = document.querySelector(`img[src="\${block.data.file.url}"]`);
                    console.log("이미지url확인",imageElement);
                    if (imageElement) {
                    	
                        const align = block.data.file.align || 'left'; // 기본 정렬값은 'left'
                        console.log("현재 정렬 확인",align);
                        const alignWrapperDiv = imageElement.closest('.ui-wrapper');
                        console.log("정렬 부모 누구야",alignWrapperDiv);
                         if (alignWrapperDiv) {
                            setAlignment(alignWrapperDiv, align);
                        } 

                    	
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
                    placeholder: '헤더를 입력하세요.',
                    levels: [1, 2, 3, 4, 5, 6],
                    defaultLevel: 3,
                },
                shortcut: 'CMD+SHIFT+H',
            },
            
            paragraph: {
                class: Paragraph,
                inlineToolbar: true,
                config: {
                    placeholder: '내용을 입력하세요.',

                },
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
			                            //나중에 수정하자
			                            //나중에 수정하자//나중에 수정하자//나중에 수정하자//나중에 수정하자//나중에 수정하자
			                            const align = 'left';
			
			                            const formData = new FormData();
			                            formData.append('file', file);
			                            formData.append('width', width);
			                            formData.append('height', height);
			                            formData.append('align', align);
			                           
			                            
			                            
			                            console.log('@width : ', width, '@height :', height);
			                            console.log('@align : ', align);
			
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
			                                            height: height, // 실제 이미지 높이
			                                            align: align
			                                        }
			                                    });
			                                    
                                                setTimeout(() => {
                                                    makeImagesResizable();
                                                    addClickButtons();
                                                }, 100);
			                                    
			                                    
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
                    uploader: {
                        uploadByFile(file) {
                            console.log('Attempting to upload file...');
                            return new Promise((resolve, reject) => {
                                const formData = new FormData();
                                formData.append('file', file);
                                fetch('${pageContext.request.contextPath}/uploadFile2', {
                                    method: 'POST',
                                    body: formData
                                })
                                .then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        console.log('File uploaded:', data.file.url);
                                        resolve({
	                                        success: 1,
	                                        file: {
	                                            url: data.file.url,
	                                        }
                                        });
                                        setTimeout(() => {
                                            updateFileIcons();
                                        }, 100);

                                        
                                    } else {
                                        reject(new Error('File upload failed: ' + data.message));
                                    }
                                })
                                .catch(error => {
                                    console.error('Error uploading file:', error);
                                    reject(error);
                                });
                            });
                        }
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

function addClickButtons() {
    const contextPath = '${pageContext.request.contextPath}';

    $('#myEditor .image-tool__image, #myEditor .cdx-simple-image__picture').each(function () {
        if (!$(this).next('.button-container').length) {
            var buttonContainer = $('<div/>', {
                class: 'button-container'
            });

            var button1 = $('<button/>', {
                class: 'custom-button',
                click: function () {
                    const ceBlock = $(this).closest('.ce-block');
                    const blockId = ceBlock.attr('data-id');
                    const imgWrapper = $(this).closest('.cdx-block').find('.ui-wrapper');

                    if (imgWrapper.length) {
                        setAlignment(imgWrapper[0], 'left');
                        updateBlockAlign(blockId, 'left');
                    }
                }
            }).css('background', `url(${contextPath}/resources/images/icons/align_left2.png) no-repeat center center`);

            var button2 = $('<button/>', {
                class: 'custom-button',
                click: function () {
                    const ceBlock = $(this).closest('.ce-block');
                    const blockId = ceBlock.attr('data-id');
                    const imgWrapper = $(this).closest('.cdx-block').find('.ui-wrapper');

                    if (imgWrapper.length) {
                        setAlignment(imgWrapper[0], 'center');
                        updateBlockAlign(blockId, 'center');
                    }
                }
            }).css('background', `url(${contextPath}/resources/images/icons/align_center2.png) no-repeat center center`);

            var button3 = $('<button/>', {
                class: 'custom-button',
                click: function () {
                    const ceBlock = $(this).closest('.ce-block');
                    const blockId = ceBlock.attr('data-id');
                    const imgWrapper = $(this).closest('.cdx-block').find('.ui-wrapper');

                    if (imgWrapper.length) {
                        setAlignment(imgWrapper[0], 'right');
                        updateBlockAlign(blockId, 'right');
                    }
                }
            }).css('background', `url(${contextPath}/resources/images/icons/align_right2.png) no-repeat center center`);

            buttonContainer.append(button1, button2, button3);
            $(this).after(buttonContainer);
        }
    });
}

function updateBlockAlign(blockId, alignValue) {
    const block = editor.blocks.getById(blockId);
    if (block) {
        block.save().then(data => {
            data.data.file.align = alignValue;
            console.log('Updated block data:', data);
        }).catch(error => {
            console.error('Failed to save block data:', error);
        });
    } else {
        console.error('Block not found');
    }
}

function applyImageAlignment(blocks) {
	console.error('블럭 뭔데 말해봐!:', blocks);
    blocks.forEach(block => {
        if (block.type === 'image') {
            const imgElement = document.querySelector(`img[src="${block.data.file.url}"]`);
            if (imgElement) {
                const align = block.data.file.align || 'left'; // 기본 정렬값은 'left'
                const wrapperDiv = imgElement.parentNode;
                if (wrapperDiv) {
                    setAlignment(wrapperDiv, align);
                }
            }
        }
    });
}

function setAlignment(wrapper, align) {
    if (align === 'left') {
        wrapper.style.display = 'block';
        wrapper.style.marginLeft = '0';
        wrapper.style.marginRight = 'auto';
    } else if (align === 'center') {
        wrapper.style.display = 'block';
        wrapper.style.marginLeft = 'auto';
        wrapper.style.marginRight = 'auto';
    } else if (align === 'right') {
        wrapper.style.display = 'block';
        wrapper.style.marginLeft = 'auto';
        wrapper.style.marginRight = '0';
    }
}

function updateFileIcons() {
    const fileBlocks = document.querySelectorAll('.cdx-attaches');

    fileBlocks.forEach(function(block) {
    	
    	const downloadButton = block.querySelector('a.cdx-attaches__download-button');

        if (downloadButton) {
        	
            const href = downloadButton.getAttribute('href');
            const fileExtension = href.split('.').pop().toLowerCase(); // Get the file extension from URL
            
            console.log(fileExtension);

            const fileIconContainer = block.querySelector('.cdx-attaches__file-icon');
			
            if (fileExtension === 'pdf') {
            	fileIconContainer.innerHTML = '';
                fileIconContainer.innerHTML = '<img src="/resources/images/icons/wiki_file/pdf.png" class="wiki_fileIcon" alt="PDF Icon" style="width: 24px; height: 24px;">';
            } else if (fileExtension === 'ppt' || fileExtension === 'pptx') {
            	fileIconContainer.innerHTML = '';
                fileIconContainer.innerHTML = '<img src="/resources/images/icons/wiki_file/ppt.png" class="wiki_fileIcon" alt="PPT Icon" style="width: 24px; height: 24px;">';
            } else if (fileExtension === 'doc' || fileExtension === 'docx') {
            	fileIconContainer.innerHTML = '';
                fileIconContainer.innerHTML = '<img src="/resources/images/icons/wiki_file/doc.png" class="wiki_fileIcon" alt="DOC Icon" style="width: 24px; height: 24px;">';
            }
        }
    });
}

function initializeSorting() {
    $('#myEditor').sortable({
        handle: '.drag-handle', // 드래그 핸들로 이동 제한
        items: '.ce-block',     // 정렬 가능한 블록 지정
        axis: 'y',              // y축으로만 이동 허용
        cursor: 'move',         // 커서 스타일 변경
        placeholder: 'sortable-placeholder',
        forcePlaceholderSize: true,
        update: function(event, ui) {
            console.log('드래그 정렬 완료');
            updateOrderInEditor();
        }
    });
}

function addDragHandles() {
    const editorContent = document.getElementById('myEditor');
    const blocks = editorContent.querySelectorAll('.ce-block');

    blocks.forEach(block => {
        // 드래그 핸들이 이미 있는지 확인
        if (!block.querySelector('.drag-handle')) {
            const handle = document.createElement('div');
            handle.className = 'drag-handle';
            block.appendChild(handle);
        }
    });
}

function updateOrderInEditor() {
    // DOM에서 블록 ID의 현재 순서를 검색
    const orderedIds = $('#myEditor .ce-block').map(function () {
        return $(this).attr('data-id');
    }).get();
	
    console.log(orderedIds);
    console.log(editor);

    for (let i = 0; i < orderedIds.length; i++) {
        const currentId = orderedIds[i];
        // 현재 인덱스를 찾습니다.
        const currentIndex = editor.blocks.getBlockIndex(currentId); // 수정 필요
        if (currentIndex !== i) {
            // 현재 인덱스에서 새 인덱스로 블록을 이동합니다.
            editor.blocks.move(currentIndex, i);
        }
    }
    saveData();
}

function addColorHandles() {
    const blocks = document.querySelectorAll('.ce-block');
    blocks.forEach(block => {
        const colorHandle = block.querySelector('.color-handle');
        if (!colorHandle) {
            const newColorHandle = document.createElement('div');
            newColorHandle.className = 'color-handle';
            newColorHandle.onclick = function() {
                showColorPicker(this);
            };
            block.appendChild(newColorHandle);
        }
    });
}

function showColorPicker(colorHandle) {
    let colorPicker = document.getElementById('colorPicker');
    if (!colorPicker) {
        colorPicker = document.createElement('input');
        colorPicker.type = 'color';
        colorPicker.id = 'colorPicker';
        colorPicker.style.display = 'none'; // 초기에는 숨겨져 있음
        document.body.appendChild(colorPicker);
        colorPicker.onchange = function() {
            changeColor(this, colorHandle.closest('.ce-block'));
            updateBlockColor(this.value, colorHandle.closest('.ce-block').getAttribute('data-id'));
        };
    }
    colorPicker.click(); // 색상 선택기 활성화
}

function changeColor(picker, block) {
    const paragraph = block.querySelector('.ce-paragraph');
    if (paragraph) {
        paragraph.style.color = picker.value; // 변경되어야 할 속성을 'color'로 지정
    }
}

//컬러피커를 통해서 처리가되면, JSON에 color 값을 넣어주기
function updateBlockColor(colorValue, blockId) {
	
	console.log('가져온색상', colorValue);
	
    const block = editor.blocks.getById(blockId);
    console.log('찾은 색상 관련 블록', block);
    
    if (block) {
        block.save().then(data => {
        	console.log('색사변경대상 글자',data.data.text);
        	
            data.data.color = colorValue;
            console.log('색상변경 완료:', data);
           
            
        }).catch(error => {
            console.error('색상변경 실패:', error);x
        });
    } else {
        console.error('블록 못찾음');
    } 
    
}

//DB에 있는 애를 가져와서 뷰에다가 그려주는거
function applyColorToParagraphs(blocks) {
    console.log('색상찾는중!:', blocks);
    blocks.forEach(block => {
        if (block.type === 'paragraph') {
        	console.log('요놈이 paragraph');
            // Find the paragraph element using the data-id attribute
            const paragraphElement = document.querySelector(`div.ce-block[data-id="\${block.id}"] .ce-paragraph`);
            
            console.log('찾은 paragraphElement : ', paragraphElement);
            
            if (paragraphElement) {
                // Apply the color style if it exists in the block data
                const color = block.data.color || 'black'; // Default to black if no color is set
                paragraphElement.style.color = color;
                console.log(`Applied color ${color} to paragraph with id ${block.id}`);
            }
        }
    });
}



/* function setAlignment(wrapper, align) {
    if (align === 'left') {
        wrapper.style.display = 'block';
        wrapper.style.marginLeft = '0';
        wrapper.style.marginRight = 'auto';
    } else if (align === 'center') {
        wrapper.style.display = 'block';
        wrapper.style.marginLeft = 'auto';
        wrapper.style.marginRight = 'auto';
    } else if (align === 'right') {
        wrapper.style.display = 'block';
        wrapper.style.marginLeft = 'auto';
        wrapper.style.marginRight = '0';
    }
}
 */



</script>

</body>
</html>