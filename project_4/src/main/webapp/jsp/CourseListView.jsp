<%@page import="in.co.rays.project_4.util.HTMLUtility"%>
<%@page import="in.co.rays.project_4.model.CourseModel"%>
<%@page import="in.co.rays.project_4.bean.CourseBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="in.co.rays.project_4.controller.CourseListCtl"%>
<%@page import="in.co.rays.project_4.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Online Result System</title>

<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=ORSView.APP_CONTEXT %>/js/CheckBox11.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com//jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
#content{
max-height:230px;
position: relative;
}
</style>

</head>
<div id="content">
<body>
	<%@ include file="Header.jsp"%>
	<center>
		<h1>Course List</h1>
		<jsp:useBean id="bean" class="in.co.rays.project_4.bean.CourseBean"
			scope="request"></jsp:useBean>
			
			 <%
        List l=(List)request.getAttribute("course");
        %>
			
		<form action="<%=ORSView.COURSE_LIST_CTL %>" method="post">
		
		<%
		 int pageNo=ServletUtility.getPageNo(request);
        int pageSize=ServletUtility.getPageSize(request);
        int index= ((pageNo-1)*pageSize)+1;
        
        List list=ServletUtility.getList(request);
        Iterator<CourseBean> it=list.iterator();
		%>
		<% if(list.size()!=0){%>

<tr>
				<td colspan="8"><font color="red"><%=ServletUtility.getErrorMessage(request) %></font>
				</tr>
				<tr>
				<td colspan="8"><font color="green"><%=ServletUtility.getSuccessMessage(request) %></font>
				</tr>

			<table width="100%">
				<tr>
					<td align="center"><label>Course</label>
					 <%=HTMLUtility.getList("course", String.valueOf(bean.getId()), l) %>&emsp;
						<input type="submit" name="operation" value="<%=CourseListCtl.OP_SEARCH%>">
						<input type="submit" name="operation" value="<%=CourseListCtl.OP_RESET%>">
						</td>
				</tr>
<!-- 			</table> -->
			

			<table border="1" width="100%">
				<tr>
				   
					<th><input type="checkbox" id="select_all" name="select">Select All</th>
					<th>s.no</th>
					<th>CourseName</th>
					<th>Description</th>
					<th>Edit</th>

				</tr>
               
				
					<%
            
             
             CourseModel model= new CourseModel();
             while(it.hasNext()){
            	 bean=it.next();
            	 
             
        %>
				<tr>
					 <td align="center"><input type="checkbox" class="checkbox" name="ids" value="<%=bean.getId()%>"></td>
						<td align="center"><%=index++ %></td>
					<td align="center"><%=bean.getCourseName() %></td>
					<td align="center"><%=bean.getDescription() %></td>
					<td align="center"><a href="CourseCtl?id=<%=bean.getId()%>">Edit</a></td>
					<%
        }
        %>


				</tr>
			</table>
			<table width="100%">
				<tr>
					<%
						if (pageNo == 1) {
					%>
					<td align="left" ><input type="submit" name="operation" disabled="disabled"
						value="<%=CourseListCtl.OP_PREVIOUS%>"></td>
					<%
						} else {
					%>
					<td align="left"><input type="submit" name="operation"
						value="<%=CourseListCtl.OP_PREVIOUS%>"></td>
					<%
						}
					%>
						<td align="center"><input type="submit" name="operation"
						value="<%=CourseListCtl.OP_NEW%>"></td>
					<td align="center"><input type="submit" name="operation"
						value="<%=CourseListCtl.OP_DELETE%>"></td>
					<%if((model.nextPK()-1)==bean.getId() || list.size()<pageSize){ %>

					<td align="right"><input type="submit" name="operation"
						disabled="disabled" value="<%=CourseListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>
					<td align="right"><input type="submit" name="operation"
						value="<%=CourseListCtl.OP_NEXT%>"></td>

					<%
						}
					%>
				</tr>

			</table>
			
			<%} if(list.size()==0) { %>
            <table>
            <tr>
            <td colspan="8"><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></td>
				</tr>
				<tr>
					<td colspan="8"><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></td>
				</tr>
				
            <tr>
            <td align="center">
            <input type="submit" name="operation" value="<%=CourseListCtl.OP_BACK %>">
            </td>
            </tr>
            </table>
            
            <%} %>
				</tr>
			</table>
			
			<input type="hidden" name="pageNo" value="<%=pageNo %>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
	</center>
	</form>
	<%@include file="Footer.jsp"%>
</body></div>
</html>