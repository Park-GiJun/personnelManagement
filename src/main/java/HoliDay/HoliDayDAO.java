package HoliDay;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class HoliDayDAO extends DBConnPool {
	public HoliDayDAO() {
		super();
	}

	// 사용한 휴가 계한후 업데이트
	public HoliDayDTO holidayCalculation(String login_Id, String start_vacation, String end_vacation) {
		int holidaycount = 0;
		// 기존 사용가능한 휴가 조회
		HoliDayDTO dto = new HoliDayDTO();

		String query = "SELECT annual FROM holiday where emp_num=?";

		System.out.println("정보 받는 쿼리 실행");

		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, login_Id);

			rs = psmt.executeQuery();

			if (rs.next()) {
				// 조회한값 저장
				holidaycount = Integer.parseInt(rs.getString("annual"));

				System.out.println("dto 받음");
			}
		} catch (Exception e) {
			System.out.println("휴가횟수 조회중 예외 발생");
			e.printStackTrace();
		}

		// 문자열로부터 Date 객체 생성
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate = null;
		Date endDate = null;

		try {
			startDate = dateFormat.parse(start_vacation);
			endDate = dateFormat.parse(end_vacation);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		// 두 날짜의 차이 계산
		long difference = (endDate.getTime() - startDate.getTime());

		// 차이값을 일 단위로 변환
		long daysDifference = (difference / (24 * 60 * 60 * 1000));

		System.out.println("두 날짜 간의 일 수 차이: " + (daysDifference + 1) + "일");
		// 기존 날짜 와 신청한 날짜의 계산식
		String holiday_date = Long.toString(holidaycount - (daysDifference + 1));

		// 쿼리 작성
		String querys = "UPDATE holiday SET annual = ? WHERE emp_num = ?";
		System.out.println("업데이트 쿼리 실행");

		try {
			psmt = con.prepareStatement(querys);
			psmt.setString(1, holiday_date);
			psmt.setString(2, login_Id);

			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("사용가능한 휴가 최신 업데이트 중 예외 발생");
			e.printStackTrace();
		}
		return null;
	}

	// 사용가능한 휴가 조회 쿼리문 작성
	public HoliDayDTO selectholidaycount(String login_Id) {
		HoliDayDTO dto = new HoliDayDTO();

		String query = "SELECT annual FROM holiday where emp_num=?";

		System.out.println("정보 받는 쿼리 실행");

		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, login_Id);

			rs = psmt.executeQuery();

			if (rs.next()) {
				// 조회한값 저장
				dto.setAnnual(rs.getString("annual"));

				System.out.println("dto 받음");
			}
		} catch (Exception e) {
			System.out.println("휴가횟수 조회중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}

	// 휴가 신청 쿼리문 작성
	public HoliDayDTO getHolidayApplication(String login_Id, String start_vacation, String end_vacation, String Team) {

		String query = "INSERT INTO holiday_check (emp_num, start_vacation, end_vacation, team) VALUES (?, ?, ?, ?)";

		System.out.println("정보 주는 쿼리 실행");

		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, login_Id);
			psmt.setString(2, start_vacation);
			psmt.setString(3, end_vacation);
			psmt.setString(4, Team);

			psmt.executeUpdate();
			System.out.println("DB 저장 완료");
		} catch (Exception e) {
			System.out.println("휴가신청 중 예외 발생");
			e.printStackTrace();
		}
		return null;
	}

	// 게시물 수를 가져오는 쿼리
	public int selectCount(String login_Id) {
		int totalCount = 0;

		String query = "SELECT COUNT(*) FROM holiday_check WHERE emp_num=?";
		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, login_Id);

			rs = psmt.executeQuery();
			if (rs.next()) {
			totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}

	// 신청한 휴가 목록 조회 쿼리
	public List<HoliDayDTO> selectList(String login_Id) {
		List<HoliDayDTO> bbs = new Vector<HoliDayDTO>();

		String query = "SELECT * FROM holiday_check WHERE emp_num = ? ORDER BY start_vacation DESC";

		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, login_Id);

			rs = psmt.executeQuery();
			while (rs.next()) {
				HoliDayDTO dto = new HoliDayDTO();

				dto.setemp_num(rs.getString("emp_num"));
				dto.setStart_vacation(rs.getString("start_vacation"));
				dto.setEnd_vacation(rs.getString("end_vacation"));
				dto.setTeam(rs.getString("team"));
				dto.setApproval(rs.getString("approval"));

				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		} 
		return bbs;
	}
}
