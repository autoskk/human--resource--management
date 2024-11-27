<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工列表</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        select, input[type="date"], input[type="submit"] {
            padding: 10px;
            margin: 10px 0;
            width: calc(100% - 22px);
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #fff;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        $(document).ready(function() {
            $('#queryLevel1Id').change(function() {
                var level1Id = $(this).val();
                $.get("/employee/level2", { level1Id: level1Id }, function(data) {
                    $("#queryLevel2Id").empty().append('<option value="" disabled selected>请选择二级机构</option>');
                    $.each(data, function(index, level2) {
                        $("#queryLevel2Id").append('<option value="' + level2.level2Id + '">' + level2.level2Name + '</option>');
                    });
                    $("#queryLevel3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>');
                });
            });

            $('#queryLevel2Id').change(function() {
                var level2Id = $(this).val();
                $.get("/employee/level3", { level2Id: level2Id }, function(data) {
                    $("#queryLevel3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>');
                    $.each(data, function(index, level3) {
                        $("#queryLevel3Id").append('<option value="' + level3.level3Id + '">' + level3.level3Name + '</option>');
                    });
                });
            });

            $('#queryCategoryId').change(function() {
                var categoryId = $(this).val();
                $.get("/employee/positions", { categoryId: categoryId }, function(data) {
                    $("#queryPositionId").empty().append('<option value="" disabled selected>请选择职位</option>');
                    $.each(data, function(index, position) {
                        $("#queryPositionId").append('<option value="' + position.positionId + '">' + position.positionName + '</option>');
                    });
                });
            });
        });
    </script>
</head>
<body>
<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>
<h1>员工列表</h1>

<form action="${pageContext.request.contextPath}/employee/list" method="get">
    <label for="queryLevel1Id">一级机构:</label>
    <select id="queryLevel1Id" name="level1Id">
        <option value="" disabled selected>请选择一级机构</option>
        <c:forEach var="level1" items="${level1Organizations}">
            <option value="${level1.level1Id}">${level1.level1Name}</option>
        </c:forEach>
    </select>

    <label for="queryLevel2Id">二级机构:</label>
    <select id="queryLevel2Id" name="level2Id">
        <option value="" disabled selected>请选择二级机构</option>
    </select>

    <label for="queryLevel3Id">三级机构:</label>
    <select id="queryLevel3Id" name="level3Id">
        <option value="" disabled selected>请选择三级机构</option>
    </select>

    <label for="queryCategoryId">职位类别:</label>
    <select id="queryCategoryId" name="categoryId">
        <option value="" disabled selected>请选择职位类别</option>
        <c:forEach var="category" items="${positionCategories}">
            <option value="${category.categoryId}">${category.categoryName}</option>
        </c:forEach>
    </select>

    <label for="queryPositionId">职位:</label>
    <select id="queryPositionId" name="positionId">
        <option value="" disabled selected>请选择职位</option>
    </select>

    <label>建档时间:</label>
    <input type="date" name="startDate"/> -
    <input type="date" name="endDate"/>

    <input type="submit" value="查询"/>
</form>

<table>
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
                <a href="/employee/update?recordId=${employee.recordId}">编辑</a>
                <a href="/employee/delete?recordId=${employee.recordId}">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="employee?action=form">添加员工</a>
</body>
</html>
