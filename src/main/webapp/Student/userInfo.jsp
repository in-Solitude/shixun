<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="ngw.part.student.Student" %>
<!DOCTYPE html>
<%

        Student student= (Student) session.getAttribute("Student");
    System.out.println(student.getId());
        String username = student.getName();
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

            // 查询该用户的个人信息
            String sql = "SELECT * FROM student WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, student.getId());//qwe
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String id = rs.getString("id");
                String name = rs.getString("name");
                String gender = rs.getString("gender");
                String age = rs.getString("age");
                String grade = rs.getString("grade");
                String stu_class = rs.getString("stu_class");
                String major = rs.getString("major");

%>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人信息管理</title>
    <link rel="stylesheet" href="userInfoStyle.css">

</head>
<body>
<h1>个人信息管理</h1>

<form action="${pageContext.request.contextPath}/ManageServlet" method="post">
    <%
        if (session.getAttribute("tip")!=null) {
            String tip = session.getAttribute("tip").toString();
            if (tip.equals("修改成功")) {
                out.print("<p style=\"color: red;\">修改成功。</p>");
                tip = "empty";
                session.removeAttribute("tip");
            } else {

            }
        }
    %>
    <p>
        <label for="name">姓名:</label>
        <input type="text" id="name" name="name" value="<%= name %>" />
    </p>
    <p>
        <label for="id">学号:</label>
        <input type="text" id="id" name="id" value="<%= id %>" />
    </p>
    <p>
        <label for="male">性别:</label>
        <input type="radio" id="male" name="gender" value="男" <% if (gender.equals("男")) { %>checked<% } %> />男
        <input type="radio" id="female" name="gender" value="女" <% if (gender.equals("女")) { %>checked<% } %> />女
        <input type="hidden" id="page" name="page" value="Student">
        <input type="hidden" id="action" name="action" value="edit">
     </p>

    <p>
        <label for="age">年龄:</label>
        <input type="text" id="age" name="age" value="<%= age %>" />
    </p>
    <p>
        <label for="grade">年级:</label>
        <input type="text" id="grade" name="grade" value="<%= grade %>" readonly />
    </p>
    <p>
        <label for="stu_class">班级:</label>
        <input type = "text" id="stu_class" name="stu_class" value="<%= stu_class %>" />
    </p>
    <p>
        <label for="major">班级:</label>
        <input type = "text" id="major" name="major" value="<%= major %>" />
    </p>
    <p>
        <input type="submit" value="提交" />
        <input type="reset" value="重置" />
    </p>
</form>
</body>
</html>
<%
            }
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