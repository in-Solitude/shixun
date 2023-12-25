<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="ngw.part.student.Student" %>
<%@ page import="zyy.Part.Teacher.ExamPaper" %>
<%@ page import="zyy.Part.Teacher.QuestionBank" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <title>提交作业</title>
    <link rel="stylesheet" type="text/css" href="submitExamstyles.css">
</head>
<body>
<h1>提交作业</h1>

<%
    int totalScore = Integer.parseInt(request.getParameter("totalScore"));
    int question_number = Integer.parseInt(request.getParameter("question_number"));


    List<QuestionBank> questions = new ArrayList<>();
     questions= (List<QuestionBank>) session.getAttribute("questions");
    for (QuestionBank question : questions) {

        // 获取用户选择的答案
        String userAnswer = request.getParameter(question.getQuestion_text());
        userAnswer=userAnswer.substring(0,1);
        String[] Ans=request.getParameterValues(question.getQuestion_text());
        System.out.println("ANS"+Ans);
        System.out.println("userANS"+userAnswer);


        // 判断用户答案是否正确
        if (userAnswer != null && userAnswer.equals(question.getCorrect_option())) {
            totalScore += 1;
        }
    }
    totalScore = totalScore * 100/question_number;
    Student student= (Student) session.getAttribute("Student");

    // 获取总分


    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        String url = "jdbc:sqlserver://localhost:3066;databaseName=TestSystem;trustServerCertificate=true";
        String user = "sa";
        String password = "sjk12345";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); // 加载SQL Server驱动
        conn = DriverManager.getConnection(url, user, password);// 获取数据库连接

        // 获取当前登录用户的信息
        String studentId = request.getParameter("id");// 从提交的表单中获取学生 ID
        ExamPaper examPaper = (ExamPaper) session.getAttribute("examPaper");
        String paper_Id = examPaper.getPaper_id();
        //String paper_Id = request.getParameter("paper_id");

        // 将作业成绩插入到数据库中的 score 表中
        String insertScoreQuery = "INSERT INTO score (paper_id, id, score) VALUES (?, ?, ?)";
        PreparedStatement insertScoreStmt = conn.prepareStatement(insertScoreQuery);
        insertScoreStmt.setString(1, paper_Id);
        insertScoreStmt.setString(2, studentId);
        insertScoreStmt.setInt(3, totalScore);
        insertScoreStmt.executeUpdate();



        // 显示提交成功信息
%>
<div class="container">
    <p>作业提交成功！</p>
    <p>你的作业成绩为：<span class="score"><%= totalScore %></span> 分</p>
</div>
<div class="button-container">
    <a href="personal_info.jsp">返回</a>
</div>
<%
} catch (Exception e) {
    // 处理数据库操作异常
    e.printStackTrace();

    // 显示提交失败信息
%>
<div class="message">
    <p>作业提交失败，请重试。</p>
</div>
<%
    }finally {
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

</body>
</html>
