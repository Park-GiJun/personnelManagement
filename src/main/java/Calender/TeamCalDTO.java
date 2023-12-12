package Calender;

public class TeamCalDTO {

	private String Team_calender_date;
	private String team;
	private String team_schedule;
	
	public TeamCalDTO() {
		super();
	}
	
	public TeamCalDTO(String Team_calender_date, String team, String team_schedule) {
		super();
		this.Team_calender_date = Team_calender_date;
		this.team = team;
		this.team_schedule = team_schedule;
	}
	
	// (개인 일정) 내용
	public String getTeam_calender_date() {
		return Team_calender_date;
	}
	
	public void setTeam_calender_date(String Team_calender_date) {
		this.Team_calender_date = Team_calender_date;
	}
	
	
	// (개인 일정) 날짜
	public String getteam() {
		return team;
	}
	
	public void setteam(String team) {
		this.team = team;
	}
	
	
	// (개인 일정) 사번
	public String getteam_schedule() {
		return team_schedule;
	}
	
	public void setteam_schedule(String team_schedule) {
		this.team_schedule = team_schedule;
	}
	
}
