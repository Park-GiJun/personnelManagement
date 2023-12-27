package Calender;

public class CompanyCalDTO {

	private String company_calender_date;
	private String company_schedule;
	private int com_count_date;
	
	public CompanyCalDTO() {
		super();
	}
	
	public CompanyCalDTO(String company_calender_date, String company_schedule) {
		super();
		this.company_calender_date = company_calender_date;
		this.company_schedule = company_schedule;
	}
	
	// (개인 일정) 내용
	public String getcompany_calender_date() {
		return company_calender_date;
	}
	
	public void setcompany_calender_date(String company_calender_date) {
		this.company_calender_date = company_calender_date;
	}
	
	
	// (개인 일정) 날짜
	public String getcompany_schedule() {
		return company_schedule;
	}
	
	public void setcompany_schedule(String company_schedule) {
		this.company_schedule = company_schedule;
	}
	
	public int getCom_count_date() {
		return com_count_date;
	}

	public void setCom_count_date(int com_count_date) {
		this.com_count_date = com_count_date;
	}
	
	
}
