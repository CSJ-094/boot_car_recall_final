<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>내 차량 관리 - 자동차 리콜 통합센터</title>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/login.css" /> <!-- 재활용 가능한 스타일 -->
    <style>
        /* 기존 my-vehicles-container 스타일을 제거하거나 조정 */
        /* .my-vehicles-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        } */
        .my-vehicles-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .vehicle-form {
            margin-bottom: 40px;
            padding: 20px;
            border: 1px solid #eee;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .vehicle-form h2 {
            font-size: 1.4rem;
            margin-bottom: 20px;
            color: #007bff;
            text-align: center;
        }
        .vehicle-list {
            list-style: none;
            padding: 0;
        }
        .vehicle-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 10px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }
        .vehicle-info {
            flex-grow: 1;
        }
        .vehicle-info strong {
            font-size: 1.1rem;
            color: #333;
        }
        .vehicle-info span {
            display: block;
            font-size: 0.9rem;
            color: #666;
        }
        .delete-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
        .no-vehicles {
            text-align: center;
            color: #888;
            padding: 30px;
            border: 1px dashed #ccc;
            border-radius: 8px;
            margin-top: 20px;
        }
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
        <div class="my-vehicles-container">
            <h1>내 차량 관리</h1>

            <%-- 메시지 표시 부분 제거 --%>

            <div class="vehicle-form">
                <h2>새 차량 등록</h2>
                <form action="/my-vehicles/add" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="input-group">
                        <label for="maker">제조사</label>
                        <input type="text" id="maker" name="maker" required />
                    </div>
                    <div class="input-group">
                        <label for="modelName">모델명</label>
                        <input type="text" id="modelName" name="modelName" required />
                    </div>
                    <button type="submit" class="login-btn">차량 등록</button>
                </form>
            </div>

            <h2>등록된 내 차량</h2>
            <c:choose>
                <c:when test="${not empty userVehicles}">
                    <ul class="vehicle-list">
                        <c:forEach var="vehicle" items="${userVehicles}">
                            <li class="vehicle-item">
                                <div class="vehicle-info">
                                    <strong>${vehicle.maker} ${vehicle.modelName}</strong>
                                    <span>ID: ${vehicle.id}</span>
                                </div>
                                <form action="/my-vehicles/delete" method="post" onsubmit="return confirm('정말로 이 차량을 삭제하시겠습니까?');">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="hidden" name="id" value="${vehicle.id}" />
                                    <button type="submit" class="delete-btn">삭제</button>
                                </form>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="no-vehicles">등록된 차량이 없습니다. 새로운 차량을 등록하여 리콜 알림을 받아보세요!</p>
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