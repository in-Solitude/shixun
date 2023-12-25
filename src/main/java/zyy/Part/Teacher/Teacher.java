package zyy.Part.Teacher;

public class Teacher {
    String id;
    String password;
    String name;

    public Teacher(String id) {
        this.id=id;
    }

    public String getCollege() {
        return college;
    }//qwe

    public void setCollege(String college) {
        this.college = college;
    }

    String college;

    public Teacher(String id, String name,String password) {
        this.id = id;
        this.password = password;
        this.name = name;
    }
    public Teacher(){

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
