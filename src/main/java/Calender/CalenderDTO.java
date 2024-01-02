package Calender;

public class CalenderDTO {

	private int count_date;
	private String Personal_diaray_schedule;
	private String Personal_diaray_date;
	private String emp_num;
	
	public CalenderDTO() {
		super();
	}
	
	public CalenderDTO(String Personal_diaray_schedule, String Personal_diaray_date, String emp_num) {
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
	

	public int getCount_date() {
		return count_date;
	}

	public void setCount_date(int count_date) {
		this.count_date = count_date;
	}
	
	//마우스 오른쪽 클릭 - 소스 - 겟셋 클릭
}
