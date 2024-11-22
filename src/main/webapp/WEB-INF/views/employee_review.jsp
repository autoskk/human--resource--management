<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>人力资源档案复核</title>
</head>
<body>
<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>

<h1>人力资源档案复核</h1>
<table border="1">
  <tr>
    <th>档案编号</th>
    <th>姓名</th>
    <th>操作</th>
  </tr>
  <c:forEach var="employee" items="${pendingReviews}">
    <tr>
      <td>${employee.recordId}</td>
      <td>${employee.name}</td>
      <td>
        <a href="employee" onclick="return confirm('确认审核通过？')">通过</a>
        <a href="employee" onclick="return confirm('确认审核失败？')">拒绝</a>
      </td>
    </tr>
  </c:forEach>
</table>
</body>
</html>
