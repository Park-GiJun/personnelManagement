package Calender;

public class CalenderDTO {

	private String title;
	private String content;
	private String day;
	private String Schedules;
	
	// 제목
	public String gettitle() {
		return title;
	}
	
	public void settitle(String title) {
		this.title = title;
	}
	
	
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
	public String getScheduleList() {
		return Schedules;
	}
	
	public void setScheduleList(String Schedules) {
		this.Schedules = Schedules;
	}
	
}
