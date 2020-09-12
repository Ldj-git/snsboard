<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<article>

	<div>
	<form action="user_add_do.jsp" method="post" enctype="multipart/form-data" name="addInfo" onsubmit="return pwdChecker()">
	<table style="text-align:center">
	<tr>
	<th colspan="2" style="font-size:50px">회원가입</th>
	</tr>
	<tr>
	<td>ID</td><td><input type="text" name="id" id="id" maxlength="10" size="20"></td>
	</tr>
	<tr>
	<td>성명</td><td><input type="text" name="name" id="name" maxlength="10" size="20"></td>
	</tr>
	<tr>
	<td>암호</td><td><input type="password" name="pwd" id="pwd"></td>
	</tr>
	<tr>
	<td>암호 재확인</td><td><input type="password" name="pwd2"></td>
	</tr>
	<tr>
	<td>프로필 사진</td><td><input type="file" name="fileName"></td>
	</tr>
	<tr>
	<td>(첨부 안하면 기본 사진으로 등록됩니다.)</td><td> <input type="submit" value="저  장 "></td>
	</tr>
	</table>
	</form>	
	</div>

</article>

</body>
</html>