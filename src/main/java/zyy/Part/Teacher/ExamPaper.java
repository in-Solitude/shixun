package zyy.Part.Teacher;

public class ExamPaper {
    private String paper_id;
    private String paper_name;
    private String question_ids;

    public  String getPaper_id() {
        return paper_id;
    }

    public void setPaper_id(String paper_id) {
        this.paper_id = paper_id;
    }

    public String getPaper_name() {
        return paper_name;
    }
    //qwe
    public void setPaper_name(String paper_name) {
        this.paper_name = paper_name;
    }

    public String getQuestion_ids() {
        return question_ids;
    }

    public void setQuestion_ids(String question_ids) {
        this.question_ids = question_ids;
    }

    public int getTotal_score() {
        return total_score;
    }

    public void setTotal_score(int total_score) {
        this.total_score = total_score;
    }

    private int total_score=100;
}
