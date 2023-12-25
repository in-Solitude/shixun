<%--
  Created by IntelliJ IDEA.
  User: SakuraKoujin
  Time:2023/7/4  22:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>提示消息</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      background-color: #f2f2f2;
    }

    #message-container {
      background-color: #f2f2f2;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      text-align: center;
    }

    #message {
      margin: 0;
      color: #333;
      font-weight: bold;
    }
  </style>
  <script>
    // 设置一定时间后自动关闭窗口
    setTimeout(function () {
      window.close();
    }, 3000); // 3秒后关闭窗口
  </script>
</head>
<body>
<div id="message-container">
  <p id="message">修改成功</p>
</div>
</body>
</html>
