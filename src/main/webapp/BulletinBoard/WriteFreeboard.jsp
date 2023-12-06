<%@ page import = "FreeboardForm.FreeboardFormDTO" %>
<%@ page import = "FreeboardForm.FreeboardFormDAO" %>
<%@ page langua
ge="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String title = request.getParameter("title");
String content = request.getParameter("content");
String board_pass = request.getParameter("board_pass");

FreeboardFormDTO dto = new FreeboardFormDTO();
dto.settitle(title);
dto.setcontent(content);
dto.setboard_pass(Integer.parseInt(board_pass));

FreeboardFormDAO dao = new FreeboardFormDAO(application);
int iResult = dao.freeinsertWrite(dto);

dao.close();

%>