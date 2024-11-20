<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
</head>
<body>
<h1>员工列表</h1>
<table border="1">
    <tr>
        <th>档案编号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>邮箱</th>
        <th>操作</th>
    </tr>
    <c:forEach var="employee" items="${employees}">
        <tr>
            <td>${employee.recordId}</td>
            <td>${employee.employeeName}</td>
            <td>${employee.gender}</td>
            <td>${employee.email}</td>
            <td>
                <a href="employee?recordId=${employee.recordId}&action=update">编辑</a>
                <a href="employee?recordId=${employee.recordId}&action=delete">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="employee?action=form">添加员工</a>
</body>
</html>
