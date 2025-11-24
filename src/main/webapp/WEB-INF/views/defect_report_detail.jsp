<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결함 신고 상세</title>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/header.css" />
    <link rel="stylesheet" href="/css/footer.css" />
    <style>
        /* 이 페이지에만 적용될 추가적인 스타일 */
        .container { 
            padding-top: 50px; 
            padding-bottom: 50px; 
        }
        .detail-item { margin-bottom: 10px; padding-bottom: 10px; border-bottom: 1px solid #eee; }
        .detail-item:last-child { border-bottom: none; }
        .detail-item label { font-weight: bold; display: inline-block; width: 120px; color: #555; }
        .detail-item span { color: #333; }
        .defect-details-box { border: 1px solid #ddd; padding: 15px; border-radius: 4px; background-color: #f9f9f9; margin-top: 10px; line-height: 1.6; white-space: pre-wrap; word-wrap: break-word; }
        .btn-group { text-align: center; margin-top: 20px; }
        .btn-group a, .btn-group button { display: inline-block; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 1.1em; font-weight: 600; margin: 0 5px; text-decoration: none; }
        .btn-group .edit-btn { background-color: #28a745; color: white; }
        .btn-group .edit-btn:hover { background-color: #218838; }
        .btn-group .delete-btn { background-color: #dc3545; color: white; }
        .btn-group .delete-btn:hover { background-color: #c82333; }
        .btn-group .back-btn { background-color: #6c757d; color: white; }
        .btn-group .back-btn:hover { background-color: #5a6268; }

        /* 비밀번호 입력 모달 스타일 */
        .password-modal { 
            display: none; 
            position: fixed; 
            z-index: 1; 
            left: 0; 
            top: 0; 
            width: 100%; 
            height: 100%; 
            overflow: auto; 
            background-color: rgba(0,0,0,0.4);
        }
        .password-modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 300px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            text-align: center;
        }
        .password-modal-content input {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .password-modal-content button {
            padding: 8px 15px;
            margin: 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .password-modal-content .confirm-btn { background-color: #0d47a1; color: white; }
        .password-modal-content .cancel-btn { background-color: #6c757d; color: white; }
        .password-error { color: red; font-size: 0.9em; margin-top: 5px; display: none; }

        /* 이미지 표시 스타일 */
        .image-display-container { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px; justify-content: center; }
        .image-display { max-width: 150px; max-height: 150px; border: 1px solid #ddd; padding: 5px; object-fit: contain; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <div class="container">
        <h2>신고 상세 내용</h2>
        <c:if test="${not empty message}">
            <p style="text-align:center; color: green;">${message}</p>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <p style="text-align:center; color: red;">${errorMessage}</p>
        </c:if>
        <c:if test="${empty report}">
            <p style="text-align:center; color: red;">해당 신고를 찾을 수 없습니다.</p>
        </c:if>
        <c:if test="${not empty report}">
            <div class="detail-item">
                <label>신고번호:</label><span>${report.id}</span>
            </div>
            <div class="detail-item">
                <label>신고인 성명:</label><span>${report.reporterName}</span>
            </div>
            <div class="detail-item">
                <label>연락처:</label><span>${report.contact}</span>
            </div>
            <div class="detail-item">
                <label>차량 모델:</label><span>${report.carModel}</span>
            </div>
            <div class="detail-item">
                <label>차대번호 (VIN):</label><span>${report.vin}</span>
            </div>
            <div class="detail-item">
                <label>신고일:</label><span><fmt:formatDate value="${report.reportDate}" pattern="yyyy-MM-dd HH:mm"/></span>
            </div>
            <div class="detail-item">
                <label>결함 내용:</label>
                <div class="defect-details-box">${report.defectDetails}</div>
            </div>
            
            <c:if test="${not empty report.images}">
                <div class="detail-item">
                    <label>첨부 이미지:</label>
                    <div class="image-display-container">
                        <c:forEach items="${report.images}" var="image">
                            <img src="/defect_images/${image.fileName}" alt="결함 이미지" class="image-display">
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <div class="btn-group">
                <button type="button" class="edit-btn" onclick="showPasswordModal('edit')">수정</button>
                <button type="button" class="delete-btn" onclick="showPasswordModal('delete')">삭제</button>
                <a href="/report/history" class="back-btn">목록으로</a>
            </div>
        </c:if>
    </div>

    <!-- 비밀번호 입력 모달 -->
    <div id="passwordModal" class="password-modal">
        <div class="password-modal-content">
            <h3>비밀번호 확인</h3>
            <p>수정/삭제를 위해 비밀번호를 입력하세요.</p>
            <input type="password" id="passwordInput" maxlength="4" pattern="[0-9]{4}" title="4자리 숫자를 입력하세요">
            <p class="password-error" id="passwordError">비밀번호를 입력해주세요.</p>
            <button type="button" class="confirm-btn" onclick="confirmAction()">확인</button>
            <button type="button" class="cancel-btn" onclick="closePasswordModal()">취소</button>
        </div>
    </div>

    <!-- 수정 폼 (숨김) -->
    <form id="editForm" action="/report/edit" method="get" style="display:none;">
        <input type="hidden" name="id" value="${report.id}">
        <input type="hidden" name="password" id="editPassword">
    </form>

    <!-- 삭제 폼 (숨김) -->
    <form id="deleteForm" action="/report/delete" method="post" style="display:none;">
        <input type="hidden" name="id" value="${report.id}">
        <input type="hidden" name="password" id="deletePassword">
    </form>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>

    <script>
        let currentAction = ''; // 'edit' 또는 'delete'

        function showPasswordModal(action) {
            currentAction = action;
            document.getElementById('passwordModal').style.display = 'block';
            document.getElementById('passwordInput').value = ''; // 입력 필드 초기화
            document.getElementById('passwordError').style.display = 'none'; // 오류 메시지 숨김
        }

        function closePasswordModal() {
            document.getElementById('passwordModal').style.display = 'none';
        }

        function confirmAction() {
            const password = document.getElementById('passwordInput').value;
            const reportId = ${report.id};

            if (password.length !== 4 || !/^[0-9]{4}$/.test(password)) {
                document.getElementById('passwordError').textContent = '4자리 숫자로 된 비밀번호를 입력해주세요.';
                document.getElementById('passwordError').style.display = 'block';
                return;
            }

            if (currentAction === 'edit') {
                document.getElementById('editPassword').value = password;
                document.getElementById('editForm').submit();
            } else if (currentAction === 'delete') {
                document.getElementById('deletePassword').value = password;
                // 삭제는 confirm 창을 한 번 더 띄웁니다.
                if (confirm('정말로 이 신고를 삭제하시겠습니까?')) {
                    document.getElementById('deleteForm').submit();
                }
            }
            closePasswordModal();
        }

        // Flash attribute 메시지 처리
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('message');
            const errorMessage = urlParams.get('errorMessage');

            if (message) {
                alert(decodeURIComponent(message));
                // URL에서 메시지 파라미터 제거 (선택 사항)
                history.replaceState(null, '', window.location.pathname + window.location.search.replace(/([?&])message=[^&]*(&|$)/, '$1').replace(/([?&])errorMessage=[^&]*(&|$)/, '$1'));
            }
            if (errorMessage) {
                alert(decodeURIComponent(errorMessage));
                history.replaceState(null, '', window.location.pathname + window.location.search.replace(/([?&])message=[^&]*(&|$)/, '$1').replace(/([?&])errorMessage=[^&]*(&|$)/, '$1'));
            }
        };
    </script>
</body>
</html>
