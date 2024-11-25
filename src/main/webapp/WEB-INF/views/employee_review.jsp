<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>人力资源档案复核</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 20px;
    }
    h1 {
      color: #333;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      padding: 10px;
      border: 1px solid #ddd;
      text-align: left;
    }
    th {
      background-color: #f2f2f2;
    }
    a {
      display: inline-block;
      margin: 10px;
      padding: 5px 10px;
      background-color: #28a745;
      color: white;
      text-decoration: none;
      border-radius: 5px;
    }
    a:hover {
      background-color: #218838;
    }
  </style>
</head>
<body>

<h1>人力资源档案复核</h1>

<table>
  <thead>
  <tr>
    <th>档案编号</th>
    <th>姓名</th>
    <th>性别</th>
    <th>状态</th>
    <th>操作</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="employee" items="${pendingReviews}">
    <tr>
      <td>${employee.recordId}</td>
      <td>${employee.employeeName}</td>
      <td>${employee.gender}</td>
      <td>${employee.status}</td>
      <td>
        <a href="${pageContext.request.contextPath}/employee/review/${employee.recordId}">复核</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>

</body>
</html>
