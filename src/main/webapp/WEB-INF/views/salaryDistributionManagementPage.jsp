<%--
  Created by IntelliJ IDEA.
  User: He yu fan
  Date: 2024/11/28
  Time: 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script>
    // 当文档加载完成后执行
    document.addEventListener('DOMContentLoaded', function() {
        // 获取当前用户信息
        const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));

        // 权限控制
        if (currentUser && currentUser.roleId) {
            const roleId = currentUser.roleId;

            if (roleId === 5) { // 薪酬专员
                window.location.href = '/salary-distributions/status/待登记';
            } else if (roleId === 6) { // 薪酬经理
                window.location.href = '/salary-distributions/status/待复核';
            }
        } else {
            alert('没有权限！');
        }
    });
</script>
</body>
</html>
