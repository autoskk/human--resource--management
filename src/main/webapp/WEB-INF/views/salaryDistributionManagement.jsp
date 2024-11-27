<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>薪资发放管理</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

<h2>薪资发放管理</h2>
<div>
  <label>薪酬发放单编号:</label>
  <input type="text" id="searchDistributionID" placeholder="请输入发放单编号" />
  <button class="btn" id="searchDistribution">查询</button>
  <button class="btn" id="createDistribution">创建薪酬发放单</button>
  <button type="button" class="btn" onclick="window.location.href='salaryManagement'">返回</button>
</div>

<table>
  <thead>
  <tr>
    <th>发放单编号</th>
    <th>一级机构 ID</th>
    <th>二级机构 ID</th>
    <th>三级机构 ID</th>
    <th>人数</th>
    <th>基本薪酬总额</th>
    <th>状态</th>
    <th>操作</th>
  </tr>
  </thead>
  <tbody id="distributionsTableBody">
  <c:if test="${not empty salaryDistribution}">
    <c:forEach var="distribution" items="${salaryDistribution}">
      <tr>
        <td>${distribution.distributionID}</td>
        <td>${distribution.levelOneId}</td>
        <td>${distribution.levelTwoId}</td>
        <td>${distribution.levelThreeId}</td>
        <td>${distribution.numberOfEmployees}</td>
        <td>${distribution.totalBaseSalary}</td>
        <td>${distribution.status}</td>
        <td>
          <button onclick="editDistribution(${distribution.distributionID})">编辑</button>
          <button onclick="reviewDistribution(${distribution.distributionID})">复核</button>
          <button onclick="deleteDistribution(${distribution.distributionID})">删除</button>
        </td>
      </tr>
    </c:forEach>
  </c:if>

  <c:if test="${empty salaryDistribution}">
    <tr>
      <td colspan="8" style="text-align: center;">没有可显示的薪资发放单</td>
    </tr>
  </c:if>
  </tbody>
</table>

<script>
  $(document).ready(function() {

    $('#searchDistribution').click(function() {
      loadSalaryDistributions($('#searchDistributionID').val());
    });

    $('#createDistribution').click(function() {
      window.location.href = '/createDistribution'; // 假设登记页面的URL
    });
  });

  function loadSalaryDistributions(distributionID) {
    window.location.href = '/salary-distributions/' + distributionID; // 跳转到编辑页面
  }

  function editDistribution(id) {
    window.location.href = '/salary-distributions/' + id; // 跳转到编辑页面
  }

  function reviewDistribution(id) {
    window.location.href = '/salary-distributions/review/' + id; // 跳转到复核页面
  }

  function deleteDistribution(id) {
    if (confirm('确定要删除该薪资发放单吗？')) {
      fetch('/salary-distributions/' + id, { method: 'DELETE' })
              .then(response => response.text())
              .then(data => {
                alert(data);
                loadSalaryDistributions(); // 重新加载数据
              })
              .catch(error => alert('删除失败: ' + error));
    }
  }
</script>

</body>
</html>
