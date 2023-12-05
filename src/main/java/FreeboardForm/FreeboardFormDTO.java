package FreeboardForm;

import java.sql.Date;

public class FreeboardFormDTO {
	private int anno_board_num;
	private int board_pass;
	private String title;
	private String content;
	private Date post_date;
	private int visitcount;
	
	public int getanno_board_num() {
		return anno_board_num;
	}
	public void setanno_board_num(int anno_board_num) {
		this.anno_board_num=anno_board_num;
	}
	
	public int getboard_pass() {
		return board_pass;
	}
	public void setboard_pass(int board_pass) {
		this.board_pass=board_pass;
	}

	public String gettitle() {
		return title;
	}
	public void settitle(String title) {
		this.title=title;
	}

	public String getcontent(){
		return content;
	}
	public void setcontent(String content) {
		this.content=content;
	}

	public Date getpost_date() {
		return post_date;
	}
	public void setpost_date(Date post_date) {
		this.post_date=post_date;
	}

	public int getvisitcount() {
		return visitcount;
	}
	public void setvisitcount(int visitcount) {
		this.visitcount=visitcount;
	}



}
