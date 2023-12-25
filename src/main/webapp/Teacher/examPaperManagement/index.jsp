<%@ page import="com.example.jspnew.javabean.GenericDAO" %>
<%@ page import="zyy.Part.Teacher.ExamPaper" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: SakuraKoujin
  Time:2023/7/6  0:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>教师作业查看</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        li {
            margin-bottom: 10px;
        }

        a {
            display: block;
            padding: 10px;
            background-color: #4CAF50;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>教师作业查看</h1>

    <ul>
        <%-- 使用循环显示所有作业标题 --%>
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
            for (ExamPaper paper : examPapers) { %>
        <li><a href="../showExamPaper?id=<%= paper.getPaper_id() %>"><%= paper.getPaper_name() %></a></li>
        <% } %>
    </ul>
</div>
</body>
</html>
