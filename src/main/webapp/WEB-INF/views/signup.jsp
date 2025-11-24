<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>회원가입 - 자동차 리콜 통합센터</title>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/login.css" />
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <main class="login-container">
        <div class="login-card">
            <h1 class="login-title">회원가입</h1>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <form id="signup-form" action="/signup" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="input-group">
                    <label for="username">아이디</label>
                    <input type="text" id="username" name="username" required autofocus />
                </div>
                <div class="input-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" required />
                </div>
                <div class="input-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" required />
                </div>
                <div class="input-group">
                    <label for="password-confirm">비밀번호 확인</label>
                    <input type="password" id="password-confirm" name="password-confirm" required />
                </div>

                <button type="submit" class="login-btn">가입하기</button>
            </form>

            <div class="login-links">
                <span>이미 계정이 있으신가요?</span>
                <a href="/login">로그인</a>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
    <script>
        const form = document.getElementById('signup-form');
        form.addEventListener('submit', function(event) {
            const password = document.getElementById('password').value;
            const passwordConfirm = document.getElementById('password-confirm').value;
            if (password !== passwordConfirm) {
                alert('비밀번호가 일치하지 않습니다.');
                event.preventDefault();
            }
        });
    </script>
</body>
</html>