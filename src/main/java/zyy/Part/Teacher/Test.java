package zyy.Part.Teacher;

import com.example.jspnew.javabean.GenericDAO;
import ngw.part.student.Student;

import java.sql.SQLException;

public class Test {
    private static final String DB_URL = "jdbc:sqlserver://localhost:3066;databaseName=TestSystem;trustServerCertificate=true";
    private static final String DB_USERNAME = "sa";
    private static final String DB_PASSWORD = "sjk12345";

    public Test(){

    }
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        Student t= new Student();
        t.setName("test11");
        t.setId("12345");
        GenericDAO dao=new GenericDAO();
        dao.insert(t);
    }

}
