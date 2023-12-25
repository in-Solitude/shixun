package com.example.jspnew.servlet.Admin;

import com.example.jspnew.javabean.GenericDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ngw.part.student.Student;
import zyy.Part.Teacher.QuestionBank;
import zyy.Part.Teacher.Teacher;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "ManageServlet", value = "/ManageServlet")
public class ManageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String URI;
        response.setContentType("text/html;charset=UTF-8");
        URI=request.getParameter("page");
        HttpSession session= request.getSession();
        System.out.println("ManageServlet");
        if ("Teacher".equals(URI)){//处理教师
            System.out.println("teacherInto");
            Teacher teacher= (Teacher) session.getAttribute("teacher");//id不应该允许被更改,是pkqwe
            if(session.getAttribute("teacher")==null || session.getAttribute("teacher")=="null"){
                teacher= new Teacher(request.getParameter("id"));
            }
            String name=request.getParameter("name");
            String college=request.getParameter("college");
            GenericDAO genericDAO;

            String action=request.getParameter("action");
            System.out.println(action);
            try {
                genericDAO=new GenericDAO();
                System.out.println("连接成功");
            } catch (ClassNotFoundException | SQLException e) {
                throw new RuntimeException(e);
            }
            if(action.equals("edit")){//处理 编辑教师
                System.out.println("edit");
                try {//先获取全部,再update
                    teacher.setName(name);
                    teacher.setCollege(college);
                    genericDAO.update(teacher);
                    response.sendRedirect("Administrator/teacherManagement/successPage.jsp");
                } catch (SQLException e) {
                    out.println("编辑失败,请检查数据");
                    throw new RuntimeException(e);
                }

            }//编辑教师结束
            else if (action.equals("delete")){//处理删除教师
                String id=request.getParameter("id");
                System.out.println("teacher:delete"+id);
                try {
                    teacher.setId(id);
                    genericDAO.delete(teacher);
                    out.println("删除成功");
                } catch (SQLException e) {
                    out.println("删除失败");
                    throw new RuntimeException(e);

                }
            }//删除教师结束

        }//教师部分结束
        else if ("Student".equals(URI)){//处理学生
            //todo 学生处理
            //System.out.println("waimian");
            Student student= (Student) session.getAttribute("Student");//id不应该允许被更改,是pk
            String name=request.getParameter("name");
            String gender=request.getParameter("gender");
            int age= Integer.parseInt(request.getParameter("age"));
            String grade=request.getParameter("grade");
            String stu_class=request.getParameter("stu_class");
            String major=request.getParameter("major");
            GenericDAO genericDAO;

            String action=request.getParameter("action");
            try {
                genericDAO=new GenericDAO();
                System.out.println("连接成功");
            } catch (ClassNotFoundException | SQLException e) {
                throw new RuntimeException(e);
            }
            if(action.equals("edit")){//处理 编辑学生

                try {//先获取全部,再update
                    //System.out.println("ihjhvhjijknuiiuohiouxueshtreedngbv");
                    student.setName(name);
                    student.setGender(gender);
                    student.setAge(age);
                    student.setGrade(grade);
                    student.setStu_class(stu_class);
                    student.setMajor(major);
                    genericDAO.update(student);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                String tip="修改成功";
                session.setAttribute("tip",tip);
                response.sendRedirect("Student/userInfo.jsp");
            }//编辑学生结束
            else if (action.equals("delete")){//处理删除学生
                String id=request.getParameter("id");
                System.out.println("student:delete"+id);
                try {
                    student.setId(id);
                    genericDAO.delete(student);
                    out.println("删除成功");
                } catch (SQLException e) {
                    out.println("删除失败");
                    throw new RuntimeException(e);
                }
            }//删除学生结束
            else if(action.equals("addition")){

            }
            else {
                out.println("无效访问");
            }
        }
        else if("Question".equals(URI)) {//处理题库
            QuestionBank questionBank=new QuestionBank();
            String id=request.getParameter("id");
            GenericDAO genericDAO;
            try {
                genericDAO=new GenericDAO();
            } catch (ClassNotFoundException | SQLException e) {
                throw new RuntimeException(e);
            }
            String action=request.getParameter("action");
            if (action.equals("delete")){//处理删除教师
                System.out.println("question:delete"+id);
                try {
                    questionBank.setId(Integer.parseInt(id));
                    genericDAO.delete(questionBank);
                    out.println("删除成功");
                } catch (SQLException e) {
                    out.println("删除失败");
                    throw new RuntimeException(e);

                }
            }//删除教师结束
        }
    }
}
