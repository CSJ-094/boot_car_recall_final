<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>아이디/비밀번호 찾기 - 자동차 리콜 통합센터</title>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/login.css" />
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <main class="login-container">
        <div class="login-card">
            <h1 class="login-title">아이디/비밀번호 찾기</h1>

            <div class="tab-container">
                <div class="tab-header">
                    <button class="tab-btn active" data-tab="find-id">아이디 찾기</button>
                    <button class="tab-btn" data-tab="reset-pw">비밀번호 재설정</button>
                </div>
                <div class="tab-content">
                    <!-- 아이디 찾기 폼 -->
                    <div id="find-id" class="tab-pane active">
                        <form action="/find-id" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <p class="form-description">가입 시 사용한 이메일 주소를 입력하세요.</p>
                            <div class="input-group">
                                <label for="email-id">이메일</label>
                                <input type="email" id="email-id" name="email" required />
                            </div>
                            <button type="submit" class="login-btn">아이디 찾기</button>
                        </form>
                    </div>
                    <!-- 비밀번호 재설정 폼 -->
                    <div id="reset-pw" class="tab-pane">
                        <form action="/reset-password" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <p class="form-description">아이디와 이메일 주소를 입력하세요.</p>
                            <div class="input-group">
                                <label for="username-pw">아이디</label>
                                <input type="text" id="username-pw" name="username" required />
                            </div>
                            <div class="input-group">
                                <label for="email-pw">이메일</label>
                                <input type="email" id="email-pw" name="email" required />
                            </div>
                            <button type="submit" class="login-btn">비밀번호 재설정</button>
                        </form>
                    </div>
                </div>
            </div>
             <div class="login-links">
                <a href="/login">로그인으로 돌아가기</a>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const tabs = document.querySelectorAll('.tab-btn');
            const panes = document.querySelectorAll('.tab-pane');

            tabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    const targetId = this.getAttribute('data-tab');

                    tabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');

                    panes.forEach(pane => {
                        if (pane.id === targetId) {
                            pane.classList.add('active');
                        } else {
                            pane.classList.remove('active');
                        }
                    });
                });
            });
        });
    </script>
    <style>
        .tab-container { width: 100%; }
        .tab-header { display: flex; border-bottom: 2px solid #eee; }
        .tab-btn { flex: 1; background: none; border: none; padding: 1rem; font-size: 1rem; cursor: pointer; color: #888; border-bottom: 2px solid transparent; }
        .tab-btn.active { color: #007bff; border-bottom-color: #007bff; font-weight: 600; }
        .tab-content { padding-top: 1.5rem; }
        .tab-pane { display: none; }
        .tab-pane.active { display: block; }
        .form-description { font-size: 0.9rem; color: #666; margin-bottom: 1rem; }
    </style>
</body>
</html>