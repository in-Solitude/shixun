<%@ page import="ngw.part.student.Student" %>
<!DOCTYPE html>
<html>
<head>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <title>学生主页</title>
    <link rel="stylesheet" href="infoStyle.css">
    <%
        Student student = (Student) session.getAttribute("Student");//qwe
    %>

</head>

<body>
<header>
    <h1>学生主页</h1>
</header>


<main class="main-content">
    <div class="container">
        <section>
            <p>欢迎您，<%=student.getName()%>！</p>

        </section>

        <section>
            <a href="userInfo.jsp" class="btn">个人信息管理</a>
        </section>

        <section>
            <a href="examList.jsp" class="btn">查看作业</a>
        </section>

        <section>
            <a href="scoreList.jsp" class="btn">查看成绩</a>
        </section>

        <section>
            <a href="logout.jsp" class="btn">退出登录</a>
        </section>
    </div>
</main>

<footer>

    <p>&copy; 2023 学生主页</p>
</footer>
</body>
</html>