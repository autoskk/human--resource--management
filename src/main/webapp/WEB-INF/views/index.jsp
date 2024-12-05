<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh-CN" dir="ltr">

<head>
  <meta charset="utf-8">
  <title>人力资源管理系统</title>
  <style media="screen">
    a:link {
      text-decoration: none;
    }

    body {
      margin: 0;
      padding: 0;
      font-family: "Roboto", sans-serif;
      background-color: #f8f9fa; /* 轻微背景色，提供视觉振奋 */
    }

    header {
      position: fixed;
      background: #ffffff; /* 将导航栏背景设置为白色 */
      padding: 20px;
      width: 100%;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
      z-index: 1;
    }

    .left_area h3 {
      color: #333; /* 改为较深的颜色以适应新的背景 */
      margin: 0;
      text-transform: uppercase;
      font-size: 22px;
      font-weight: 900;
    }

    .logout_btn {
      padding: 5px;
      background: #19B3D3; /* 保持颜色，以突出显示 */
      text-decoration: none;
      float: right;
      margin-top: -30px;
      margin-right: 40px;
      border-radius: 2px;
      font-size: 15px;
      font-weight: 600;
      color: #fff;
      transition: 0.5s;
      cursor: pointer;
    }

    .logout_btn:hover {
      background: #0B87A6;
    }

    .sidebar {
      background: #ffffff; /* 将侧边栏背景设置为白色 */
      margin-top: 70px;
      padding-top: 30px;
      position: fixed;
      left: 0;
      width: 250px;
      height: 100%;
      box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* 添加阴影与立体感 */
      transition: 0.5s;
    }

    .sidebar .profile_image {
      width: 100px;
      height: 100px;
      border-radius: 100px;
      margin-bottom: 10px;
    }

    .sidebar h4 {
      color: #333; /* 统一文本颜色 */
      margin-top: 0;
      margin-bottom: 20px;
    }

    .sidebar a {
      color: #333; /* 改为较深的颜色以适应新的背景 */
      display: block;
      width: 100%;
      line-height: 60px;
      text-decoration: none;
      padding-left: 40px;
      box-sizing: border-box;
      transition: 0.5s;
    }

    .sidebar a:hover {
      background: #19B3D3; /* 保持原有悬停效果 */
      color: #fff; /* 悬停背景下文本颜色变为白色 */
    }

    label #sidebar_btn {
      z-index: 1;
      color: #333; /* 改为较深的颜色以适应新的背景 */
      position: fixed;
      cursor: pointer;
      left: 300px; /* 根据布局需调整 */
      font-size: 20px;
      margin: 5px 0;
      transition: 0.5s;
    }

    label #sidebar_btn:hover {
      color: #19B3D3;
    }

    #check {
      display: none;
    }

    /* 收缩侧边栏的样式 */
    #check:checked ~ .sidebar {
      left: -190px; /* 收缩的宽度 */
    }

    #check:checked ~ .sidebar a span {
      display: none; /* 隐藏文字 */
    }

    #check:checked ~ .sidebar a {
      font-size: 20px;
      margin-left: 170px; /* 调整以保持图标的位置 */
      width: 80px; /* 调整宽度 */
    }

    /* 隐藏子菜单 */
    .submenu {
      display: none;
      padding-left: 20px;
    }

    .submenu a {
      line-height: 40px; /* 子菜单项的高度 */
      color: #333; /* 文本颜色 */
    }

    .content {
      margin-left: 250px;
      padding: 20px;
      background: #ffffff; /* 内容区域背景颜色 */
      height: 100vh;
      transition: 0.5s;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 添加阴影 */
    }

    #check:checked ~ .content {
      margin-left: 60px; /* 内容区的 margin 调整 */
    }

    /* 增加模块描述样式 */
    .module-description {
      background: #f9f9f9; /* 模块描述背景颜色 */
      border: 1px solid #ddd;
      border-radius: 5px;
      padding: 15px;
      margin-bottom: 20px;
      transition: box-shadow 0.3s;
    }

    .module-description:hover {
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
    }

    h2 {
      color: #333;
      font-size: 24px;
      margin-bottom: 15px;
      text-align: center;
    }

    h3 {
      color: #2c3e50;
      font-size: 20px;
      margin-top: 30px;
      margin-bottom: 10px;
      border-bottom: 2px solid #19B3D3;
      padding-bottom: 5px;
    }

    p {
      color: #666;
      line-height: 1.5;
      margin-bottom: 15px;
    }

    ul {
      list-style-type: disc;
      padding-left: 20px;
    }

    .quick-actions {
      background: #e0f7fa;
      padding: 15px;
      border-radius: 5px;
      margin-top: 10px;
    }

    .quick-actions li {
      margin: 10px 0;
      font-size: 16px;
    }

    .quick-actions a {
      color: #00796b;
      text-decoration: none;
      font-weight: bold;
    }

    .quick-actions a:hover {
      text-decoration: underline;
      color: #004d40;
    }
  </style>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
</head>

<body>
<input type="checkbox" id="check">
<header>
  <label for="check">
    <i class="fas fa-bars" id="sidebar_btn"></i>
  </label>
  <div class="left_area">
    <h3>人力资源管理系统</h3>
  </div>
  <div class="right_area">
    <a href="javascript:void(0);" class="logout_btn" id="logoutButton" onclick="handleLoginLogout()">登录</a>
  </div>
