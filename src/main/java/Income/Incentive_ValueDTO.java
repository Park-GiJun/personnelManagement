package Income;

public class Incentive_ValueDTO {
	private String empNum;
	private int holiday_pay;
	private int incentive;
	private int extra_work_pay;

	public String getEmpNum() {
		return empNum;
	}

	public void setEmpNum(String empNum) {
		this.empNum = empNum;
	}

	public java.sql.Date getIncnetive_value_date() {
		return incnetive_value_date;
	}

	public void setIncnetive_value_date(java.sql.Date incnetive_value_date) {
		this.incnetive_value_date = incnetive_value_date;
	}

	public int getHoliday_pay() {
		return holiday_pay;
	}

	public void setHoliday_pay(int holiday_pay) {
		this.holiday_pay = holiday_pay;
	}

	public int getIncentive() {
		return incentive;
	}

	public void setIncentive(int incentive) {
		this.incentive = incentive;
	}

	public int getExtra_work_pay() {
		return extra_work_pay;
	}

	public void setExtra_work_pay(int extra_work_pay) {
		this.extra_work_pay = extra_work_pay;
	}

	private java.sql.Date incnetive_value_date;

}
