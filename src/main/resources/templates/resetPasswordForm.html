<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>비밀번호 재설정 - 자동차 리콜 통합센터</title>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/login.css" />
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <main class="login-container">
        <div class="login-card">
            <h1 class="login-title">비밀번호 재설정</h1>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <form id="reset-password-form" action="/reset-password-confirm" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="token" value="${token}" />
                <div class="input-group">
                    <label for="new-password">새 비밀번호</label>
                    <input type="password" id="new-password" name="newPassword" required autofocus />
                </div>
                <div class="input-group">
                    <label for="confirm-password">새 비밀번호 확인</label>
                    <input type="password" id="confirm-password" name="confirmPassword" required />
                </div>

                <button type="submit" class="login-btn">비밀번호 변경</button>
            </form>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
    <script>
        const form = document.getElementById('reset-password-form');
        form.addEventListener('submit', function(event) {
            const newPassword = document.getElementById('new-password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            if (newPassword !== confirmPassword) {
                alert('새 비밀번호가 일치하지 않습니다.');
                event.preventDefault();
            }
        });
    </script>
</body>
</html>