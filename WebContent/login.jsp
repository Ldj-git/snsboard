<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>

<%
request.setCharacterEncoding("utf-8");

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";

Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

con=DriverManager.getConnection(DB_URL,"admin","1234");

String id=request.getParameter("id");
String pwd=request.getParameter("pw");
String dbPwd="";//db에 저장된 비밀번호 불러올 공간
String msg="";//상태를 넘긴 주소(아이디 없는 경우, 비번 틀린경우, 로그인 성공한경우)

try{
	String sql="SELECT * FROM user WHERE user_id=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, id);
	rs= pstmt.executeQuery();
	
	if(rs.next()){//입력된 아이디가 db에 있는 경우
		dbPwd=rs.getString("user_password");
		if(dbPwd.equals(pwd)){//db의 비번과 입력한 비번이 같다면
			int idx=rs.getInt("user_idx");
			session.setAttribute("user_idx", idx);	//세션으로 로그인할 정보 넘김
			String name=rs.getString("user_name");
			session.setAttribute("name", name);
			
			String file=rs.getString("profile");//파일이름 넘김
			session.setAttribute("profile", file);
			
			//response.sendRedirect("main_after_login.jsp");
			response.sendRedirect(request.getHeader("Referer"));	//이전 페이지로 연결
		}else{//비번 틀린 경우
			out.println("<script>alert('비밀번호 틀립!'); location.href='main.jsp';</script>");
		}
	
	}else{//입력된 아이디가 존재하지 않을 때
		out.println("<script>alert('아이디가 존재하지 않습니다.'); location.href='main.jsp';</script>");
		
	}
	
}catch(Exception e){
	out.println(e);
	return;
}
//response.sendRedirect("main.jsp");
%>