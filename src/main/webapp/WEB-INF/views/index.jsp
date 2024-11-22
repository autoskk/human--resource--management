<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>主页</title>
</head>
<body>
<h1>欢迎来到人力资源管理系统</h1>
<a href="${pageContext.request.contextPath}/employee/register">登记员工</a>
<a href="${pageContext.request.contextPath}/employee/list">查看员工列表</a>
<a href="${pageContext.request.contextPath}/employee/review">审核员工</a>
<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>
</body>
</html>
