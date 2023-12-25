package com.example.jspnew.servlet;

import com.example.jspnew.javabean.Validate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ngw.part.student.Student;
import zyy.Part.Admin.Admin;
import zyy.Part.Teacher.Teacher;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serial;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

    @WebServlet(name = "LoginServlet", urlPatterns = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:sqlserver://localhost:3066;databaseName=TestSystem;trustServerCertificate=true";
    private static final String DB_USERNAME = "sa";
    private static final String DB_PASSWORD = "sjk12345";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset = UTF-8");
        String action = request.getParameter("action");

//qwe
        if (action != null) {
            Validate validate=new Validate(action);//从action中获取用户类型,决定validate语句所使用的数据库查询语句
            System.out.println("用户登录:"+action);
            String username = request.getParameter("id");
            String password = request.getParameter("pwd");

            if (validate.ValidateUser(username, password)) {
                // 用户验证成功，进行相应的操作
                //response.getWriter().println("登录成功");
                int type=validate.getProfessionNum();
                java.util.Date currentDate = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
                final String USER_IP=getIP(request,response);
                String log="用户"+username+"("+getName(type)+")于"+dateFormat.format(currentDate)+"登录,IP:"+USER_IP;
                System.out.println(log);
                HttpSession httpSession = request.getSession();//由session传递实例,重定向到的页面做读取操作
                switch (type){//判断登录的用户类型
                    case 1->{//Admin
                        Admin admin=new Admin(username);
                        httpSession.setAttribute("Admin",admin);
                        response.sendRedirect(action+"/DashBoard");

                    }case 2->{//Teacher
                        Teacher teacher=new Teacher(username);
                        teacher.setName(validate.USERNAME);
                        System.out.println(validate.USERNAME);
                        httpSession.setAttribute("Teacher",teacher);
                        response.sendRedirect(action+"/DashBoard");
                    }case 3->{//Student
                        //request.setAttribute();

                        Student student=new Student(username);
                        student.setName(validate.USERNAME);
                        System.out.println(validate.USERNAME);
                        httpSession.setAttribute("Student",student);
                        System.out.println("session created successfully");
                        response.sendRedirect(action+"/personal_info.jsp");
//                        dispatcher.forward(request,response);
                    }
                }

            } else {
                // 用户验证失败，显示错误信息
               // response.getWriter().println("登录");
                PrintWriter out = response.getWriter();

                out.println("<html>");
                out.println("<head>");
                out.println("<title>Login Failed</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>登录失败</h1>");
                out.println("<p>账号或密码错误.请重新输入.</p>");
                out.println("<a href=\"" + request.getHeader("referer") + "\">返回登录界面</a>");
                out.println("</body>");
                out.println("</html>");

                out.close();
            }
        }
    }


    private boolean registerUser(String username, String password) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
            String sql = "INSERT INTO users (name, pwd) VALUES (?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0; // 如果有行受到影响，则注册成功

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    private String getName(int type){
        switch (type) {
            case 1 -> {
                return "管理员";
            }
            case 2 -> {
                return "老师";
            }
            case 3 -> {
                return "学生";
            }
        }
        return "wrong type";
    }
    private String getIP(HttpServletRequest request,HttpServletResponse response){
        String ipAddress = request.getHeader("X-Forwarded-For");
        if (ipAddress == null) {
            ipAddress = request.getHeader("Proxy-Client-IP");
        }
        if (ipAddress == null) {
            ipAddress = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ipAddress == null) {
            ipAddress = request.getRemoteAddr();
        }

        return ipAddress;
    }
}
