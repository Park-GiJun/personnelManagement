package Calender;

public class CalenderDTO {

	private String Person_content;
	private String Person_day;
	private String Person_num;
	
	// (개인 일정) 내용
	public String getPerson_content() {
		return Person_content;
	}
	
	public void setPerson_content(String Person_content) {
		this.Person_content = Person_content;
	}
	
	
	// (개인 일정) 날짜
	public String getPerson_day() {
		return Person_day;
	}
	
	public void setPerson_day(String Person_day) {
		this.Person_day = Person_day;
	}
	
	
	// (개인 일정) 사번
	public String getPerson_num() {
		return Person_num;
	}
	
	public void setPerson_num(String Person_num) {
		this.Person_num = Person_num;
	}
	
}
