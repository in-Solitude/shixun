<%@ page import="java.sql.Connection" %>
<%@ page import="ngw.part.student.Student" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="zyy.Part.Teacher.Teacher" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>教师个人信息</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
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

        .form-group button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        .form-group button[disabled] {
            background-color: #ccc;
            cursor: not-allowed;
        }
    </style>
    <script>
        function enableEdit() {
            document.getElementById("name").removeAttribute("readonly");
            document.getElementById("college").removeAttribute("readonly");
            document.getElementById("saveButton").removeAttribute("disabled");
        }
    </script>
</head>
<%

    Teacher teacher= (Teacher) session.getAttribute("Teacher");
    System.out.println(teacher.getId());
    String username = teacher.getName();
    Connection conn = null;//qwe
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        // 连接数据库
        String url = "jdbc:sqlserver://localhost:3066;databaseName=TestSystem;trustServerCertificate=true";
        String user = "sa";
        String password = "sjk12345";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); // 加载SQL Server驱动
        conn = DriverManager.getConnection(url, user, password);

        // 查询该用户的个人信息
        String sql = "SELECT * FROM teacher WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, teacher.getId());
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String id = rs.getString("id");
            String name = rs.getString("name");
            String college = rs.getString("college");
%>
<body>
<div class="container">
    <h2>教师个人信息</h2>

    <form action="${pageContext.request.contextPath}/ManageServlet" method="post">
        <div class="form-group">
            <label for="id">工号:</label>
            <input type="text" id="id" name="id" value=<%=id%> readonly>
        </div>

        <div class="form-group">
            <label for="name">姓名:</label>
            <input type="text" id="name" name="name" value=<%=name%> readonly>
        </div>

        <div class="form-group">
            <label for="college">学院:</label>
            <input type="text" id="college" name="college" value=<%=college%> readonly>
        </div>

        <div class="form-group">
            <button type="button" onclick="enableEdit()">编辑</button>
            <button type="submit" id="saveButton" disabled>保存</button>
        </div>
    </form>
</div>
</body>
</html>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 关闭数据库连接
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e2) {
            e2.printStackTrace();
        }
    }

%>