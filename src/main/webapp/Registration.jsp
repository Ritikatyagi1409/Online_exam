<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,online_examination.GetConn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration</title>
<style>
body {
        background: linear-gradient(to right, #2eace1, #79bacf, #64b9dd);
        font-family: 'Poppins', sans-serif;
}
 #form {
        width: 300px;
        margin: 20vh auto 0 auto;
        padding: 20px;
        background-color: rgb(56, 204, 145);
        border-radius: 4px;
        font-size: 12px;
    }
    
    #form h1 {
        color: #0f2027;
        text-align: center;
    }
    
    #form button {
        padding: 10px;
        margin-top: 10px;
        width: 100%;
        color: white;
        background-color: rgb(41, 57, 194);
        border: none;
        border-radius: 4px;
    }
.container{
  width: 50%;  /* Adjust width as needed */
  margin: auto;
  margin-top:30px;
}
</style>
</head>
<body>
<%!
String uname, pass, name, age, sq, sa, gender;
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
%>
<%
uname = request.getParameter("uname");
pass = request.getParameter("password1");
gender = request.getParameter("gender");
age = request.getParameter("age");
sq = request.getParameter("sq");
sa = request.getParameter("sa");
name = request.getParameter("name");
try {
	con = GetConn.giveConn();
	ps = con.prepareStatement("select userid from adjava where userid=?");
	ps.setString(1, uname);
	rs = ps.executeQuery();
	if (rs.next()) 
	{%>
	<div class="container">
		<form id="form" action="registration.html">
            <h1>Username Already Exist</h1>
            <button type="submit">Back</button>
            </form>
		</div>
	<%
	} 
	else 
	{
		int ag = Integer.parseInt(age);
		ps = con.prepareStatement("INSERT INTO adjava (userid ,password ,name ,gender ,age,sq,sa) VALUES (?,?,?,?,?,?,?)",ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ps.setString(1, uname);
		ps.setString(2, pass);
		ps.setString(3, name);
		ps.setInt(4, ag);
		ps.setString(5, gender);
		ps.setString(6, sq);
		ps.setString(7, sa);
		int che = ps.executeUpdate();
		if (che == 1) {
		%>
		<!-- HTML content when condition is true -->
		<div class="container">
		<form id="form" action="login.html">
            <h1>Successfully Registered</h1>
            <button type="submit">Login</button>
            </form>
		</div>	
		<%} else {
			out.print("Not Registered");
		}
	}
} catch (Exception e) {
	response.sendRedirect("error.html");
}
%>
</body>
</html>