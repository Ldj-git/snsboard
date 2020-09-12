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

Timestamp date= new Timestamp(System.currentTimeMillis());
String content=request.getParameter("comment");
String i= String.valueOf(request.getParameter("i"));	//url을 통해 board_idx 넘겨받음
int board_idx=Integer.parseInt(i);
String user_idx=String.valueOf(session.getAttribute("user_idx"));

con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

String sql= "INSERT INTO comment(user_idx,board_idx,content,add_date) VALUES(?,?,?,?)";
pstmt = con.prepareStatement(sql);

//8. pstmt의 SQL 쿼리 구성
pstmt.setString(1, user_idx);
pstmt.setInt(2, board_idx);
pstmt.setString(3, content);
pstmt.setTimestamp(4, date);

//9. 쿼리 실행
pstmt.executeQuery();

//댓글 카운터 가져오기
sql="SELECT comment_num FROM board WHERE board_idx="+i+";";
ResultSet rs=pstmt.executeQuery(sql);
rs.next();
int counter = rs.getInt("comment_num");
counter++;

//댓글 카운터 증가시킨거 적용
sql="UPDATE board SET comment_num=? WHERE board_idx=?;";
pstmt=con.prepareStatement(sql);
pstmt.setInt(1, counter);
pstmt.setInt(2, board_idx);
pstmt.executeQuery();

rs.close();
pstmt.close();
con.close();
response.sendRedirect(request.getHeader("Referer"));
%>