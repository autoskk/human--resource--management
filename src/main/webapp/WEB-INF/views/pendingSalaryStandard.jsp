<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="zh-CN" dir="ltr">

<head>
  <meta charset="utf-8">
  <title>编辑薪资标准</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
      padding: 40px;
      padding-top: 120px; /* 添加这个属性来保障内容不被导航栏覆盖 */
      background: #ffffff; /* 内容区域背景颜色 */
      height: calc(100vh - 100px); /* 减去导航栏高度，确保内容区域不溢出 */
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

    h2 {
      text-align: center;
      color: #007bff;
      margin-bottom: 20px;
      font-size: 24px; /* 增大标题字体 */
    }

    form {
      background-color: #ffffff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .form-row {
      display: flex;
      justify-content: space-between;
      gap: 20px; /* 控制两列之间的间距 */
    }

    .form-group {
      flex: 1; /* 使每个输入部分均分 */
      min-width: 200px; /* 设置最小宽度 */
    }

    .search-form {
      display: flex;
      flex-direction: column;
      gap: 10px; /* 表单各部分间隔 */
    }

    label {
      display: block;
      margin: 15px 0 5px;
      font-weight: bold; /* 加粗标签 */
      color: #333; /* 改进标签颜色 */
    }

    input[type="text"],
    input[type="number"],
    select {
      width: 100%;
      padding: 12px; /* 增加填充 */
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
      transition: border-color 0.3s;
      font-size: 16px; /* 增加字体大小 */
    }

    input[type="text"]:focus,
    input[type="number"]:focus,
    select:focus {
      border-color: #007bff; /* 输入框聚焦时改变边框颜色 */
      outline: none; /* 去掉默认的聚焦outline */
    }

    input[readonly] {
      background-color: #f0f0f0; /* 只读字段背景 */
    }

    .button-group {
      display: flex;
      justify-content: center; /* 水平居中 */
      margin-top: 20px; /* 为按钮组添加上边距 */
    }

    .btn {
      margin: 0 10px; /* 为按钮添加左右间距 */
      background-color: #007bff;
      color: white;
      padding: 12px; /* 增加按钮内边距 */
      border: none;
      border-radius: 8px; /* 增加圆角 */
      cursor: pointer;
      margin: 10px 1%; /* 添加间距 */
      transition: background-color 0.3s, transform 0.3s; /* 增加动画效果 */
      font-size: 16px; /* 统一按钮字体大小 */
    }

    .btn:hover {
      background-color: #0056b3; /* 悬停效果 */
      transform: translateY(-2px); /* 悬停提升效果 */
    }

    /* 添加响应式设计 */
    @media (max-width: 768px) {
      form {
        padding: 20px;
      }

      .btn {
        width: 100%; /* 移动设备上按钮全宽 */
        margin: 5px 0; /* 重新设置按钮间距 */
      }
    }

    textarea {
      width: 100%; /* 使其宽度适应父元素 */
      padding: 10px; /* 内边距 */
      border: 1px solid #ced4da; /* 边框样式 */
      border-radius: 4px; /* 圆角 */
      resize: vertical; /* 允许用户垂直调整大小 */
    }
  </style>

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
  <h2>编辑薪资标准</h2>
  <c:if test="${not empty message}">
    <div class="alert">${message}</div>
    <!-- 显示编辑提示信息 -->
  </c:if>
  <form action="/salary-standards/edit" method="post">
    <div class="form-row">
      <div class="form-group">
        <label for="standardName">薪资标准名称:</label>
        <input type="text" id="standardName" name="standardName" value="${salaryStandard.standardName}"
               readonly/>
      </div>
      <div class="form-group">
        <label for="creator">制定人:</label>
        <input type="text" id="creator" name="creator" value="${salaryStandard.creator}" readonly>
      </div>
      <div class="form-group">
        <label for="registrar">登记人:</label>
        <input type="text" id="registrar" name="registrar" value="${salaryStandard.registrar}" readonly/>
      </div>
      <div class="form-group">
        <div class="button-group">
          <button type="button" class="btn" onclick="updateStatus('已复核')">接受</button>
          <button type="button" class="btn" onclick="updateStatus('待登记')">拒绝</button>
          <button type="button" class="btn" onclick="window.location.href='/salary-standards'">返回</button>
        </div>
      </div>

    </div>

    <div class="form-row">
      <div class="form-group">
        <label for="baseSalary">基本工资:</label>
        <input type="number" id="baseSalary" name="baseSalary" value="${salaryStandard.baseSalary}" step="0.01"
               readonly oninput="calculateInsurance()"/>
      </div>
      <div class="form-group">
        <label for="pensionInsurance">养老金:</label>
        <input type="number" id="pensionInsurance" name="pensionInsurance"
               value="${salaryStandard.pensionInsurance}" readonly/>
      </div>
      <div class="form-group">
        <label for="medicalInsurance">医疗保险:</label>
        <input type="number" id="medicalInsurance" name="medicalInsurance"
               value="${salaryStandard.medicalInsurance}" readonly/>
      </div>
      <div class="form-group">
        <label for="unemploymentInsurance">失业保险:</label>
        <input type="number" id="unemploymentInsurance" name="unemploymentInsurance"
               value="${salaryStandard.unemploymentInsurance}" readonly/>
      </div>
      <div class="form-group">
        <label for="housingFund">住房公积金:</label>
        <input type="number" id="housingFund" name="housingFund" value="${salaryStandard.housingFund}"
               readonly/>
      </div>
    </div>

    <div class="form-row">
      <div class="form-group">
        <label for="reviewComment">复核意见:</label>
        <textarea id="reviewComment" name="reviewComment" required>${salaryStandard.reviewComment}</textarea>
      </div>
      <div class="form-group">
        <label for="status">状态:</label>
        <input type="text" id="status" name="status" value="${salaryStandard.status}" readonly/>
      </div>
    </div>

    <input type="hidden" name="salaryStandardID" value="${salaryStandard.salaryStandardID}"/>

  </form>
</div>

<script>
  function toggleSubmenu(id) {
    function calculateInsurance() {
      const baseSalary = parseFloat(document.getElementById('baseSalary').value) || 0;

      // 计算五险一金
      const pensionInsurance = (baseSalary * 0.08).toFixed(2);
      const medicalInsurance = (baseSalary * 0.02 + 3).toFixed(2);
      const unemploymentInsurance = (baseSalary * 0.005).toFixed(2);
      const housingFund = (baseSalary * 0.08).toFixed(2);

      // 设置计算结果
      document.getElementById('pensionInsurance').value = pensionInsurance;
      document.getElementById('medicalInsurance').value = medicalInsurance;
      document.getElementById('unemploymentInsurance').value = unemploymentInsurance;
      document.getElementById('housingFund').value = housingFund;
    }

    // 页面加载时计算之前的保险值
    window.onload = function() {
      calculateInsurance(); // 页面加载时自动计算五险一金
    }

    function updateStatus(newStatus) {
      // 更新状态字段的值
      document.getElementById('status').value = newStatus;
      // 提交表单
      document.forms[0].submit();
    }

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
    window.location.href="/index";
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


