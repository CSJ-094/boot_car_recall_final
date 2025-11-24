<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>로그인 - 자동차 리콜 통합센터</title>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/login.css" />
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <main class="login-container">
        <div class="login-card">
            <h1 class="login-title">로그인</h1>

            <div class="role-switch">
                <button id="user-btn" class="role-btn active" data-role="user">사용자</button>
                <button id="admin-btn" class="role-btn" data-role="admin">관리자</button>
            </div>

            <form id="login-form" action="/login" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" id="login-type" name="login-type" value="user">
                <div class="input-group">
                    <label for="username">아이디</label>
                    <input type="text" id="username" name="username" required autofocus />
                </div>
                <div class="input-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" required />
                </div>

                <c:if test="${not empty param.error}">
                    <div class="error-message">
                        아이디 또는 비밀번호가 올바르지 않습니다.
                    </div>
                </c:if>

                <button type="submit" class="login-btn">로그인</button>
            </form>

            <div class="login-links">
                <a href="/signup">회원가입</a>
                <a href="/find-account">아이디/비밀번호 찾기</a>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>

    <script src="/js/login.js"></script>
</body>
</html>