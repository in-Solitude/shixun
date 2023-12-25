<%--
  Created by IntelliJ IDEA.
  User: SakuraKoujin
  Time:2023/7/4  16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.example.jspnew.javabean.GenericDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="zyy.Part.Teacher.Teacher" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>添加教师</title>
    <style>
        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;//qwe
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group textarea {
            width: 100%;
            height: 100px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
    <script>
        function closeWindowAndRefreshParent() {
            window.close();
            window.opener.location.reload();
        }
    </script>
</head>
<body>
<%
    int id= Integer.parseInt(request.getParameter("id"));
    GenericDAO genericDAO;
    try {
        genericDAO= new GenericDAO();
    } catch (ClassNotFoundException | SQLException e) {
        throw new RuntimeException(e);
    }
    List<Teacher> teachers =null;
    try {
        teachers=genericDAO.getAll(Teacher.class);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    Teacher teacher=new Teacher();
    for (Teacher it : teachers) {
        if (Integer.parseInt(it.getId())==id){
            teacher=it;
            break;
        }
    }

%>
<div class="container">
    <h2>编辑教师信息</h2>
    <form action="${pageContext.request.contextPath}/ManageServlet" method="post" onsubmit="closeWindowAndRefreshParent()">
        <div class="form-group">
            <label for="id">年龄:</label>
            <input type="number" id="id" name="id" value="<%= teacher.getId() %>" required>
        </div>

        <div class="form-group">
            <label for="name">姓名:</label>
            <input type="text" id="name" name="name" value="<%= teacher.getName() %>" required>
        </div>

        <div class="form-group">
            <label for="college">科目:</label>
            <input type="text" id="college" name="college" value="<%= teacher.getCollege() %>" required>
        </div>

        <div class="form-group">
            <button type="submit">保存</button>
        </div>
    </form>
</div>
</body>
</html>
