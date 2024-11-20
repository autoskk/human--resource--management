<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pojo.EmployeeRecord" %>
<html>
<head>
  <title>人力资源档案变更</title>
</head>
<body>
<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>

<h1>人力资源档案变更</h1>
<%
  // Assume employeeRecord is fetched based on recordId parameter
  EmployeeRecord employeeRecord = (EmployeeRecord) request.getAttribute("employee");
%>
<form action="${pageContext.request.contextPath}/employee/update" method="post">
  <input type="hidden" name="action" value="update"/>
  <input type="hidden" name="recordId" value="<%= employeeRecord.getRecordId() %>"/>
  姓名: <input type="text" name="name" value="<%= employeeRecord.getEmployeeName() %>" required/><br/>
  <!-- Include other necessary fields in a similar manner -->
  <input type="submit" value="更新"/>
</form>
</body>
</html>
