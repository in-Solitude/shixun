<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ngw.part.student.Student" %>
<!DOCTYPE html>
<%

    Student student= (Student) session.getAttribute("Student");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
      // 连接数据库
      String url = "jdbc:sqlserver://localhost:3066;databaseName=TestSystem;trustServerCertificate=true";
      String user = "sa";
      String password = "sjk12345";
      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); // 加载SQL Server驱动
      conn = DriverManager.getConnection(url, user, password);

      // 查询该用户的作业列表和成绩
      String sql = "SELECT paper_id, score FROM score WHERE id=?";
      //
      //select paper_name from ExamPaper where id in (select paper_id,score from score where id =?)
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, student.getId());
      rs = pstmt.executeQuery();

      ArrayList<String> examList = new ArrayList<String>();
      ArrayList<Integer> scoreList = new ArrayList<Integer>();
      while (rs.next()) {
        examList.add(rs.getString("paper_id"));
        scoreList.add(rs.getInt("score"));
      }
%>
<html>
<head>
  <meta charset="UTF-8">
  <title>成绩列表</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
    }
    .container {
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
      background-color: #ffffff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h1 {
      text-align: center;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      border: 1px solid #cccccc;
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: #f2f2f2;
      font-weight: bold;
    }
    tr:nth-child(even) {
      background-color: #f9f9f9;
    }
    tr:hover {
      background-color: #e9e9e9;
    }
    .button-container {
      text-align: center;
      margin-top: 20px;
    }
    .button-container a {
      display: inline-block;
      padding: 10px 20px;
      background-color: #51b5e6;
      color: #ffffff;
      text-decoration: none;
      border-radius: 4px;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>成绩列表</h1>

  <table>
    <tr>
      <th>作业科目</th>
      <th>成绩</th>
    </tr>
    <% for(int i = 0; i < examList.size(); i++) { %>
    <tr>
      <td><%= examList.get(i) %></td>
      <td><%= scoreList.get(i) %></td>
    </tr>
    <% } %>
  </table>
  <div class="button-container">
    <a href="personal_info.jsp">返回</a>
  </div>
</div>

</body>
</html>
<%
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