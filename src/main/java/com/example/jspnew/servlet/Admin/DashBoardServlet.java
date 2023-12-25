package com.example.jspnew.servlet.Admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "DashBoardServlet", value = "/DashBoardServlet")
public class DashBoardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action=request.getParameter("action");
        String type=request.getParameter("type");//根据要进行操作的对象和操作类型判断将要跳转的页面qwe
        String targetUrl= type+action;

    }
}
