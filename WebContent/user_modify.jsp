<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("user_idx")==null){	//로그아웃되면 원래 메인으로
	response.sendRedirect("main.jsp");
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
		<area shape="rect" coords="0,0,682,682" href="main_after_login.jsp">
	</map>
</header>

<nav>
	<div class="idpw">
	<img src="./upload/<%=session.getAttribute("profile")%>" width="50" height="50">	
	<%=session.getAttribute("name") %>님 환영합니다.
	<input type="button" value="로그아웃" onclick="location.href='logout.jsp'">
	</div>
	
	<ul class="menu" >
		<li><a href="search.jsp">검색</a></li>
		<li><a href="popular.jsp">인기글 모음</a></li>
		<li><a href="input.jsp">글 작성</a></li>
		<li><a href="myboard.jsp">내가 쓴 글</a></li>
		<li><a href="user_modify.jsp">회원 정보 수정</a></li>
	</ul>
</nav>

<script>
function pwdChecker(){
	if(!document.addInfo.id.value){
		alert("아이디를 입력하세요!");
		document.getElementById("id").focus();
		return false;
	}
	if(!document.addInfo.name.value){
		alert("이름을 입력하세요!");
		document.getElementById("name").focus();
		return false;
	}
	if(!document.addInfo.pwd.value){
		alert("비밀번호를 입력하세요!");
		document.getElementById("pwd").focus();
		return false;
	}
	if(document.addInfo.pwd.value != document.addInfo.pwd2.value){
		alert("입력한 비밀번호가 다릅니다. 다시 입력해주세요!")
		document.getElementById("pwd").focus();
		return false;
	}
}
</script>
<%
String i= String.valueOf(session.getAttribute("user_idx"));
int idx=Integer.parseInt(i);

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";

Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

con=DriverManager.getConnection(DB_URL,"admin","1234");

String sql="SELECT user_id, user_name, user_password, profile FROM user WHERE user_idx=?";
pstmt=con.prepareStatement(sql);
pstmt.setInt(1, idx);

rs= pstmt.executeQuery();
rs.next();
%>


<article>
	<div>
	<form action="user_modify_do.jsp" method="post" enctype="multipart/form-data" name="addInfo" onsubmit="return pwdChecker()">
	<table style="text-align:center">
	<tr>
	<th colspan="2" style="font-size:50px">회원정보</th>
	</tr>
	<tr>
	<td>ID</td><td><input type="text" name="id" id="id" maxlength="10" size="20" value="<%=rs.getString("user_id") %>"></td>
	</tr>
	<tr>
	<td>성명</td><td><input type="text" name="name" id="name" maxlength="10" size="20" value="<%=rs.getString("user_name") %>"></td>
	</tr>
	<tr>
	<td>암호</td><td><input type="password" name="pwd" id="pwd" value="<%=rs.getString("user_password") %>"></td>
	</tr>
	<tr>
	<td>암호 재확인</td><td><input type="password" name="pwd2" value="<%=rs.getString("user_password") %>"></td>
	</tr>
	<tr>
	<td>변경할 프로필 사진</td><td><input type="file" name="fileName" ></td>
	</tr>
	<tr>
	<td>사진 변경하고싶지 않으면 아무것도 첨부 하지 마세요</td><td> <input type="submit" value="저  장 "></td>
	</tr>
	</table>
	</form>	
	</div>
	
</article>
<%
rs.close();
%>
</body>
</html>