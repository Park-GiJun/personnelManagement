package MeetingRoom;

public class MeetingRoomDTO {

	private String empNum;
	private String date;
	private String meetingroomNum;
	private String team;
	private String team_num;
	private String status;
	private String name;


	public String getStatus() {
		return status;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmpNum() {
		return empNum;
	}

	public void setEmpNum(String empNum) {
		this.empNum = empNum;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getMeetingroomNum() {
		return meetingroomNum;
	}

	public void setMeetingroomNum(String meetingroomNum) {
		this.meetingroomNum = meetingroomNum;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public String getTeam_num() {
		return team_num;
	}

	public void setTeam_num(String team_num) {
		this.team_num = team_num;
	}

}
