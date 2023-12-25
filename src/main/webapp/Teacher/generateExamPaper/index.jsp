<%--
  Created by IntelliJ IDEA.
  User: SakuraKoujin
  Time:2023/7/5  22:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.jspnew.javabean.GenericDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="zyy.Part.Teacher.QuestionBank" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>教师页面 - 生成作业</title>
  <link rel="stylesheet" type="text/css" href="styles.css"> <!-- 引入CSS文件 -->
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
      margin: 0;
      padding: 0;
    }

    header {
      background-color: #4CAF50;
      text-align: center;
      padding: 20px;
      color: #ffffff;
    }

    .content {
      max-width: 800px;
      margin: 20px auto;
      padding: 20px;
      background-color: #ffffff;
      border-radius: 5px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    h2 {
      margin-top: 0;
    }

    ul {
      list-style-type: none;
      padding: 0;
      margin: 0;
    }

    li {
      margin-bottom: 10px;
    }

    button {
      padding: 10px 20px;
      background-color: #4CAF50;
      color: #ffffff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    button:hover {
      background-color: #45a049;
    }

    footer {
      background-color: #4CAF50;
      text-align: center;
      padding: 10px;
      color: #ffffff;
      margin-top: 20px;
    }
  </style>
</head>
<body>
<header>
  <h1>作业管理系统 - 生成作业</h1>
</header>

<!-- 内容区域 -->
<div class="content">
  <h2>选择题目生成作业</h2>
  <form action="${pageContext.request.contextPath}/generateExamPaperServlet" method="post">
    <label for="paper_name">输入作业名称</label><input type="text" id="paper_name" name="paper_name">
    <ul>
      <%-- 使用 Java 代码块从数据库读取题目，并在页面上输出 --%>
      <%
        // 从数据库中获取题目列表
        GenericDAO genericDAO;
        try {
           genericDAO = new GenericDAO();
        } catch (ClassNotFoundException | SQLException e) {
          throw new RuntimeException(e);
        }
        List<QuestionBank> questions = null;
        try {
          questions = genericDAO.getAll(QuestionBank.class);
        } catch (SQLException e) {
          throw new RuntimeException(e);
        }

        // 遍历题目列表，并输出题目
        for (QuestionBank question : questions) {
      %>
      <li>
        <label>
          <input type="checkbox" name="selectedQuestions" value="<%= question.getId() %>">
          <%= question.getQuestion_text() %><%=question.AllOptions()%>
        </label>
      </li>
      <% } %>
    </ul>
    <button type="submit">生成作业</button>
  </form>
</div>

<footer>
  <p>&copy; 2023 作业管理系统. All rights reserved.</p>
</footer>

</body>
</html>
