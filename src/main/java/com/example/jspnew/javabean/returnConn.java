package com.example.jspnew.javabean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class returnConn {
    private static final String DB_URL = "jdbc:sqlserver://localhost:3066;databaseName=TestSystem;trustServerCertificate=true";
    private static final String DB_USERNAME = "sa";
    private static final String DB_PASSWORD = "sjk12345";
    public static Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        returnConn.connection = connection;
    }


    static Connection connection ;
    public returnConn() throws SQLException, ClassNotFoundException {

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        connection = DriverManager.getConnection(DB_URL,DB_USERNAME,DB_PASSWORD);
        System.out.println("正常连接数据库");//qwe
    }

}
