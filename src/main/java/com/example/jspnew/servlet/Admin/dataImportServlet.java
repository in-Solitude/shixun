package com.example.jspnew.servlet.Admin;

import com.example.jspnew.javabean.GenericDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ngw.part.student.Student;
import zyy.Part.Teacher.QuestionBank;
import zyy.Part.Teacher.Teacher;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Arrays;

@WebServlet(name = "dataImport", value = "/dataImportServlet")
public class dataImportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type=request.getParameter("data-type");
        String data=request.getParameter("data");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        // String date2=request.getParameter("date2");
        GenericDAO genericDAO;
        try {
            genericDAO=new GenericDAO();
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }

        String tmp;
        String[] dataCut=data.split("\n");//先分割行
        System.out.println("dataCut"+Arrays.toString(dataCut));
        for (String tmp1:dataCut) {
            String[] info=tmp1.split("[\\s,]+");//一行一条数据分割,仅限于导入老师和学生数据
            if (type.equals("teacher")){//处理导入教师
                Teacher teacher=new Teacher();
                teacher.setId(info[0]);
                teacher.setName(info[1]);
                teacher.setCollege(info[2]);
                try {
                    genericDAO.insert(teacher);
                } catch (SQLException e) {
                    response.setContentType("text/html;charset=UTF-8");
                    //PrintWriter out = response.getWriter();
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>提示信息</title>");
                    out.println("<meta http-equiv='refresh' content='3;url="+request.getHeader("referer")+"'>"); // 3秒后跳转到 nextpage.jsp
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<h1>导入失败</h1>");
                    out.println("<p>请检查数据,正在跳转到上一个页面...</p>");
                    out.println("</body>");
                    out.println("</html>");
                    throw new RuntimeException(e);
                }
                response.setContentType("text/html;charset=UTF-8");
               // PrintWriter out = response.getWriter();
                out.println("导入成功");
            }//处理导入教师结束
            else if ("student".equals(type)){//处理导入学生
                Student student=new Student();
                student.setId(info[0]);
                student.setName(info[1]);
                student.setStu_class(info[2]);
                try {
                    genericDAO.insert(student);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }//导入学生结束
            else if ("Question".equals(type)){//导入题库
                System.out.println("tmp1"+tmp1);
                String[] qst=tmp1.split("#");
                System.out.println("qst"+Arrays.toString(qst));
                String[] options=qst[1].split(" ");
                System.out.println("option:"+ Arrays.toString(options));
                QuestionBank question= new QuestionBank();
                question.setQuestion_text(qst[0]);
                question.setOption1(options[0]);
                question.setOption2(options[1]);
                question.setOption3(options[2]);
                question.setOption4(options[3]);
                question.setCorrect_option(qst[2]);
                //question.setQuestion_id(null);
                int i=0;

                try {
                    i=genericDAO.getAll(QuestionBank.class).size();
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                i++;
                System.out.println("i:"+i);
                question.setId(i);
                System.out.println("QST_ID"+question.getId());
                try {
                    genericDAO.insertWithAutoIncrement(question);
                    out.println("导入成功");
                } catch (SQLException e) {
                    //out.println("导入失败,请检查数据");
                    //System.out.println(e);
                    throw new RuntimeException(e);
                }
            }
        }

    }
}
