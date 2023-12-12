package Calender;

public class TeamVactionDTO {

	private String Start_vacation;
	private String end_vacation;
	private String emp_num;
	
	public TeamVactionDTO() {
		super();
	}
	
	public TeamVactionDTO(String Start_vacation, String end_vacation, String emp_num) {
		super();
		this.Start_vacation = Start_vacation;
		this.end_vacation = end_vacation;
		this.emp_num = emp_num;
	}
	
	// (개인 일정) 내용
	public String getStart_vacation() {
		return Start_vacation;
	}
	
	public void setStart_vacation(String Start_vacation) {
		this.Start_vacation = Start_vacation;
	}
	
	
	// (개인 일정) 날짜
	public String getend_vacation() {
		return end_vacation;
	}
	
	public void setend_vacation(String end_vacation) {
		this.end_vacation = end_vacation;
	}
	
	
	// (개인 일정) 사번
	public String getemp_num() {
		return emp_num;
	}
	
	public void setemp_num(String emp_num) {
		this.emp_num = emp_num;
	}
	
}
