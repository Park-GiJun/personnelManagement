package Personal;
import java.sql.Date;

public class PersonalDTO {
	private String name;
	private String empNum;
	private String email;
	private String password;
	private String department;
	private String grade;
	private int phone;
	private Date companydate;

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

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getPhone() {
		return phone;
	}

	public void setPhone(int phone) {
		this.phone = phone;
	}

	public java.util.Date getCompanydate() {
		return companydate;
	}

	public void setCompanydate(Date date) {
		this.companydate = date;
	}

}
