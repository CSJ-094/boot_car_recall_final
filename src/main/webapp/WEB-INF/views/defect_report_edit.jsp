<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결함 신고 수정</title>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/header.css" />
    <link rel="stylesheet" href="/css/footer.css" />
    <style>
        /* 이 페이지에만 적용될 추가적인 스타일 */
        .container { 
            padding-top: 50px; 
            padding-bottom: 50px; 
        }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .form-group input[type="password"] { width: auto; display: inline-block; } /* 비밀번호 필드 너비 조정 */
        .form-group input[type="file"] { border: none; padding: 5px 0; }
        .form-group textarea { resize: vertical; height: 150px; }
        .btn-group { text-align: center; margin-top: 20px; }
        .btn-group button, .btn-group a { display: inline-block; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 1.1em; font-weight: 600; margin: 0 5px; text-decoration: none; }
        .btn-group .submit-btn { background-color: #0d47a1; color: white; }
        .btn-group .submit-btn:hover { background-color: #1565c0; }
        .btn-group .cancel-btn { background-color: #6c757d; color: white; }
        .btn-group .cancel-btn:hover { background-color: #5a6268; }
        .image-preview-container { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px; }
        .image-preview { width: 100px; height: 100px; border: 1px solid #ddd; display: flex; justify-content: center; align-items: center; overflow: hidden; position: relative; }
        .image-preview img { max-width: 100%; max-height: 100%; object-fit: cover; }
        .existing-image-item { position: relative; width: 100px; height: 100px; border: 1px solid #ddd; }
        .existing-image-item img { max-width: 100%; max-height: 100%; object-fit: contain; }
        .existing-image-item .delete-image-btn { position: absolute; top: 0; right: 0; background-color: rgba(255, 0, 0, 0.7); color: white; border: none; border-radius: 0 0 0 5px; cursor: pointer; padding: 2px 5px; font-size: 0.8em; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <div class="container">
        <h2>결함 신고 수정</h2>
        <c:if test="${empty report}">
            <p style="text-align:center; color: red;">수정할 신고를 찾을 수 없습니다.</p>
        </c:if>
        <c:if test="${not empty report}">
            <form action="/report/edit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${report.id}">
                <input type="hidden" name="password" value="${report.password}"> <!-- 비밀번호는 hidden으로 전달 -->
                <div class="form-group">
                    <label for="reporterName">신고인 성명</label>
                    <input type="text" id="reporterName" name="reporterName" value="${report.reporterName}" required>
                </div>
                <div class="form-group">
                    <label for="contact">연락처</label>
                    <input type="text" id="contact" name="contact" value="${report.contact}" required>
                </div>
                <div class="form-group">
                    <label for="carModel">차량 모델</label>
                    <input type="text" id="carModel" name="carModel" value="${report.carModel}" required>
                </div>
                <div class="form-group">
                    <label for="vin">차대번호 (VIN)</label>
                    <input type="text" id="vin" name="vin" value="${report.vin}">
                </div>
                
                <div class="form-group">
                    <label>현재 첨부 이미지:</label>
                    <div class="image-preview-container" id="existingImagePreviewContainer">
                        <c:forEach items="${report.images}" var="image">
                            <div class="existing-image-item">
                                <img src="/defect_images/${image.fileName}" alt="${image.fileName}">
                                <button type="button" class="delete-image-btn" data-filename="${image.fileName}" onclick="removeExistingImage(this)">X</button>
                                <input type="hidden" name="existingImageFileNames" value="${image.fileName}">
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="form-group">
                    <label for="defectImages">새로운 결함 이미지 (여러 개 선택 가능)</label>
                    <input type="file" id="defectImages" name="newDefectImages" accept="image/*" multiple onchange="previewNewImages(event)">
                    <div class="image-preview-container" id="newImagePreviewContainer"></div>
                </div>

                <div class="form-group">
                    <label for="defectDetails">결함 내용</label>
                    <textarea id="defectDetails" name="defectDetails" required>${report.defectDetails}</textarea>
                </div>
                <div class="btn-group">
                    <button type="submit" class="submit-btn">수정 완료</button>
                    <a href="/report/detail?id=${report.id}" class="cancel-btn">취소</a>
                </div>
            </form>
        </c:if>
    </div>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>

    <script>
        function previewNewImages(event) {
            const previewContainer = document.getElementById('newImagePreviewContainer');
            previewContainer.innerHTML = ''; // 기존 미리보기 초기화

            if (event.target.files) {
                Array.from(event.target.files).forEach(file => {
                    const reader = new FileReader();
                    reader.onload = (e) => {
                        const imgDiv = document.createElement('div');
                        imgDiv.className = 'image-preview';
                        const img = document.createElement('img');
                        img.src = e.target.result;
                        imgDiv.appendChild(img);
                        previewContainer.appendChild(imgDiv);
                    };
                    reader.readAsDataURL(file);
                });
            }
        }

        function removeExistingImage(buttonElement) {
            const item = buttonElement.closest('.existing-image-item');
            if (item) {
                item.remove();
            }
        }
    </script>
</body>
</html>
