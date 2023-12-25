<%@ page import="zyy.Part.Teacher.QuestionBank" %>
<%@ page import="com.example.jspnew.javabean.GenericDAO" %>
<%@ page import="zyy.Part.Teacher.ExamPaper" %>
<%@ page import="java.util.List" %>
<%@ page import="ngw.part.student.Student" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sun.tools.attach.AgentInitializationException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>作业页面</title>
    <link rel="stylesheet" type="text/css" href="examPaperstyles.css">
</head>
<body>
<h1>作业页面</h1>

<form action="submitExam.jsp" method="post" onsubmit="jspx()">
<%!
    List<QuestionBank> questions = new ArrayList<>();
%>
    <%-- 查询数据库获取试题列表 --%>
    <%
        // 计分器初始化
        int totalScore = 0;
        int question_number = 0;
        GenericDAO genericDAO;//qwe
        try {
             genericDAO=  new GenericDAO();
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
         Student student= (Student) session.getAttribute("Student");
        String examId=request.getParameter("examId");

        ExamPaper examPaper= null;
        try {
            examPaper = genericDAO.getById(ExamPaper.class,examId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("examPaper",examPaper);
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
            String sql = "SELECT question_ids FROM ExamPaper WHERE paper_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, examPaper.getPaper_id());
            rs = pstmt.executeQuery();

            List<Integer> questionIds = new ArrayList<>();
            if (rs.next()) {
                String questionIdsString = rs.getString("question_ids");
                String[] questionIdsArray = questionIdsString.split(" ");
                for (String questionId : questionIdsArray) {
                    questionIds.add(Integer.parseInt(questionId));
                }
            }


            StringBuilder questionIdsBuilder = new StringBuilder();
            for (int i = 0; i < questionIds.size(); i++) {
                if (i > 0) {
                    questionIdsBuilder.append(",");
                }
                questionIdsBuilder.append(questionIds.get(i));
            }
            String questionIdsString = examPaper.getQuestion_ids();
            questionIdsString=questionIdsString.replaceAll(" ",",");
            questionIdsString=questionIdsString.substring(0,questionIdsString.length()-1);
            System.out.println(questionIdsString);
            String query = "SELECT id, question_text, option1, option2, option3, option4, correct_option FROM QuestionBank WHERE id IN (" + questionIdsString + ")";
            PreparedStatement statement = conn.prepareStatement(query);

            // 执行查询
            ResultSet resultSet = statement.executeQuery();

            // 处理结果
            while (resultSet.next()) {
                int questionId = resultSet.getInt("id");
                String questionText = resultSet.getString("question_text");
                String optionA = resultSet.getString("option1");
                String optionB = resultSet.getString("option2");
                String optionC = resultSet.getString("option3");
                String optionD = resultSet.getString("option4");
                String correct_option = resultSet.getString("correct_option");

                // 创建 QuestionBank 对象并添加到列表中
                QuestionBank question = new QuestionBank(questionId, questionText, optionA, optionB, optionC, optionD,correct_option);
                questions.add(question);
            }
        // 连接数据库并执行查询语句，获取试题列表questions

            session.setAttribute("questions",questions);
        // 遍历试题列表
        for (QuestionBank question : questions) {
            question_number += 1;
            // 获取试题相关信息，如试题文本、选项和正确选项

            // 显示题目
    %>
    <div class="question">
        <p><%= question.getQuestion_text() %></p>
        <ul>
            <li>
                <label>
                    <input type="radio" name="<%= question.getQuestion_text() %>" value="<%= question.getOption1() %>">
                    <%= question.getOption1() %>
                </label>
            </li>
            <li>
                <label>
                    <input type="radio" name="<%= question.getQuestion_text() %>" value="<%= question.getOption2() %>">
                    <%= question.getOption2() %>
                </label>
            </li>
            <li>
                <label>
                    <input type="radio" name="<%= question.getQuestion_text() %>" value="<%= question.getOption3() %>">
                    <%= question.getOption3() %>
                </label>
            </li>
            <li>
                <label>
                    <input type="radio" name="<%= question.getQuestion_text() %>" value="<%= question.getOption4() %>">
                    <%= question.getOption4() %>
                </label>
            </li>
        </ul>
    </div>

    <%-- 计分 --%>
    <%
        // 获取用户选择的答案
        String userAnswer = request.getParameter(question.getQuestion_text());
        String[] Ans=request.getParameterValues(question.getQuestion_text());
        System.out.println("ANS"+Ans);
        System.out.println("userANS"+userAnswer);


        // 判断用户答案是否正确
        if (userAnswer != null && userAnswer.equals(question.getCorrect_option())) {
            totalScore += 1;
        }
    %>
    <% }
//        System.out.println(question_number);
//        totalScore = totalScore * 100/question_number;
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
    }%>

    <!-- 将总分隐藏在隐藏字段中，以便在 "submitExam.jsp" 中使用 -->
    <input type="hidden" name="totalScore" value="<%= totalScore %>">
    <input type="hidden" name="id" value="<%= student.getId() %>">
    <input type="hidden" name="question_number" value="<%= question_number%>">

    <button type="submit">提交作业</button>
</form>
<script>
    function jspx() {

    }

</script>
</body>
</html>