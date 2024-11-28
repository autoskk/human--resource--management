<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
  <form action="/salary-distributions/search" method="get">
    <label>薪酬发放单编号:</label>
    <input type="text" name="distributionID" placeholder="请输入发放单编号" />
    <label>关键词:</label>
    <input type="text" name="keyword" placeholder="请输入关键词" />

    <label>起始时间:</label>
    <input type="date" name="startTime" id="startTime" />

    <label>结束时间:</label>
    <input type="date" name="endTime" id="endTime" />

    <button type="submit" class="btn">查询</button>
    <button class="btn" id="createDistribution">创建薪酬发放单</button>
    <button type="button" class="btn" onclick="window.location.href='/salaryManagement'">返回</button>
  </form>
</div>

<table>
  <thead>
  <tr>
    <th>发放单编号</th>
    <th>一级机构名称</th>
    <th>二级机构名称</th>
    <th>三级机构名称</th>
    <th>人数</th>
    <th>基本薪酬总额</th>
    <th>状态</th>
    <th>登记时间</th>
    <th>操作</th>
  </tr>
  </thead>
  <tbody id="distributionsTableBody">
  <c:if test="${not empty salaryDistribution}">
    <c:forEach var="distribution" items="${salaryDistribution}">
      <tr class="distribution-row">
        <td>${distribution.distributionID}</td>
        <td class="level-one-id">${distribution.levelOneId}</td>
        <td class="level-two-id">${distribution.levelTwoId}</td>
        <td class="level-three-id">${distribution.levelThreeId}</td>
        <td>${distribution.numberOfEmployees}</td>
        <td>${distribution.totalBaseSalary}</td>
        <td>${distribution.status}</td>
        <td>
          <fmt:formatDate value="${distribution.registrationTime}" pattern="yyyy-MM-dd" />
        </td>
        <td>
          <!-- 控制按钮的显示 -->
          <button onclick="editDistribution(${distribution.distributionID})" class="edit-btn" style="display:none;">登记</button>
          <button onclick="reviewDistribution(${distribution.distributionID})" class="approve-btn" style="display:none;">复核</button>
          <button onclick="deleteDistribution(${distribution.distributionID})" class="delete-btn" style="display:none;">删除</button>
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
    // 设置当前日期为起始和结束时间的默认值
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('startTime').value = today;
    document.getElementById('endTime').value = today;

    // 获取当前用户信息
    const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));

    // 权限控制
    if (currentUser && currentUser.roleId) {
      const roleId = currentUser.roleId;

      if (roleId === 5) { // 薪酬专员

        // 循环显示可用操作按钮
        $('tr.distribution-row').each(function() {
          const status = $(this).find('td:eq(6)').text().trim(); // 状态列
          if (status === '待登记') {
            $(this).find('.edit-btn').show(); // 显示登记按钮
          }
          $(this).find('.delete-btn').show(); // 显示删除按钮

          let levelOneId = $(this).find('.level-one-id').text().trim();
          let levelTwoId = $(this).find('.level-two-id').text().trim();
          let levelThreeId = $(this).find('.level-three-id').text().trim();

          // 查询一级机构名称
          if (levelOneId) {
            $.get('/organizations/level1/' + levelOneId, function(data) {
              $(this).find('.level-one-id').text(data);
            }.bind(this));
          }

          // 查询二级机构名称
          if (levelTwoId) {
            $.get('/organizations/level2/' + levelTwoId, function(data) {
              $(this).find('.level-two-id').text(data);
            }.bind(this));
          }

          // 查询三级机构名称
          if (levelThreeId) {
            $.get('/organizations/level3/' + levelThreeId, function(data) {
              $(this).find('.level-three-id').text(data);
            }.bind(this));
          }
        });
      } else if (roleId === 6) { // 薪酬经理

        // 循环显示可用操作按钮
        $('tr.distribution-row').each(function() {
          const status = $(this).find('td:eq(6)').text().trim(); // 状态列
          if (status === '待复核') {
            $(this).find('.approve-btn').show(); // 显示复核按钮
          }
          $(this).find('.delete-btn').show(); // 显示删除按钮

          let levelOneId = $(this).find('.level-one-id').text().trim();
          let levelTwoId = $(this).find('.level-two-id').text().trim();
          let levelThreeId = $(this).find('.level-three-id').text().trim();

          // 查询一级机构名称
          if (levelOneId) {
            $.get('/organizations/level1/' + levelOneId, function(data) {
              $(this).find('.level-one-id').text(data);
            }.bind(this));
          }

          // 查询二级机构名称
          if (levelTwoId) {
            $.get('/organizations/level2/' + levelTwoId, function(data) {
              $(this).find('.level-two-id').text(data);
            }.bind(this));
          }

          // 查询三级机构名称
          if (levelThreeId) {
            $.get('/organizations/level3/' + levelThreeId, function(data) {
              $(this).find('.level-three-id').text(data);
            }.bind(this));
          }
        });

      }
    }

    $('#createDistribution').click(function() {
      window.location.href = '/createDistribution'; // 假设登记页面的URL
    });
  });

  function editDistribution(distributionID) {
    fetch('/salary-distributions/getDistribution/' + distributionID)
            .then(response => response.json())
            .then(data => {
              localStorage.setItem('distributionData', JSON.stringify(data));
              window.location.href = '/employees/compensation/getEmployeeCompensationEdit/' + distributionID;
            })
            .catch(error => console.error('获取信息失败:', error));
  }

  function reviewDistribution(distributionID) {
    fetch('/salary-distributions/getDistribution/' + distributionID)
            .then(response => response.json())
            .then(data => {
              localStorage.setItem('distributionData', JSON.stringify(data));
              window.location.href = '/employees/compensation/getEmployeeCompensationPending/' + distributionID;
            })
            .catch(error => console.error('获取信息失败:', error));
  }

  function deleteDistribution(distributionID) {
    if (confirm('确定要删除该薪资发放单吗？')) {
      fetch('/salary-distributions/' + distributionID, { method: 'DELETE' })
              .then(response => response.text())
              .then(data => {
                alert(data);
                window.location.href = '/salary-distributions';
              })
              .catch(error => alert('删除失败: ' + error));
    }
  }
</script>

</body>
</html>
