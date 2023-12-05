package HoliDay;

public class HoliDayDTO {

	private String start_vacation;
	private String end_vacation;
	private String Team;
	private String Approval;
	private String emp_num;
	private String Annual;
	
	public String getTeam() {
		return Team;
	}
	public void setTeam(String team) {
		Team = team;
	}
	public String getApproval() {
		return Approval;
	}
	public void setApproval(String approval) {
		Approval = approval;
	}
	public String getAnnual() {
		return Annual;
	}
	public void setAnnual(String annual) {
		Annual = annual;
	}
	public String getStart_vacation() {
		return start_vacation;
	}
	public void setStart_vacation(String start_vacation) {
		this.start_vacation = start_vacation;
	}
	public String getEnd_vacation() {
		return end_vacation;
	}
	public void setEnd_vacation(String end_vacation) {
		this.end_vacation = end_vacation;
	}
	public String getemp_num() {
		return emp_num;
	}
	public void setemp_num(String emp_num) {
		this.emp_num = emp_num;
	}
}
