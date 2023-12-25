<%@ page import="com.example.jspnew.javabean.GenericDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="ngw.part.student.Student" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>编辑学生</title>
    <style>
        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
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
        .add-button {
            text-align: center;
            margin-top: 20px;
        }

        .add-button button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
    <script>
        function closeWindowAndRefreshParent() {
            window.close(); // 关闭当前窗口
            window.opener.refreshParentWindow(); // 调用主窗口的刷新函数
        }
    </script>
</head>
<body>
<%
    if(request.getParameter("id")==null){
        return;//qwe
    }
    int id= Integer.parseInt(request.getParameter("id"));
    GenericDAO genericDAO;
    try {
        genericDAO= new GenericDAO();
    } catch (ClassNotFoundException | SQLException e) {
        throw new RuntimeException(e);
    }
    List<Student> students =null;
    try {
        students=genericDAO.getAll(Student.class);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    Student student=new Student();
    for (Student it : students) {
        if (Integer.parseInt(it.getId())==id){
            student=it;
            break;
        }
    }
    session.setAttribute("student",student);
    System.out.println(request.getContextPath());//为什么下面表单的action直接写servlet找不到?
%>
<div class="container">
    <h2>编辑学生信息</h2>

    <form action="${pageContext.request.contextPath}/ManageServlet?action=edit" method="post" onsubmit=" closeWindowAndRefreshParent()">
        <div class="form-group">
            <label for="id">Id:</label>
            <input type="number" id="id" name="id" value="<%= student.getId() %>" disabled>
        </div>

        <div class="form-group">
            <label for="name">姓名:</label>
            <input type="text" id="name" name="name" value="<%= student.getName() %>" required>
        </div>

        <div class="form-group">
            <label for="college">学院:</label>
            <input type="text" id="college" name="college" value="<%= student.getStu_class() %>" required>
        </div>

        <div class="form-group">
            <input type="hidden" id="page" name="page" value="Student" required>
        </div>

        <div class="form-group">
            <button type="submit">保存</button>
        </div>
    </form>
</div>

</body>
</html>
