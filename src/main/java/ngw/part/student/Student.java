package ngw.part.student;

public class Student {
    private String id;
    private String name;

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    private int age;
    private String grade;
    private String gender;
    private String major;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getStu_class() {
        return stu_class;
    }

    public void setStu_class(String stu_class) {
        this.stu_class = stu_class;
    }

    private String stu_class;



    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Student(String id){
        this.id=id;
    }
    public Student(){

    }
}
