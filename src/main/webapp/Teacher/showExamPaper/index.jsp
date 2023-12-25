<%@ page import="zyy.Part.Teacher.ExamPaper" %>
<%@ page import="com.example.jspnew.javabean.GenericDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="zyy.Part.Teacher.QuestionBank" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: SakuraKoujin
  Time:2023/7/6  8:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>作业展示</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
      padding: 20px;
    }

    .container {
      max-width: 800px;
      margin: 0 auto;
    }

    h1 {
      text-align: center;
      color: #333;
    }

    .question {
      margin-bottom: 20px;
      padding: 10px;
      background-color: #fff;
      border-radius: 5px;
    }

    .question-title {
      font-weight: bold;
    }

    .options {
      margin-top: 10px;
    }

    .option {
      margin-bottom: 5px;
    }

    .option-label {
      display: inline-block;
      margin-right: 10px;
    }
  </style>
</head>
<body>
<div class="container">


  <%-- 使用循环显示作业题目 --%>
  <%
    int qSe=1;
    GenericDAO genericDAO;
    try {
      genericDAO=new GenericDAO();
    } catch (ClassNotFoundException | SQLException e) {
      throw new RuntimeException(e);
    }
    String id= (request.getParameter("id"));
    System.out.println(id);//qwe
    ExamPaper examPaper=new ExamPaper();
    examPaper.setPaper_id(id);
    PreparedStatement statement=null;
    ResultSet resultSet=null;
    String sql="SELECT * from ExamPaper WHERE paper_id=?";
    try {
      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
      Connection connection = genericDAO.getConnection();
      statement=connection.prepareStatement(sql);
      statement.setString(1,id);
      resultSet = statement.executeQuery();
      if (resultSet != null&& resultSet.next()) {
        examPaper.setPaper_name(resultSet.getString("paper_name"));
        examPaper.setQuestion_ids(resultSet.getString("question_ids"));
      }
    } catch (Exception e) {
      throw new RuntimeException(e);
    }

    String[] tmp=examPaper.getQuestion_ids().split(" ");
    int[] QIds = new int[tmp.length+10];
    for (int i=0;i<tmp.length;i++){
      QIds[i]=Integer.parseInt(tmp[i]);
    }

    List<QuestionBank> Question;
    try {
      Question=genericDAO.getAll(QuestionBank.class);
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }%>
    <h1><%=examPaper.getPaper_name()%></h1>
    <%  for (QuestionBank question : Question) {
      for (int i:
           QIds) {
        if(i==question.getId()){

  %>

  <div class="question">
    <div class="question-title"><%=qSe++%><%= question.getQuestion_text() %></div>

    <div class="options">
      <%-- 使用循环显示选项 --%>
      <div class="option">
        <label class="option-label"><input type="radio" name="question_<%= question.getId() %>"> <%=question.getOption1()%></label>
      </div>
        <div class="option">
          <label class="option-label"><input type="radio" name="question_<%= question.getId() %>"> <%=question.getOption2()%></label>
        </div>
        <div class="option">
          <label class="option-label"><input type="radio" name="question_<%= question.getId() %>"> <%=question.getOption3()%></label>
        </div>
        <div class="option">
          <label class="option-label"><input type="radio" name="question_<%= question.getId() %>"> <%=question.getOption4()%></label>
        </div>
      <% } %>
    </div>
  </div>
  <% } }%>
</div>
</body>
</html>
