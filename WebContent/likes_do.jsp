<%@ page language="java" contentType="text/html; charset=UTF-8"
import="java.sql.*, java.io.*, java.util.*"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

String i= String.valueOf(request.getParameter("i"));	//url을 통해 board_idx 넘겨받음
int board_idx=Integer.parseInt(i);
String l=String.valueOf(session.getAttribute("user_idx"));
int user_idx=Integer.parseInt(l);

con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

//좋아요 눌렀나 안눌렀나 확인
String sql="SELECT * FROM likes WHERE board_idx=? AND user_idx=?;";
pstmt = con.prepareStatement(sql);
pstmt.setInt(1, board_idx);
pstmt.setInt(2, user_idx);
rs=pstmt.executeQuery();
if(rs.next()){ //이미 눌렀던 글이라면 좋아요 취소, 좋아요 카운터 감소
	sql="DELETE FROM likes WHERE idx=?;";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, rs.getInt("idx"));
	pstmt.executeQuery();
	
	sql="SELECT * FROM board WHERE board_idx=?";	//좋아요 카운터 불러옴
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, board_idx);
	rs=pstmt.executeQuery();
	rs.next();
	int cnt=rs.getInt("likes_num");
	cnt--;
	
	sql="UPDATE board SET likes_num=? WHERE board_idx=?";	//좋아요 카운터 1감소 업데이트
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, cnt);
	pstmt.setInt(2, board_idx);
	pstmt.executeQuery();
}else{	//좋아요가 눌리지 않았던 글이라면 좋아요 추가, 좋아요 카운터 증가
	sql= "INSERT INTO likes(user_idx,board_idx) VALUES(?,?)";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, user_idx);
	pstmt.setInt(2, board_idx);
	pstmt.executeQuery();
	
	sql="SELECT * FROM board WHERE board_idx=?";	//좋아요 카운터 불러옴
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, board_idx);
	rs=pstmt.executeQuery();
	rs.next();
	int cnt=rs.getInt("likes_num");
	cnt++;

	sql="UPDATE board SET likes_num=? WHERE board_idx=?";	//좋아요 카운터 1감소 업데이트
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, cnt);
	pstmt.setInt(2, board_idx);
	pstmt.executeQuery();
}

rs.close();
pstmt.close();
con.close();
response.sendRedirect(request.getHeader("Referer"));
%>