<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("user_idx")!=null){	//이미 로그인된 세션이면 페이지 변경
	response.sendRedirect("main_after_login.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sns 게시판 홈</title>
<link rel="stylesheet" type="text/css" href="default.css">
</head>
<body>

<header>
	<img src="images/home.png" width=80px; usemap="#homemap">
	<map name="homemap">
		<area shape="rect" coords="0,0,682,682" href="main.jsp">
	</map>
</header>

<nav>
	<div class="idpw">
	<form action="login.jsp" method="post">
	<table>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id" size="10" maxlength="10"></td>
	</tr>
	<tr>
		<td>비밀번호 </td>
		<td><input type="password" name="pw" size="10" maxlength="10"></td>
	</tr>
	<tr>
		<td colspan="2"> <input type="submit" value="로그인 "> <input type="button" value="회원가입" onClick="location.href='user_add.jsp'"></td>
	</tr>
	</table>
	</form>
	</div>
	
	<ul class="menu" >
		<li><a href="search.jsp">검색</a></li>
		<li><a href="popular.jsp">인기글 모음</a></li>
	</ul>
</nav>
<%
Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/snsboard?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con=null;
PreparedStatement pstmt = null;
ResultSet rs=null;
try {
	con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

	String sql = "SELECT * FROM board INNER JOIN user USING(user_idx) ORDER BY board_idx DESC;";
	
	pstmt = con.prepareStatement(sql);

	rs = pstmt.executeQuery();
%>

<article>

<%
while(rs.next()){
%>
	<div>
		<img id="프로필사진" src="./upload/<%=rs.getString("profile") %>"><span id="작성자이름"><%=rs.getString("user_name") %></span> 
		<%
		if(rs.getTimestamp("update_date")==null){
			%>
		<span id="작성시간"><%=rs.getTimestamp("add_date") %></span>	
			<%
		}else{
		%>
		<span id="작성시간"><%=rs.getTimestamp("update_date") %>(수정됨)</span>
		<%
		}
		//글 내용이 100자 이상인지 판별
		String c=rs.getString("content");
		boolean more=false;
		if(c.length()>100){
			c=c.substring(0, 100);
			more=true;
		}
		
		%>
		<span id="버튼"onclick="location.href='detailed_article.jsp?i=<%=rs.getInt("board_idx") %>'">글 자세히 보기</span>
		<p id="글제목"><%=rs.getString("title") %></p>
		<p id="글내용"><%=c %>
		<%
		if(more){	//100자 이상이면 더보기 버튼 띄움
			%>
			<a href="detailed_article.jsp?i=<%=rs.getInt("board_idx") %>">......더보기</a>
			<%
		}
		%>
		</p>		
		<script>
		function size(a){	//이미지 클릭시 확대 다시 클릭시 축소
			if(a.style.width=="100px"){
				a.style.width="100%";
				a.style.height="100%";
			}else{
				a.style.width="100px";
				a.style.height="100px";
			}
		}
		</script>
		
		<%
		PreparedStatement pstmt2 = null;
		ResultSet rs2=null;
		int b=rs.getInt("board_idx");
		String sql2 = "SELECT * FROM file WHERE board_idx='"+rs.getInt("board_idx")+"';";
		pstmt2 = con.prepareStatement(sql2);
		rs2 = pstmt2.executeQuery();
		int l=0;
		while(rs2.next()&&l<2){
			if(rs2.getString("appendfile")!=null){
		%>
		<img id="글사진" src="./upload/<%=rs2.getString("appendfile") %>" onclick="size(this);">
		<%
			}
			l++;
		}if(rs2.next()){	//댓글이 2개 보다 많으면 더보기 버튼 출력
			%>
			<span id="버튼"onclick="location.href='detailed_article.jsp?i=<%=rs.getInt("board_idx") %>'">사진 더보기</span>
			<%
		}
		rs2.close();
		pstmt2.close();
		%>
		<div>
		<img id="좋아요사진" src="./images/like.png" onclick="alert('로그인후 누를수 있습니다.');"><span id="추천"><%=rs.getInt("likes_num") %></span>
		<span id="댓글"onclick="location.href='detailed_article.jsp?i=<%=rs.getInt("board_idx") %>'">댓글수 : <%=rs.getInt("comment_num") %> </span>
		<span id="조회수">조회수 : <%=rs.getInt("views") %></span>
		</div>
		
		<div>
		<%//댓글
		PreparedStatement pstmt3 = null;
		ResultSet rs3=null;
		String sql3="SELECT * FROM comment INNER JOIN user USING(user_idx) WHERE board_idx="+rs.getInt("board_idx")+" ORDER BY comment_idx DESC;";
		pstmt3 = con.prepareStatement(sql3);
		rs3 = pstmt3.executeQuery();
		l=0;
		while(rs3.next()&&l<2){
			//댓글 작성자 프로필, 이름
			%>
			<img id="프로필사진" src="./upload/<%=rs3.getString("profile") %>">
			<span id="작성자이름"><%=rs3.getString("user_name") %></span>
			<%
			
			//댓글 시간
			if(rs3.getTimestamp("update_date")==null){
			%>
			<span id="작성시간"><%=rs3.getTimestamp("add_date") %></span>	
			<%
			}else{
			%>
			<span id="작성시간"><%=rs3.getTimestamp("update_date") %>(수정됨)</span>
			<%
			}
			String c3 = rs3.getString("user_idx");
			String c4= String.valueOf(session.getAttribute("user_idx"));
			if(c3.equals(c4)){//db의 댓글이 현재 로그인 한 사람의 댓글이면 수정, 삭제 버튼 띄움
				int i=rs3.getInt("comment_idx");
				//request.setAttribute("board_idx", i);
			%>
			<span id="버튼" onclick="location.href='comment_modify.jsp?i=<%=rs3.getInt("board_idx")%>&c=<%=rs3.getInt("comment_idx")%>'" >수정</span>
			<span id="버튼" onclick="if(confirm('정말로 삭제하겠습니까?')){location.href='comment_delete_do.jsp?i=<%=rs3.getInt("comment_idx") %>&b=<%=rs3.getInt("board_idx")%>'}" ">삭제</span>
			<%
			}
			l++;
		%>
		<p id="글제목"><%=rs3.getString("content") %></p>
		<%
		}		
		if(rs3.next()){	//댓글이 2개 보다 많으면 더보기 버튼 출력
		%>
		<span id="버튼"onclick="location.href='detailed_article.jsp?i=<%=rs.getInt("board_idx") %>'">댓글 더보기</span>
		<%
		}
		rs3.close();
		pstmt3.close();
		%>
		</div>
	</div>
<%
	}
	rs.close();
	pstmt.close();
	con.close();
}catch(SQLException e) {
	out.println(e);
}
%>
</article>
</body>
</html>