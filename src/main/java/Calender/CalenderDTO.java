package Calender;

public class CalenderDTO {

	private String content;
	private String day;
	private String number;
	
	// 내용
	public String getcontent() {
		return content;
	}
	
	public void setcontent(String content) {
		this.content = content;
	}
	
	
	// 날짜
	public String getday() {
		return day;
	}
	
	public void setday(String day) {
		this.day = day;
	}
	
	
	// 일정 리스트 (전체 일정)
	public String getnumber() {
		return number;
	}
	
	public void setnumber(String number) {
		this.number = number;
	}
	
}
