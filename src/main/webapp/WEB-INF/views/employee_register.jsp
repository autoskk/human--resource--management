<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>人力资源档案登记</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#level1Id').change(function() {
                var level1Id = $(this).val();
                $.get("/employee/level2", { level1Id: level1Id }, function(data) {
                    $("#level2Id").empty().append('<option value="" disabled selected>请选择二级机构</option>');
                    $.each(data, function(index, level2) {
                        $("#level2Id").append('<option value="' + level2.level2Id + '">' + level2.level2Name + '</option>');
                    });
                    $("#level3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>');
                });
            });

            $('#level2Id').change(function() {
                var level2Id = $(this).val();
                $.get("/employee/level3", { level2Id: level2Id }, function(data) {
                    $("#level3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>');
                    $.each(data, function(index, level3) {
                        $("#level3Id").append('<option value="' + level3.level3Id + '">' + level3.level3Name + '</option>');
                    });
                });
            });

            $('#categoryId').change(function() {
                var categoryId = $(this).val();
                $.get("/employee/positions", { categoryId: categoryId }, function(data) {
                    $("#positionId").empty().append('<option value="" disabled selected>请选择职位</option>');
                    $.each(data, function(index, position) {
                        $("#positionId").append('<option value="' + position.positionId + '">' + position.positionName + '</option>');
                    });
                });
            });
        });
    </script>
</head>
<body>
<h1>人力资源档案登记</h1>
<form action="/employee/register" method="post">
    姓名: <input type="text" name="employeeName" required/><br/>
    性别: <select name="gender">
    <option value="男">男</option>
    <option value="女">女</option>
</select><br/>
    邮箱: <input type="email" name="email" required/><br/>
    电话: <input type="tel" name="mobile" required/><br/>
    地址: <input type="text" name="address" required/><br/>
    年龄: <input type="number" name="age" required/><br/>
    学历: <select name="educationLevel">
    <option value="本科">本科</option>
    <option value="硕士">硕士</option>
</select><br/>

    所属机构:
    <select id="level1Id" name="level1Id" required>
        <option value="" disabled selected>请选择一级机构</option>
        <c:forEach var="level1" items="${level1Organizations}">
            <option value="${level1.level1Id}">${level1.level1Name}</option>
        </c:forEach>
    </select>

    <select id="level2Id" name="level2Id" required>
        <option value="" disabled selected>请选择二级机构</option>
    </select>

    <select id="level3Id" name="level3Id" required>
        <option value="" disabled selected>请选择三级机构</option>
    </select><br/>

    职位类别:
    <select id="categoryId" name="categoryId" required>
        <option value="" disabled selected>请选择职位类别</option>
        <c:forEach var="category" items="${positionCategories}">
            <option value="${category.categoryId}">${category.categoryName}</option>
        </c:forEach>
    </select>

    职位:
    <select id="positionId" name="positionId" required>
        <option value="" disabled selected>请选择职位</option>
    </select><br/>

    照片URL: <input type="text" name="photoUrl"/><br/>
    专业: <input type="text" name="major" required/><br/>
    薪资标准: <input type="number" step="0.01" name="salaryStandard" required/><br/>
    开户行: <input type="text" name="bank" required/><br/>
    银行账户: <input type="text" name="accountNumber" required/><br/>
    个人履历: <textarea name="personalHistory" required></textarea><br/>
    <input type="submit" value="提交"/>
</form>
</body>
</html>
