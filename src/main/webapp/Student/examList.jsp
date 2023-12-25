<%@ page import="java.util.ArrayList" %>
<%@ page import="zyy.Part.Teacher.ExamPaper" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.jspnew.javabean.GenericDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>作业列表</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .exam {
            margin-bottom: 20px;
            background-color: #fff;
            padding: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .exam-id {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .exam-name {
            margin-bottom: 10px;
        }

        .start-button {
            text-align: right;
        }

        .start-button a {
            display: inline-block;
            padding: 5px 10px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .start-button a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%-- 设置作业列表 --%>
<%
    GenericDAO genericDAO;
    try {
        genericDAO = new GenericDAO();
    } catch (ClassNotFoundException | SQLException e) {
        throw new RuntimeException(e);
    }
    List<ExamPaper> examPapers = null;
    try {
        examPapers = genericDAO.getAll(ExamPaper.class);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>

<div class="container">
    <h1>作业列表</h1>
    <%-- 遍历作业列表 --%>
    <% for (ExamPaper exam : examPapers) { %>
    <div class="exam">
        <div class="exam-id"><%= exam.getPaper_id() %></div>
        <div class="exam-name"><%= exam.getPaper_name() %></div>
        <div class="start-button">
            <a href="examPaper.jsp?examId=<%= exam.getPaper_id() %>">完成作业</a>
        </div>
    </div>
    <% } %>
</div>
</body>
</html>