<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>导入题库</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script>

    </script>
</head>
<body>
<div class="container">
    <h1>导入数据</h1>
    <form action="${pageContext.request.contextPath}/dataImportServlet" method="post">
        <label>
            <textarea id="data" name="data" rows="10" cols="50" placeholder="粘贴要导入的数据"></textarea>
        </label>
        <br>
        <input type="hidden" id="data-type" name="data-type" value="Question">
        <label id="data-format">导入的题目样例(不需要题号): <br>Java是什么样的语言?()#A.面向对象 B.面向过程 C.面向时间 D.面向地点#A  <br>每个题目一行:题目#选项#答案</label>
        <input type="submit" value="导入数据">
    </form>
</div>
</body>
</html>