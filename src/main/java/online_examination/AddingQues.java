package online_examination;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
public class AddingQues extends HttpServlet 
{
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException,ServletException
	{
		res.setContentType("text/html");
		PrintWriter out=res.getWriter();
		String ques,op1,op2,op3,op4,cans;
		ques=req.getParameter("question");
		op1=req.getParameter("Option1");
		op2=req.getParameter("Option2");
		op3=req.getParameter("Option3");
		op4=req.getParameter("Option4");
		cans=req.getParameter("CorrectOption");
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		if(ques!=null && op1!=null && op2!=null && op2!=null && op4!=null && cans!=null)
		{
			try
			{
				con=GetConn.giveConn();
				ps=con.prepareStatement("select qno from question");
				rs=ps.executeQuery();
				int qno=0;
				while(rs.next())
				{
					qno=rs.getInt("qno");
				}
				ps=con.prepareStatement("Insert into question values(?,?,?,?,?,?,?)",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				qno++;
				//out.print(qno);
				ps.setInt(1,qno);
				ps.setString(2,ques);
				ps.setString(3,op1);
				ps.setString(4,op2);
				ps.setString(5,op3);
				ps.setString(6,op4);
				ps.setString(7,cans);
				int che=ps.executeUpdate();
				if(che==1)
				{
					res.sendRedirect("addques2.html");
				}
				else
				{
					out.print("Error 1");
				}
				con.close();
			}
			catch(Exception e)
			{
				out.print("Error 2"+ e);
				//res.sendRedirect("error.html");
			}
		}
		else
		{
			out.print("Error 3");
			//res.sendRedirect("error.html");
		}
	}
}