</header>

<div class="sidebar">
  <div style="text-align: center;">
    <img src="https://img95.699pic.com/xsj/10/gk/q8.jpg!/fh/300" class="profile_image" alt="">
    <h4 id="createdBy"></h4>
  </div>

  <a href="${pageContext.request.contextPath}/employee/home"><i class="fas fa-home"></i><span>首页</span></a>

  <a href="javascript:void(0);" onclick="toggleSubmenu('hrManagement');">
    <i class="fas fa-address-card"></i><span>人力资源档案管理</span></a>
  <div id="hrManagement" class="submenu">
    <a href="javascript:void(0);" onclick="checkAccess('register')">档案登记</a>
    <a href="javascript:void(0);" onclick="checkAccess('list')">档案列表</a>
    <a href="javascript:void(0);" onclick="checkAccess('review')">档案复核</a>
  </div>

  <a href="javascript:void(0);" onclick="toggleSubmenu('salaryManagement');">
    <i class="fas fa-money-check"></i><span>薪酬管理</span></a>
  <div id="salaryManagement" class="submenu">
    <a href="javascript:void(0);" onclick="checkAccess('salaryDistributionManagement')">薪酬发放管理</a>
    <a href="javascript:void(0);" onclick="checkAccess('salaryStandardManagement')">薪酬标准管理</a>
  </div>
</div>

<div class="content">
  <h2>欢迎使用人力资源管理系统！</h2>
  <p>请从左侧菜单选择功能模块，以便更高效地管理人力资源相关事务。</p>

  <h3>模块简介</h3>

  <div class="module-description">
    <p><strong>人力资源档案管理：</strong>管理人员档案的登记、审核、查询、更新及标记删除等。此模块提供全面的员工信息管理功能，让您轻松维护所有员工的个人资料。</p>
    <ul>
      <li>档案登记：快速录入新员工的基本信息。</li>
      <li>档案审核：对新的档案信息进行审核，确保准确性。</li>
      <li>信息更新：及时更新员工信息，保持数据的新鲜度。</li>
      <li>档案查询：支持根据多种条件快速检索员工档案。</li>
    </ul>
  </div>

  <div class="module-description">
    <p><strong>薪酬管理：</strong>管理薪酬标准的设置、薪酬发放的登记及复核。确保每位员工的薪资公正合理，及时准确。</p>
    <ul>
      <li>薪酬标准设定：为不同岗位制定清晰的薪资标准。</li>
      <li>薪资发放管理：记录发放情况，方便随时查看。</li>
      <li>发放复核：确保所有薪资信息的正确性，减少错误发生。</li>
      <li>查询员工薪资情况：提供详细的查询功能，让管理者和HR能够快速检查员工薪资记录与发放情况。</li>
      <li>薪资发放单导入：根据已有员工信息导入薪资发放单，提高数据处理效率。</li>
    </ul>
  </div>

  <br><br><br>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  function toggleSubmenu(id) {
    var submenu = document.getElementById(id);
    var checkbox = document.getElementById('check');

    if (!checkbox.checked) {
      submenu.style.display = submenu.style.display === "block" ? "none" : "block";
    } else {
      checkbox.checked = false;  // 展开导航栏
      submenu.style.display = submenu.style.display === "block" ? "none" : "block";
    }
  }

  document.getElementById('check').addEventListener('change', function () {
    if (this.checked) {
      var submenus = document.querySelectorAll('.submenu');
      submenus.forEach(function(submenu) {
        submenu.style.display = 'none'; // 隐藏子菜单
      });
    }
  });

  function handleLoginLogout() {
    const currentUserJson = sessionStorage.getItem('currentUser');
    if (currentUserJson) {
      logout();
    } else {
      window.location.href = "/login";
    }
  }

  function logout() {
    sessionStorage.removeItem('currentUser');
    $('#createdBy').text('');
    $('#logoutButton').text('登录');
    alert("已登出");
  }

  function checkAccess(action) {
    const currentUserJson = sessionStorage.getItem('currentUser');
    if (!currentUserJson) {
      alert("请先登录才能访问此页面。");
      return;
    }
    const currentUser = JSON.parse(currentUserJson);

    const roleAccess = {
      register: [3],
      review: [4],
      list: [3, 4],
      salaryDistributionManagement: [5, 6],
      salaryStandardManagement: [5, 6]
    };

    if (roleAccess[action] && roleAccess[action].includes(currentUser.roleId)) {
      var targetUrl="";
      if(action=="register"||action=="review"||action=="list"){
       targetUrl = "/employee/" + action;

      }
      else{
       targetUrl = "/" + action;
      }
      window.location.href = targetUrl;
    } else {
      alert("您没有权限访问此页面。");
    }
  }

  $(document).ready(function () {
    const currentUserJson = sessionStorage.getItem('currentUser');
    if (currentUserJson) {
      const currentUser = JSON.parse(currentUserJson);
      $('#createdBy').text(currentUser.userName);
      $('#logoutButton').text('登出');
    }
  });
</script>

</body>
</html>
