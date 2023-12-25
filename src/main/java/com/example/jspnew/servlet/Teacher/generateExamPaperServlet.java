package com.example.jspnew.servlet.Teacher;

import com.example.jspnew.javabean.GenericDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import zyy.Part.Teacher.ExamPaper;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

@WebServlet(name = "generateExamPaperServlet", value = "/generateExamPaperServlet")
public class generateExamPaperServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] questionId= request.getParameterValues("selectedQuestions");
        String paper_name=request.getParameter("paper_name");
        //String paper_id=request.getParameter("paper_id");
        System.out.println(Arrays.toString(questionId));
        GenericDAO genericDAO;
        try {
             genericDAO =new GenericDAO();
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        ExamPaper examPaper=new ExamPaper();
        java.util.Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
        String id=dateFormat.format(currentDate);
        examPaper.setPaper_id(id); //设置id
        examPaper.setPaper_name(paper_name);
        StringBuilder stringBuilder=new StringBuilder();
        for (String tmp:
             questionId) {
            stringBuilder.append(tmp).append(" ");
        }
        examPaper.setQuestion_ids(stringBuilder.toString());
        System.out.println(stringBuilder.toString());
        PrintWriter out=response.getWriter();

        try {
            genericDAO.insert(examPaper);
            out.println("生成成功");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }
}
