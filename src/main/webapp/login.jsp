

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/declarativemethods.jspf"%>

<%
String userName = "";
String password = "";
boolean pref = false;
int option = 0;

String correctUserName = "class2022";
String correctPassword = "123456";

errors = new ArrayList<>();
errors.clear();
if (request.getParameter("btnLogin") != null) {
	userName = checkRequiredField(request.getParameter("txtUserName"), "User name");
	password = checkRequiredField(request.getParameter("txtPassword"), "Password");

	if (errors.size() == 0 && password.equals(correctPassword) && userName.equals(correctUserName)) {
		if (request.getParameter("chkSave") != null) {
	Cookie user = new Cookie("userName", userName);
	Cookie password1 = new Cookie("password", password);
	Cookie save = new Cookie("save", "true");

	user.setMaxAge(60 * 60);
	user.setPath("/JEEx7");
	response.addCookie(user);

	password1.setMaxAge(60 * 60);
	password1.setPath("/JEEx7");
	response.addCookie(password1);

	save.setMaxAge(60 * 60);
	save.setPath("/JEEx7");
	response.addCookie(save);

	if (request.getParameter("selectedOption") != null) {
		Cookie selectedOption = new Cookie("option", request.getParameter("selectedOption"));
		selectedOption.setMaxAge(60 * 60);
		selectedOption.setPath("/JEEx7");
		response.addCookie(selectedOption);
	}
		} else {
	if (request.getCookies() != null) {
		Cookie[] cookies = request.getCookies();

		for (Cookie c : cookies) {
			if (c.getName().equals("userName")) {
				c.setMaxAge(0);
				c.setPath("/JEEx7");
			}
			if (c.getName().equals("password")) {
				c.setMaxAge(0);
				c.setPath("/JEEx7");
			}
			if (c.getName().equals("save")) {
				c.setMaxAge(0);
				c.setPath("/JEEx7");
			}
			response.addCookie(c);
		}
	}
		}
		session.setAttribute("authenicatedUser", userName);
		session.setAttribute("authenicated", true);
		session.setMaxInactiveInterval(60);

		response.sendRedirect("index.jsp");
	} else {
		errors.add("Attempt failed!");
	}

}

if (request.getCookies() != null) {
	Cookie[] cookies = request.getCookies();

	for (Cookie c : cookies) {
		if (c.getName().equals("userName")) {
	userName = c.getValue();
		}
		if (c.getName().equals("password")) {
	password = c.getValue();
		}
		if (c.getName().equals("save")) {
	pref = Boolean.parseBoolean(c.getValue());
		}
		if (c.getName().equals("option")) {
	option = Integer.parseInt(c.getValue());
		}
	}
} else {
	userName = "";
	password = "";
	pref = false;
}
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<%@include file="WEB-INF/jspf/header.jspf"%>
</head>
<body>
	<div class="centered">
		<div class="left-align">
			<h1 class="centered-content">Login</h1>
			<%--Implementation here--%>
			<div class="inner-centered">
				<div class="form">
					<form name="form1" method="post" action="login.jsp">
						<table>
							<tr>
								<td class="width-100">User:</td>
								<td class="width-300"><input name="txtUserName"
									class="width-300" value='<%=userName%>' /></td>
							</tr>
							<tr>
								<td class="width-100">Password:</td>
								<td class="width-300"><input type="password"
									name="txtPassword" class="width-300" value='<%=password%>' /></td>
							</tr>
							<tr>
								<td class="width-100">Selection:</td>
								<td class="width-300"><select name="selectedOption"
									class="width-300">
										<option value="0">--Select an Option--</option>
										<% for(int i = 1; i < 4; i++){ %>
										<option value="<%=i%>" <%if (option == i) {%>selected<%} %>>Option <%=i%></option>
										<%} %>
								</select></td>
							</tr>
							<tr>
								<td><input type="checkbox" name="chkSave" value=''
									<%if (pref) {%> checked <%}%> />Save</td>
								<td><input type="submit" name="btnLogin" value="Login"
									class="btn btn-primary" /></td>
							</tr>
							<tr>
								<td colspan="2">
									<div>
										<%
										if (errors.size() > 0) {
										%>
										<ul>
											<%
											for (String e : errors) {
											%>
											<li><%=e%></li>
											<%
											}
											%>
										</ul>
										<%
										}
										%>
									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
