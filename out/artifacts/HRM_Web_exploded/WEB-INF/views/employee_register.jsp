<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>人力资源档案登记</title>
</head>
<body>
<h1>人力资源档案登记</h1>
<form action="employee" method="post">
    <input type="hidden" name="action" value="register"/>
    姓名: <input type="text" name="name" required/><br/>
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
    <!-- Continue with other education levels -->
</select><br/>
    所属机构:
    <select name="level1Id">
        <option value="" disabled selected>请选择一级机构</option>
        <!-- Populate dynamically -->
    </select>
    <select name="level2Id">
        <option value="" disabled selected>请选择二级机构</option>
        <!-- Populate dynamically based on level1Id -->
    </select>
    <select name="level3Id">
        <option value="" disabled selected>请选择三级机构</option>
        <!-- Populate dynamically based on level2Id -->
    </select><br/>
    职位类别:
    <select name="categoryId">
        <option value="" disabled selected>请选择职位类别</option>
        <!-- Populate from database -->
    </select>
    职位:
    <select name="positionId">
        <option value="" disabled selected>请选择职位</option>
        <!-- Populate from database -->
    </select><br/>
    照片URL: <input type="text" name="photoUrl"/><br/>
    <input type="submit" value="提交"/>
</form>
</body>
</html>
