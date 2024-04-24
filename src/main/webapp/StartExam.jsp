<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,online_examination.GetConn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Examination</title>
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
        font-size: 17px;
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
Connection con;
PreparedStatement ps;
ResultSet rs;
%>
<%
rs = (ResultSet) application.getAttribute("resultSet");// application is the implicit object of servletContext class in jsp.
if (rs != null) {
	try {
		if(rs.next()) {
			String qno = new String(rs.getString(1));
			String question = new String(rs.getString(2));
			String option1 = new String(rs.getString(3));
			String option2 = new String(rs.getString(4));
			String option3 = new String(rs.getString(5));
			String option4 = new String(rs.getString(6));%>
			<div class="container">
			<form id="form" action="CheckAns">
	            <p><%=qno %>.<%=" "%><%=question %></p>
	            <input type='radio' name='answer' value="<%= option1%>"><%=option1 %><br>
	            <input type='radio' name='answer' value="<%= option2%>"><%=option2 %><br>
	            <input type='radio' name='answer' value="<%= option3%>"><%=option3 %><br>
	            <input type='radio' name='answer' value="<%= option4%>"><%=option4 %><br>
	            <button type="submit">Next</button>
	            </form>
			</div>
			<%			
			application.setAttribute("resultSet", rs);
		}
		else {%>
		<div class="container">
			<form id="form" action="CheckAns.jsp">
	            <button type="submit">Submit Exam</button>
	            </form>
			</div>
		<%
		}
	}
	catch(Exception e) {
		out.println(e);
	}
}
else {
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "systemroot");
		ps = con.prepareStatement("Select * from question", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs = ps.executeQuery();
		rs.next();
		String qno = new String(rs.getString(1));
		String question = new String(rs.getString(2));
		String option1 = new String(rs.getString(3));
		String option2 = new String(rs.getString(4));
		String option3 = new String(rs.getString(5));
		String option4 = new String(rs.getString(6));%>
		<div class="container">
			<form id="form" action="CheckAns">
	            <p><%=qno %>.<%=question %></p>
	            <input type='radio' name='answer' value="<%= option1%>"><%=option1 %><br>
	            <input type='radio' name='answer' value="<%= option2%>"><%=option2 %><br>
	            <input type='radio' name='answer' value="<%= option3%>"><%=option3 %><br>
	            <input type='radio' name='answer' value="<%= option4%>"><%=option4 %><br>
	            <button type="submit">Next</button>
	            </form>
			</div>
		
		<%
		Integer result=0;
		application.setAttribute("result",result);
		application.setAttribute("resultSet", rs);
	} catch (Exception e) {
		System.out.println(e);
	}
}
%>
</body>
</html>