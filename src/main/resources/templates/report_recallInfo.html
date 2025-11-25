<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리콜 보도자료</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>

    <style>
        body {
            font-family: "Noto Sans KR", sans-serif;
            margin: 0;
            background-color: #f8f9fa;
        }

        .container {
            width: 80%;
            margin: 40px auto;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .post-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.2s ease;
        }

        .post-card:hover {
            transform: translateY(-3px);
        }

        .post-title a {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            text-decoration: none;
        }

        .post-title a:hover {
            color: #007bff;
        }

        .post-content {
            margin-top: 10px;
            color: #555;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2; /* 최대 2줄까지만 표시 */
            -webkit-box-orient: vertical;
        }

        .post-info {
            font-size: 14px;
            color: #888;
            margin-top: 10px;
        }

        /* 페이징 */
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            margin-top: 30px;
            padding: 0;
        }

        .pagination li {
            margin: 0 5px;
        }

        .pagination a {
            text-decoration: none;
            color: #333;
            padding: 6px 10px;
            border-radius: 5px;
            background-color: #eee;
        }

        .pagination a:hover {
            background-color: #007bff;
            color: white;
        }

        .active-page a {
            background-color: #007bff;
            color: white;
        }

        .write-btn {
            display: block;
            width: 100px;
            text-align: center;
            margin: 20px auto;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border-radius: 6px;
            text-decoration: none;
        }

        .write-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

<div class="container">
    <h2>리콜 보도자료</h2>
    <div style="display:flex; justify-content:flex-end; align-items:center; margin-bottom:20px;">
<%--        검색창부분 --%>
        <form method="get" id="searchForm" action="${pageContext.request.contextPath}/board/list">
            <select name="type">
                <option value=""  <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
                <option value="T"  <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
                <option value="C"  <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
                <option value="TC"  <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>전체</option>
            </select>

            <input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
            <button>Search</button>
        </form>
    </div>

    <c:forEach var="dto" items="${list}">
        <div class="post-card">
            <div class="post-title">
                <a class="move_link" href="${dto.boardNo}">${dto.boardTitle}</a>
            </div>
            <div class="post-content">
                    ${dto.boardContent}
            </div>
            <div class="post-info">
                    ${dto.boardName} | ${dto.boardDate} | 조회수 ${dto.hit}
            </div>
        </div>
    </c:forEach>
    <!-- 페이징 -->
    <ul class="pagination">
        <c:if test="${pageMaker.prev}">
            <li class="paginate_button">
                <a href="${pageMaker.startPage - 1}">
                    [Previous]
                </a>
            </li>
        </c:if>
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li class="paginate_button" ${pageMaker.cri.pageNum == num ? "style='color: red'" : ""}>
                <a href="${num}">
                    [${num}]
                </a>
            </li>
        </c:forEach>
        <c:if test="${pageMaker.next}">
            <li class="paginate_button">
                <a href="${pageMaker.endPage + 1}">
                    [Next]
                </a>
            </li>
        </c:if>
    </ul>

    <form method="get" id="actionForm">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
        <input type="hidden" name="type" value="${pageMaker.cri.type}">
        <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
    </form>
</div>
</body>
</html>
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script>
    var actionForm = $("#actionForm");

    //페이지 번호 처리
    $(".paginate_button a").on("click", function (e) {
        e.preventDefault();
        console.log("click~!!!");
        console.log("@# href=>" + $(this).attr("href"));

        actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        actionForm.attr("action", "/board/report_recallInfo").submit();
    }); //end of paginate_button click

    //게시글 처리
    $(".move_link").on("click", function (e) {
        e.preventDefault();
        console.log("move_link click~!!!");
        console.log("@# href=>" + $(this).attr("href"));

        var targetBno = $(this).attr("href");

        //버그처리
        var bno = actionForm.find("input[name='boardNo']").val();
        if (bno != "") {
            actionForm.find("input[name='boardNo']").remove();
        }


        actionForm.append("<input type='hidden' name='boardNo' value='" + targetBno + "'>");
        //컨트롤러에 content_view 로 찾아감
        //버그 처리(게시글 클릭 후 뒤로가기 누른 후 다른페이지 클릭할 때 content_view로 가는걸 해결
        actionForm.attr("action", "/board/report_content_view").submit();

    }); //end of paginate_button click
</script>