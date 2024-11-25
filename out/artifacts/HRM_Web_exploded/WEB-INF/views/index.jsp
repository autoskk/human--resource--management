<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>主页</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 20px;
      text-align: center;
    }
    h1 {
      color: #333;
      margin-bottom: 30px;
    }
    a {
      display: inline-block;
      margin: 10px;
      padding: 12px 20px;
      background-color: #007bff;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      transition: background-color 0.3s;
    }
    a:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<h1>欢迎来到人力资源管理系统</h1>
<a href="${pageContext.request.contextPath}/employee/register">登记员工</a>
<a href="${pageContext.request.contextPath}/employee/list">查看员工列表</a>
<a href="${pageContext.request.contextPath}/employee/review">审核员工</a>
<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>
</body>
</html>
