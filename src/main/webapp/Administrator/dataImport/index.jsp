<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>导入数据</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script>
        function showDataFormat() {
            var dataType = document.getElementById("data-type").value;
            var formatLabel = document.getElementById("data-format");

            if (dataType === "teacher") {
                formatLabel.textContent = "老师数据的格式：工号, 姓名, 学院 ,以逗号或空格分割,每条数据一行";
            } else if (dataType === "student") {
                formatLabel.textContent = "学生数据的格式：学号, 姓名, 班级 ,以逗号或空格分割,每条数据一行";
            } else {
                formatLabel.textContent = "";
            }
        }//qwe
    </script>
</head>
<body>
<div class="container">
    <h1>导入数据</h1>
    <form action="${pageContext.request.contextPath}/dataImportServlet" method="post">

        导入类型<label for="data-type"></label><select name="data-type" id="data-type" onchange="showDataFormat()">
            <option value="teacher">老师</option>
            <option value="student">学生</option>
        </select>
        <label>
            <textarea id="data" name="data" rows="10" cols="50" placeholder="粘贴要导入的数据"></textarea>
        </label>
        <br>
        <label id="data-format">老师数据的格式：工号, 姓名, 学院 ,以逗号或空格分割,每条数据一行</label>
        <input type="submit" value="导入数据">
    </form>
</div>
</body>
</html>