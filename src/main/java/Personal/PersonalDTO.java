package Personal;

import java.sql.Date;

public class PersonalDTO {
	private String name;
	private String empNum;
	private String email;
	private String password;
	private String team;
	private String emp_grade;
	private String phone;
	private Date work_start_date;
	private int grade;
	private String team_num;

	public String getTeam_num() {
		return team_num;
	}

	public void setTeam_num(String team_num) {
		this.team_num = team_num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmpNum() {
		return empNum;
	}

	public void setEmpNum(String empNum) {
		this.empNum = empNum;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public String getEmp_grade() {
		return emp_grade;
	}

	public void setEmp_grade(String emp_grade) {
		this.emp_grade = emp_grade;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getWork_start_date() {
		return work_start_date;
	}

	public void setWork_start_date(Date work_start_date) {
		this.work_start_date = work_start_date;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

}
