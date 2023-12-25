package zyy.Part.Teacher;

public class QuestionBank {


    public QuestionBank() {

    }

    public int getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }//qwe
    public void setId(int question_id) {
        this.id = question_id;
    }
    public void setId(long question_id) {
        this.id = (int) question_id;
    }

    private int id;
    private String question_text;
    private String option1;
    private String option2;
    private String option3;
    private String option4;
    private String correct_option;
    private String question;

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public QuestionBank(int question_id, String question_text, String option1, String option2, String option3, String option4, String correct_option) {
        this.id = question_id;
        this.question_text = question_text;
        this.option1 = option1;
        this.option2 = option2;
        this.option3 = option3;
        this.option4 = option4;
        this.correct_option = correct_option;
    }

    public String getCorrect_option() {
        return correct_option;
    }

    public void setCorrect_option(String correct_option) {
        this.correct_option = correct_option;
    }

    public String getOption1() {
        return option1;
    }

    public String getOption4() {
        return option4;
    }

    public void setOption4(String option4) {
        this.option4 = option4;
    }

    public String getOption3() {
        return option3;
    }

    public void setOption3(String option3) {
        this.option3 = option3;
    }

    public String getOption2() {
        return option2;
    }

    public void setOption2(String option2) {
        this.option2 = option2;
    }

    public void setOption1(String option1) {
        this.option1 = option1;
    }

    public String getQuestion_text() {
        return question_text;
    }

    public void setQuestion_text(String question_text) {
        this.question_text = question_text;
    }
    public String AllOptions(){
        return option1+" "+option2+" "+option3+" "+option4;
    }


}
