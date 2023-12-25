<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
  <title>教师登录</title>
  <link rel="stylesheet" type="text/css" href="LoginStyle.css">
</head>
<body>
<div class="container">
  <h1>教师登录</h1>
  <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
    <label>
      <input type="text" placeholder="用户名" required name="id">
    </label>
    <label>
      <input type="password" placeholder="密码" required name="pwd">
    </label>
    <input type="hidden" name="action" value="Teacher">
    <button type="submit">登录</button>
  </form>
</div>
</body>
</html>
