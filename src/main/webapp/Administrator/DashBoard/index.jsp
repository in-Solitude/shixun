<%@ page import="zyy.Part.Admin.Admin" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: SakuraKoujin
  Time:2023/6/14  16:02
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" %>--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <title>管理员页面</title>
      <link rel="stylesheet" type="text/css" href="DashBoardStyle.css"> <!-- 引入CSS文件 -->
    </head>
    <body>
    <header>
      <h1>作业管理系统 - 管理员页面</h1>
    </header>
    <h2>概述</h2>
    <%
      Admin admin= (Admin) session.getAttribute("Admin");

      if(admin!=null&&admin.getId() !=null){
        System.out.println(admin.getId());
        out.print("<h3>管理员登录成功.  欢迎你,"+admin.getId()+"</h3>");
        Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
        out.print("<p>现在是"+dateFormat.format(currentDate)+"</p>");
      }
      else {
        //out.print("非法访问!");
        response.sendRedirect("Login.jsp");
      }
    %>
    <nav>
      <ul>
        <li><a href="../teacherManagement" class="button">教师管理</a></li>
        <li><a href="../studentManagement" class="button">学生管理</a></li>
        <li><a href="../dataImport" class="button">导入数据</a></li>
        <li><a href="../loginLogs" class="button">登录日志</a></li>
      </ul>
    </nav>

    </body>
    <footer>
        <p>&copy; 2023 Admin Dashboard. All rights reserved.</p>
    </footer>
    </html>
