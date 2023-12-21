package Personal;

import java.util.HashMap;
import java.util.Map;

class Team {

	private String cTeamname;
	private Map<String, PersonalDTO> teams;
	
	public Team() {
        this.teams = new HashMap<>(); // 여기에서 teams 맵 초기화
    }
	
	public String getName() {
		return cTeamname;
	}

	public void setName(String name) {
		this.cTeamname = name;
	}

	public Map<String, PersonalDTO> getTeam() {
		return teams;
	}

	public void setTeam(Map<String, PersonalDTO> team) {
		this.teams = team;
	}

}
