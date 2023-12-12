package Calender;

public class TeamCalDTO {

	private String Personal_diaray_schedule;
	private String Personal_diaray_date;
	private String emp_num;
	
	public TeamCalDTO() {
		super();
	}
	
	public TeamCalDTO(String Personal_diaray_schedule, String Personal_diaray_date, String emp_num) {
		super();
		this.Personal_diaray_schedule = Personal_diaray_schedule;
		this.Personal_diaray_date = Personal_diaray_date;
		this.emp_num = emp_num;
	}
	
	// (개인 일정) 내용
	public String getPersonal_diaray_schedule() {
		return Personal_diaray_schedule;
	}
	
	public void setPersonal_diaray_schedule(String Personal_diaray_schedule) {
		this.Personal_diaray_schedule = Personal_diaray_schedule;
	}
	
	
	// (개인 일정) 날짜
	public String getPersonal_diaray_date() {
		return Personal_diaray_date;
	}
	
	public void setPersonal_diaray_date(String Personal_diaray_date) {
		this.Personal_diaray_date = Personal_diaray_date;
	}
	
	
	// (개인 일정) 사번
	public String getemp_num() {
		return emp_num;
	}
	
	public void setemp_num(String emp_num) {
		this.emp_num = emp_num;
	}
	
}
