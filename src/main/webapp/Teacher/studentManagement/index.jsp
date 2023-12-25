
<%@ page import="java.util.List" %>
<%@ page import="com.example.jspnew.javabean.GenericDAO" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="ngw.part.student.Student" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生管理</title>
    <link rel="stylesheet" type="text/css" href="studentManagementStyle.css"> <!-- 引入CSS文件 -->
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
        }

        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

        /* 表格容器样式 */
        .table-container {
            margin: 20px; /* 添加外边距 */
        }

        /* 表格样式 */
        .student-table {
            width: 100%;
            border-collapse: collapse;
        }

        .student-table th,
        .student-table td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        /* 编辑按钮样式 */
        .edit-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 4px;
        }

        .edit-button:hover {
            background-color: #45a049;
        }

        /* 删除按钮样式 */
        .delete-button {
            background-color: #f44336;
            color: white;
            border: none;
            cursor: pointer;
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 4px;
        }

        .delete-button:hover {
            background-color: #d32f2f;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #4CAF50;
        }
    </style>
</head>
<body>
<header>
    <h1>学生管理</h1>
</header>

<div class="table-container"> <!-- 添加表格容器 -->
    <table class="student-table">
        <thead>
        <tr>
            <th>学号</th>
            <th>学生姓名</th>
            <th>所属学院</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            final String DB_URL = "jdbc:sqlserver://localhost:3066;databaseName=TestSystem;trustServerCertificate=true";
            final String DB_USERNAME = "sa";
            final String DB_PASSWORD = "sjk12345";
            GenericDAO genericDAO;
            try {
                try {
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                } catch (ClassNotFoundException e) {
                    throw new RuntimeException(e);
                }
                genericDAO=new GenericDAO(DriverManager.getConnection(DB_URL,DB_USERNAME,DB_PASSWORD));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            //List<student> students = genericDAO.getAll(student.class);
            List<Student> students = null;
            try {
                students = genericDAO.getAll(Student.class);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            for (Student student : students) {
        %>
        <tr>
            <td><%= student.getId() %></td>
            <td><%= student.getName() %></td>
            <td><%= student.getStu_class() %></td>
            <td>
                <button class="edit-button" data-student-id="<%= student.getId() %>">编辑</button>
                <button class="delete-button" data-student-id="<%= student.getId() %>">删除</button>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<a href="../dataImportStu" class="button" >去添加学生</a>
<!-- 编辑学生对话框 -->
<div id="editStudentModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <iframe id="editStudentFrame" src="editStudent.jsp" width="100%" height="500px" frameborder="0"></iframe>
    </div>
</div>

<footer>
    <p>© 2023 作业管理系统. All rights reserved.</p>
</footer>

<script>
    // 弹出编辑学生对话框
    const editButtons = document.querySelectorAll(".edit-button");
    const editStudentModal = document.getElementById("editStudentModal");
    const editStudentFrame = document.getElementById("editStudentFrame");
    const closeModalButton = document.querySelector(".close");

    editButtons.forEach(button => {
        button.addEventListener("click", function () {
            const studentId = this.getAttribute("data-student-id");
            const editStudentUrl = `editStudent.jsp?id=`+studentId;
            editStudentFrame.setAttribute("src", editStudentUrl);
            editStudentModal.style.display = "block";
        });
    });

    // 关闭编辑学生对话框
    closeModalButton.addEventListener("click", function () {
        editStudentModal.style.display = "none";
        window.location.reload();
    });

    // 删除学生按钮点击事件
    const deleteButtons = document.querySelectorAll(".delete-button");

    deleteButtons.forEach(button => {
        button.addEventListener("click", function () {
            const studentId = this.getAttribute("data-student-id");
            const confirmDelete = confirm("确定要删除该学生吗？");

            if (confirmDelete) {
                // 跳转到 Servlet 进行删除操作
                window.location.href = `../../ManageServlet?action=delete&page=Student&id=` + studentId;
            <%
//            String id= pageContext.getAttribute("data-student-id").toString();
//            System.out.println("delete:student"+id);
//            student student=new student(id);
//            session.setAttribute("student",student);
            %>
            }
        });
    });

    // 刷新主窗口的函数
    function refreshParentWindow() {
        window.location.reload(); // 刷新当前页面
    }
</script>

</body>
</html>
