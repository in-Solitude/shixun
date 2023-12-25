package com.example.jspnew.javabean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DB_Operator {
    private static final String DB_URL = "jdbc:sqlserver://localhost:3066;databaseName=TestSystem;trustServerCertificate=true";
    private static final String DB_USERNAME = "sa";
    private static final String DB_PASSWORD = "sjk12345";

    public String getIP() {
        return IP;
    }

    public void setIP(String IP) {
        this.IP = IP;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    private String IP = "";
    private String action;
    private String type;


//    private final String[] sqlStm = {
//            "INSERT INTO Admin_Logs (id, name, ip, date, status) VALUES (?, ? , ? , ? , ?)",
//            "INSERT INTO Teacher_Logs (id, name, ip, date, status) VALUES (?, ? , ? , ? , ?)",
//            "INSERT INTO Student_Logs (id, name, ip, date, status) VALUES (?, ? , ? , ? , ?)"};

    public DB_Operator(String action,String type) {
        this.action=action;
        this.type=type;
        switch (action){
            case "writeLog"->{

            }
        }
    }


    /*private boolean WriteLog(String type,String name,String ip, String status) {//true为登录,type为用户类型
        Validate validate = new Validate(type);
        int typeNum=validate.getProfessionNum();
        String sql =  "INSERT INTO login_and_logout_Logs ( date, type, name,ip, status) VALUES (?, ? , ? , ? , ?)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {

            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, date);
            statement.setString(2, type);
            statement.setString(3, name);
            statement.setString(4, ip);
            statement.setString(5, status);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0; // 如果有行受到影响，则写入成功

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }*/
    private boolean writeLog(){
        // 获取当前时间

        String time=getCurrentTime();
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {

            String sql = "INSERT INTO login_and_logout_log (login_time,type,name,ip,status) VALUES (?,?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            PreparedStatement insertLoginLogStmt = conn.prepareStatement(sql);
            insertLoginLogStmt.setString(1, time);  // adminId 为管理员的 ID
            insertLoginLogStmt.setString(2,type);
            //insertLoginLogStmt.setString();
            insertLoginLogStmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }
    private String getCurrentTime(){
        java.util.Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
        return dateFormat.format(currentDate);
    }
}
