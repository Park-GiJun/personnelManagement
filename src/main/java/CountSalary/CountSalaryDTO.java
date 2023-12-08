package CountSalary;

public class CountSalaryDTO {

	private String emp_num;
	private int actual_work_time;
	private int overtime_work;
	private String SalaryDate;
	
	public int getActual_work_time() {
		return actual_work_time;
	}
	public void setActual_work_time(int actual_work_time) {
		this.actual_work_time = actual_work_time;
	}
	public int getOvertime_work() {
		return overtime_work;
	}
	public void setOvertime_work(int overtime_work) {
		this.overtime_work = overtime_work;
	}
	public String getEmp_num() {
		return emp_num;
	}
	public void setEmp_num(String emp_num) {
		this.emp_num = emp_num;
	}
	public String getSalaryDate() {
		return SalaryDate;
	}
	public void setSalaryDate(String salaryDate) {
		SalaryDate = salaryDate;
	}
}
