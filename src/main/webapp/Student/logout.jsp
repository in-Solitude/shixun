<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session.invalidate(); // 用户退出，清除session
    response.sendRedirect("Login.jsp"); // 跳转到登录页面
%>