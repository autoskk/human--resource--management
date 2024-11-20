<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 当一级机构改变时，加载二级机构
            $('#queryLevel1Id').change(function() {
                var level1Id = $(this).val();
                $.get("/employee/level2", { level1Id: level1Id }, function(data) {
                    $("#queryLevel2Id").empty().append('<option value="" disabled selected>请选择二级机构</option>');
                    $.each(data, function(index, level2) {
                        $("#queryLevel2Id").append('<option value="' + level2.level2Id + '">' + level2.level2Name + '</option>');
                    });
                    $("#queryLevel3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>'); // 清空三级机构
                });
            });

            // 当二级机构改变时，加载三级机构
            $('#queryLevel2Id').change(function() {
                var level2Id = $(this).val();
                $.get("/employee/level3", { level2Id: level2Id }, function(data) {
                    $("#queryLevel3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>');
                    $.each(data, function(index, level3) {
                        $("#queryLevel3Id").append('<option value="' + level3.level3Id + '">' + level3.level3Name + '</option>');
                    });
                });
            });

            // 当职位类别改变时，加载职位
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
<h1>员工列表</h1>

<form action="/employee/list" method="get">
    所属机构:
    <select id="queryLevel1Id" name="level1Id">
        <option value="" disabled selected>请选择一级机构</option>
        <c:forEach var="level1" items="${level1Organizations}">
            <option value="${level1.level1Id}">${level1.level1Name}</option>
        </c:forEach>
    </select>

    <select id="queryLevel2Id" name="level2Id">
        <option value="" disabled selected>请选择二级机构</option>
    </select>

    <select id="queryLevel3Id" name="level3Id">
        <option value="" disabled selected>请选择三级机构</option>
    </select><br/>

    职位类别:
    <select id="queryCategoryId" name="categoryId">
        <option value="" disabled selected>请选择职位类别</option>
        <c:forEach var="category" items="${positionCategories}">
            <option value="${category.categoryId}">${category.categoryName}</option>
        </c:forEach>
    </select>

    职位:
    <select id="queryPositionId" name="positionId">
        <option value="" disabled selected>请选择职位</option>
    </select><br/>

    建档时间:
    <input type="date" name="startDate"/> -
    <input type="date" name="endDate"/><br/>

    <input type="submit" value="查询"/>
</form>

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
