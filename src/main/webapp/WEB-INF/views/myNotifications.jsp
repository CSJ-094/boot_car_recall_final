<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>내 알림 - 자동차 리콜 통합센터</title>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/login.css" /> <!-- 재활용 가능한 스타일 -->
    <style>
        /* 기존 my-notifications-container 스타일을 제거하거나 조정 */
        /* .my-notifications-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        } */
        .my-notifications-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .notification-list {
            list-style: none;
            padding: 0;
        }
        .notification-item {
            display: flex;
            flex-direction: column;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 10px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            position: relative;
        }
        .notification-item.unread {
            background-color: #e6f7ff; /* 읽지 않은 알림 배경색 */
            border-color: #91d5ff;
        }
        .notification-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .notification-title {
            font-size: 1.1rem;
            font-weight: bold;
            color: #333;
        }
        .notification-meta {
            font-size: 0.85rem;
            color: #888;
        }
        .notification-message {
            font-size: 0.95rem;
            color: #555;
            line-height: 1.5;
            margin-bottom: 10px;
        }
        .notification-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .notification-link {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.85rem;
            transition: background-color 0.2s;
        }
        .notification-link:hover {
            background-color: #0056b3;
        }
        .mark-as-read-btn {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.85rem;
            transition: background-color 0.2s;
        }
        .mark-as-read-btn:hover {
            background-color: #5a6268;
        }
        .no-notifications {
            text-align: center;
            color: #888;
            padding: 30px;
            border: 1px dashed #ccc;
            border-radius: 8px;
            margin-top: 20px;
        }
        /* .alert {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-size: 0.9rem;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        } */
        /* .container 클래스에 맞게 여백 조정 */
        main.container {
            padding-top: 50px;
            padding-bottom: 50px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <main class="container">
        <div class="my-notifications-container">
            <h1>내 알림</h1>

            <%-- 메시지 표시 부분 제거 --%>

            <c:choose>
                <c:when test="${not empty notifications}">
                    <ul class="notification-list">
                        <c:forEach var="notification" items="${notifications}">
                            <li class="notification-item ${!notification.read ? 'unread' : ''}">
                                <div class="notification-header">
                                    <span class="notification-title">${notification.title}</span>
                                    <span class="notification-meta">
                                        ${notification.formattedCreatedAt}
                                        <c:if test="${!notification.read}"> (읽지 않음)</c:if>
                                    </span>
                                </div>
                                <div class="notification-message">${notification.message}</div>
                                <div class="notification-actions">
                                    <c:if test="${not empty notification.link}">
                                        <a href="${notification.link}" class="notification-link">자세히 보기</a>
                                    </c:if>
                                    <c:if test="${!notification.read}">
                                        <form action="/my-notifications/mark-as-read" method="post" style="display: inline;">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <input type="hidden" name="id" value="${notification.id}" />
                                            <button type="submit" class="mark-as-read-btn">읽음 처리</button>
                                        </form>
                                    </c:if>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="no-notifications">새로운 알림이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>

    <script>
        // 페이지 로드 시 메시지 팝업
        window.onload = function() {
            <c:if test="${not empty message}">
                alert("${message}");
            </c:if>
            <c:if test="${not empty errorMessage}">
                alert("오류: ${errorMessage}");
            </c:if>
        };
    </script>
</body>
</html>