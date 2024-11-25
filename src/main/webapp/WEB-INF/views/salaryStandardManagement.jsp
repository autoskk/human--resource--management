<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>薪资标准管理</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4; }
    table { width: 100%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background-color: #007bff; color: white; }
    .btn { background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }
  </style>
</head>
<body>

<h2>薪资标准管理</h2>
<div>
  <form action="/salary-standards/search" method="get">
    <label>薪资标准 ID:</label>
    <input type="number" name="salaryStandardID" placeholder="请输入薪资标准 ID" />

    <label>关键词:</label>
    <input type="text" name="keyword" placeholder="请输入关键词" />

    <label>起始时间:</label>
    <input type="date" name="startTime" id="startTime" />

    <label>结束时间:</label>
    <input type="date" name="endTime" id="endTime" />

    <button type="submit" class="btn">查询</button>
    <button type="button" class="btn" id="createStandard" style="display: none;">创建薪资标准</button>
    <button type="button" class="btn" onclick="window.location.href='salaryManagement'">返回</button>
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
          <button onclick="registrationStandard(${standard.salaryStandardID})"
                  class="registration-btn"
                  style="display: none;">登记</button>
          <button onclick="editStandard(${standard.salaryStandardID})"
                  class="edit-btn"
                  style="display: none;">编辑</button>
          <button onclick="approveStandard(${standard.salaryStandardID})"
                  class="approve-btn"
                  style="display: none;">复核</button>
          <button onclick="deleteStandard(${standard.salaryStandardID})"
                  class="delete-btn"
                  style="display: none;">删除</button>
        </td>
      </tr>
    </c:forEach>
  </c:if>

  <c:if test="${empty salaryStandards}">
    <tr>
      <td colspan="13" style="text-align: center;">没有可显示的薪资标准</td>
    </tr>
  </c:if>
</table>

<script>
  // 默认设置
  document.addEventListener('DOMContentLoaded', function () {
    // 设置当前日期为起始和结束时间的默认值
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('startTime').value = today;
    document.getElementById('endTime').value = today;

    // 获取当前用户信息
    const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));

    // 权限控制
    if (currentUser && currentUser.roleId) {
      const roleId = currentUser.roleId;

      if (roleId === 5) { // 薪酬专员的角色ID
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
