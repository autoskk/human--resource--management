<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>薪资标准管理</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    body {
      font-family: 'Arial', sans-serif;
      margin: 0;
      padding: 20px;
      background-color: #e9ecef;
      color: #343a40;
    }
    h2 {
      text-align: center;
      color: #007bff;
      margin-bottom: 20px;
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
      font-weight: bold;
    }
    input[type="number"], input[type="text"], input[type="date"] {
      padding: 10px;
      border: 1px solid #ced4da;
      border-radius: 4px;
      width: 100%;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      background-color: #ffffff;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: left;
    }
    th {
      background-color: #007bff;
      color: white;
    }
    tr:hover {
      background-color: #f1f1f1;
    }
    td button {
      padding: 5px 10px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .button-group {
      display: flex;
      justify-content: center; /* 水平居中 */
      margin-top: 0px; /* 为按钮组添加上边距 */
    }

    .btn {
      margin: 0 10px; /* 为按钮添加左右间距 */
      background-color: #007bff;
      color: white;
      padding: 0px; /* 增加按钮内边距 */
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
    .btn:last-child {
      margin-right: 0; /* 最后一个按钮不使用右外边距 */
    }

    .btn:hover {
      background-color: #0056b3;
    }

    .btn-large {
      font-size: 16px; /* 增加字体大小以提高可读性 */
      padding: 12px 24px; /* 调整按钮的内边距 */
    }
    .registration-btn { background: #28a745; color: white; }
    .edit-btn { background: #ffc107; color: white; }
    .approve-btn { background: #17a2b8; color: white; }
    .delete-btn { background: #dc3545; color: white; }
    .registration-btn:hover { background: #218838; }
    .edit-btn:hover { background: #e0a800; }
    .approve-btn:hover { background: #138496; }
    .delete-btn:hover { background: #c82333; }
  </style>
</head>
<body>

<h2>薪资标准管理</h2>
<div>
  <form action="/salary-standards/search" method="get" class="search-form">
    <div class="form-row">
      <div class="form-group">
        <label>薪资标准 ID:</label>
        <input type="number" name="salaryStandardID" placeholder="请输入薪资标准 ID" />
      </div>
      <div class="form-group">
        <div class="button-group">
          <button type="submit" class="btn btn-large">查询</button>
          <button type="button" class="btn btn-large" id="createStandard" style="display: none;">创建薪资标准</button>
          <button type="button" class="btn btn-large" onclick="window.location.href='/index'">返回</button>
        </div>
      </div>
    </div>
    <div class="form-row">
      <div class="form-group">
        <label>关键词:</label>
        <input type="text" name="keyword" placeholder="请输入关键词" />
      </div>
    </div>
    <div class="form-row">
      <div class="form-group">
        <label>起始时间:</label>
        <input type="date" name="startTime" id="startTime" />
      </div>
      <div class="form-group">
        <label>结束时间:</label>
        <input type="date" name="endTime" id="endTime" />
      </div>
    </div>
    <input type="hidden" name="status" id="status" />


  </form>
</div>

<table>
  <thead>
  <tr>
    <th>编号</th>
    <th>薪资标准名称</th>
    <th>创建人</th>
    <th>登记人</th>
    <th>登记时间</th>
    <th>复核意见</th>
    <th>状态</th>
    <th>基本工资</th>
    <th>养老金</th>
    <th>医疗保险</th>
    <th>失业保险</th>
    <th>住房公积金</th>
    <th>操作</th>
  </tr>
  </thead>
  <tbody>
  <c:if test="${not empty salaryStandards}">
    <c:forEach var="standard" items="${salaryStandards}">
      <tr>
        <td>${standard.salaryStandardID}</td>
        <td>${standard.standardName}</td>
        <td>${standard.creator}</td>
        <td>${standard.registrar}</td>
        <td>
          <fmt:formatDate value="${standard.registrationTime}" pattern="yyyy-MM-dd" />
        </td>
        <td>${standard.reviewComment}</td>
        <td>${standard.status}</td>
        <td>${standard.baseSalary}</td>
        <td>${standard.pensionInsurance != null ? standard.pensionInsurance : '—'}</td>
        <td>${standard.medicalInsurance != null ? standard.medicalInsurance : '—'}</td>
        <td>${standard.unemploymentInsurance != null ? standard.unemploymentInsurance : '—'}</td>
        <td>${standard.housingFund != null ? standard.housingFund : '—'}</td>
        <td>
          <button onclick="registrationStandard(${standard.salaryStandardID})" class="registration-btn" style="display: none;">登记</button>
          <button onclick="editStandard(${standard.salaryStandardID})" class="edit-btn" style="display: none;">编辑</button>
          <button onclick="approveStandard(${standard.salaryStandardID})" class="approve-btn" style="display: none;">复核</button>
          <button onclick="deleteStandard(${standard.salaryStandardID})" class="delete-btn" style="display: none;">删除</button>
        </td>
      </tr>
    </c:forEach>
  </c:if>

  <c:if test="${empty salaryStandards}">
    <tr>
      <td colspan="13" style="text-align: center;">没有可显示的薪资标准</td>
    </tr>
  </c:if>
  </tbody>
</table>

<script>
  // 默认设置
  document.addEventListener('DOMContentLoaded', function () {
    // 设置当前日期为起始和结束时间的默认值
    // const today = new Date().toISOString().split('T')[0];
    // document.getElementById('startTime').value = today;
    // document.getElementById('endTime').value = today;

    // 获取当前用户信息
    const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));

    // 权限控制
    if (currentUser && currentUser.roleId) {
      const roleId = currentUser.roleId;

      if (roleId === 5) { // 薪酬专员的角色ID
        document.getElementById('status').value = "待登记";
        document.getElementById('createStandard').style.display = 'inline'; // 创建按钮显示

        // 循环显示可用操作
        document.querySelectorAll('.registration-btn').forEach(button => {
          const status = button.closest('tr').children[6].textContent; // 状态列
          if (status === '待登记') {
            button.style.display = 'inline'; // 显示登记按钮
          }
        });

        document.querySelectorAll('.edit-btn').forEach(button => {
          button.style.display = 'inline'; // 显示编辑按钮
        });
      } else if (roleId === 6) { // 薪酬经理的角色ID
        document.getElementById('status').value = "待复核";
        // 循环显示可用操作
        document.querySelectorAll('.approve-btn').forEach(button => {
          const status = button.closest('tr').children[6].textContent; // 状态列
          if (status === '待复核') {
            button.style.display = 'inline'; // 显示复核按钮
          }
        });

        document.querySelectorAll('.delete-btn').forEach(button => {
          button.style.display = 'inline'; // 显示删除按钮
        });
      }
    }
  });

  // 创建薪资标准的逻辑
  document.getElementById('createStandard').onclick = function() {
    window.location.href = '/createSalaryStandard'; // 跳转到创建薪资标准的页面
  }

  function registrationStandard(id) {
    if (confirm('确定要登记该薪资标准吗？')) {
      fetch('/salary-standards/registration/' + id, {
        method: 'PUT'
      })
              .then(response => response.text())
              .then(data => {
                alert(data);
                window.location.reload(); // 刷新页面以获取最新数据
              })
              .catch(error => alert('登记失败: ' + error));
    }
  }

  function deleteStandard(id) {
    if (confirm('确定要删除该薪资标准吗？')) {
      fetch('/salary-standards/' + id, {
        method: 'DELETE'
      })
              .then(response => response.text())
              .then(data => {
                alert(data);
                window.location.reload(); // 刷新页面以获取最新数据
              })
              .catch(error => alert('删除失败: ' + error));
    }
  }

  function approveStandard(id) {
    window.location.href = '/salary-standards/review/' + id;
  }

  function editStandard(id) {
    window.location.href = '/salary-standards/' + id; // 跳转到编辑页面
  }

</script>
</body>
</html>
