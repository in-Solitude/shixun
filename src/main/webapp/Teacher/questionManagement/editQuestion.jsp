<%@ page import="com.example.jspnew.javabean.GenericDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="zyy.Part.Teacher.Teacher" %>
<%@ page import="java.util.List" %>
<%@ page import="zyy.Part.Teacher.QuestionBank" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>编辑题目</title>
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
        return;
    }
    int id= Integer.parseInt(request.getParameter("id"));
    GenericDAO genericDAO;
    try {
        genericDAO= new GenericDAO();
    } catch (ClassNotFoundException | SQLException e) {
        throw new RuntimeException(e);
    }
    List<QuestionBank> questionBanks =null;
    try {//qwe
        questionBanks=genericDAO.getAll(QuestionBank.class);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    QuestionBank questionBank=new QuestionBank();
    for (QuestionBank it : questionBanks) {
        if (it.getId()==id){
            questionBank=it;
            break;
        }
    }
    session.setAttribute("questionBank",questionBank);
    System.out.println(request.getContextPath());//为什么下面表单的action直接写servlet找不到?
%>
<div class="container">
    <h2>编辑题目信息</h2>

    <form action="${pageContext.request.contextPath}/ManageServlet?action=edit" method="post" onsubmit=" closeWindowAndRefreshParent()">
        <div class="form-group">
            <label for="id">题目:</label>
            <input type="number" id="id" name="id" value="<%= questionBank.getId() %>" disabled>
        </div>

        <div class="form-group">
            <label for="A">选项A:</label>
            <input type="text" id="A" name="A" value="<%= questionBank.getOption1() %>" required>
        </div>
        <div class="form-group">
            <label for="B">选项B:</label>
            <input type="text" id="B" name="B" value="<%= questionBank.getOption2() %>" required>
        </div>
        <div class="form-group">
            <label for="C">选项C:</label>
            <input type="text" id="C" name="C" value="<%= questionBank.getOption3() %>" required>
        </div>
        <div class="form-group">
            <label for="D">选项D:</label>
            <input type="text" id="D" name="D" value="<%= questionBank.getOption4() %>" required>
        </div>

        <div class="form-group">
            <label for="college">答案:</label>
            <input type="text" id="college" name="college" value="<%= questionBank.getCorrect_option() %>" required>
        </div>

        <div class="form-group">
            <input type="hidden" id="page" name="page" value="Teacher" required>
        </div>

        <div class="form-group">
            <button type="submit">保存</button>
        </div>
    </form>
</div>

</body>
</html>
