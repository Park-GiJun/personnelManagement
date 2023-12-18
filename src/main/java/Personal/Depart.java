package Personal;

import java.util.ArrayList;
import java.util.List;

public class Depart {
	private String cDepartname;
	private List<Team> departs;
	
	public Depart() {
		this.departs = new ArrayList<Team>();
	}

	public String getcDepartname() {
		return cDepartname;
	}

	public void setcDepartname(String cDepartname) {
		this.cDepartname = cDepartname;
	}

	public List<Team> getDeparts() {
		return departs;
	}

	public void setDeparts(List<Team> departs) {
		this.departs = departs;
	}

}