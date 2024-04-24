<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,online_examination.GetConn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<%!ResultSet rs; %>
<%
rs = (ResultSet) application.getAttribute("resultSet");
Integer result=(Integer)application.getAttribute("result");
try {
	if(rs!=null) {
		String ans=request.getParameter("answer");
		String correct=rs.getString(7);
		if(ans.equals(correct)) {
			result=Integer.valueOf(result.intValue() + 1);
			application.setAttribute("result",result);
		}
		response.sendRedirect("http://localhost:8080/Online_Examination/StartExam.jsp");
	}
}
catch(SQLException e) {%>
<div class="container">
<form id="form">
<h1>Your Result is <%=result.intValue()%></h1>
</form>
			
</div>
<%
}
catch(NullPointerException e1) {
	out.println(e1);
}

%>
</body>
</html>