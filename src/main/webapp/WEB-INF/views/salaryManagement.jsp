<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>薪酬管理系统</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4; }
    nav { background-color: #007bff; color: white; padding: 10px; text-align: center; }
    nav a { color: white; margin: 0 15px; text-decoration: none; cursor: pointer; } /* Changed to cursor pointer */
  </style>
</head>
<body>

<nav>
  <h1>薪酬管理系统</h1>
  <a href="/salaryStandardManagement">薪资标准管理</a>
  <a href="/salaryDistributionManagement">薪资发放管理</a>
</nav>

<div class="container">
  <h2>欢迎来到薪酬管理系统</h2>
</div>

<%--<script>--%>
<%--  // 当文档加载完成后执行--%>
<%--  document.addEventListener('DOMContentLoaded', function() {--%>
<%--    // 获取当前用户信息--%>
<%--    const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));--%>


<%--    // 自动重定向到薪资发放管理--%>
<%--    const salaryDistributionLink = document.getElementById('salaryDistributionLink');--%>
<%--    salaryDistributionLink.onclick = function() {--%>
<%--      if (currentUser && currentUser.roleId) {--%>
<%--        const roleId = currentUser.roleId;--%>
<%--        if (roleId === 5) { // 薪酬专员--%>
<%--          window.location.href = '/salary-distributions/status/待登记';--%>
<%--        } else if (roleId === 6) { // 薪酬经理--%>
<%--          window.location.href = '/salary-distributions/status/待复核';--%>
<%--        }--%>
<%--      } else {--%>
<%--        alert('无法识别用户，请重新登录。');--%>
<%--      }--%>
<%--    };--%>
<%--  });--%>
<%--</script>--%>

</body>
</html>
