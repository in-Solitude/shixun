package com.example.jspnew.javabean;

import java.sql.*;

public class Validate {
    private static final String DB_URL = "jdbc:sqlserver://localhost:3066;databaseName=TestSystem;trustServerCertificate=true";
    private static final String DB_USERNAME = "sa";
    private static final String DB_PASSWORD = "sjk12345";
    public String USERNAME;

    public int getProfessionNum() {
        return ProfessionNum;
    }
    private  String Profession;
    private int ProfessionNum;

    public Validate(String Profession){//创建时取得登录用户类型
        this.Profession=Profession;
        ProfessionNum=pro_switch(Profession);
    }
    public Validate(){//创建时取得登录用户类型qwe
    }


    public boolean ValidateUser(String UserName,String Password){
        Connection connection = null;
        PreparedStatement statement=null;
        ResultSet resultSet=null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(DB_URL,DB_USERNAME,DB_PASSWORD);
            System.out.println("正常连接数据库");
        }
        catch(SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        String[] sqlString = new String[5] ;
         sqlString[1] = "SELECT name FROM Administrator WHERE id = ? AND password = ?";
         sqlString[2] = "SELECT name FROM Teacher WHERE id = ? AND password = ?";
         sqlString[3] = "SELECT name FROM Student WHERE id = ? AND password = ?";
        try {

            if (connection != null) {
                statement = connection.prepareStatement(sqlString[ProfessionNum]);

                statement.setString(1, UserName);
                statement.setString(2, Password);
                resultSet = statement.executeQuery();
            }
            if (resultSet != null&& resultSet.next()) {
               USERNAME= resultSet.getString(1);
                //System.out.println("col=0:"+resultSet.getString(0));
                System.out.println("col=1:"+resultSet.getString(1));
                return USERNAME!=null&& !USERNAME.equals("null"); // 如果存在匹配的用户记录，则验证成功
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    public int pro_switch(String Prof){
        int re=0;
        switch (Prof) {
            case "Student" -> {
                re= 3;
            }
            case "Teacher" -> {
                re= 2;
            }
            case "Administrator" -> {
                re= 1;
            }
        }
        return re;
    }
}
