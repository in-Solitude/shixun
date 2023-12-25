<%@ page import="zyy.Part.Admin.Admin" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="zyy.Part.Teacher.Teacher" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>教师页面</title>
    <link rel="stylesheet" type="text/css" href="DashBoardStyle.css"> <!-- 引入CSS文件 -->
</head>
<body>
<header>
    <h1>作业管理系统 - 教师页面</h1>
    <div class="user-info">
        <%-- 显示教师信息 --%>

        <%-- 添加个人信息和登出按钮 --%>
        <div class="user-buttons">
            <a href="../Info" class="button">个人信息</a>
            <a href="#" class="button">登出</a>
        </div>
    </div>
</header>
<h2>概述</h2>
<%
    Teacher teacher = (Teacher) session.getAttribute("Teacher");
    if(teacher!=null&&teacher.getId() !=null){//qwe
        System.out.println(teacher.getId());
        out.print("<h3>教师登录成功.  欢迎你,"+teacher.getId()+"</h3>");
        Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
        out.print("<p>现在是"+dateFormat.format(currentDate)+"</p>");
    }
%>
<nav>
    <ul>
        <li><a href="../studentManagement" class="button">学生管理</a></li>
        <li><a href="../questionManagement" class="button">题库管理</a></li>
        <li><a href="../examPaperManagement" class="button">作业管理</a></li>
        <li><a href="../generateExamPaper" class="button">作业生成</a></li>
<%--        <li><a href="../ExamManagement" class="button">考试管理</a></li>--%>
        <li><a href="../dataImport" class="button">导入数据</a></li>
        <li><a href="../loginLogs" class="button">登录日志</a></li>
    </ul>
</nav>

<footer>
    <p>&copy; 2023 管理员控制面板. All rights reserved.</p>
</footer>
</body>
</html>
