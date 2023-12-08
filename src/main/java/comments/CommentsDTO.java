package comments;

public class CommentsDTO {
    private int anno_board_num;
    private int Turn;
    private String content;

    public int getanno_board_num() {
        return anno_board_num;
    }

    public void setanno_board_num(int anno_board_num) {
        this.anno_board_num = anno_board_num;
    }

    public int getTurn() {
        return Turn;
    }

    public void setTurn(int Turn) {
        this.Turn = Turn;
    }

    public String getcontent() {
        return content;
    }

    public void setcontent(String content) {
        this.content = content;
    }
}