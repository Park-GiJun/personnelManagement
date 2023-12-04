package attend;

public class AttendanceDTO {
	private String empNum;
	private java.sql.Date day_of_work;
	private java.sql.Date start_time;
	private java.sql.Date end_time;

	public String getEmpNum() {
		return empNum;
	}

	public void setEmpNum(String empNum) {
		this.empNum = empNum;
	}

	public java.sql.Date getDay_of_work() {
		return day_of_work;
	}

	public void setDay_of_work(java.sql.Date day_of_work) {
		this.day_of_work = day_of_work;
	}

	public java.sql.Date getStart_time() {
		return start_time;
	}

	public void setStart_time(java.sql.Date start_time) {
		this.start_time = start_time;
	}

	public java.sql.Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(java.sql.Date end_time) {
		this.end_time = end_time;
	}

}
