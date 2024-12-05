<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>人力资源档案复核</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

  <style>
    body {
      background-color: #f4f4f4;
    }
    h1 {
      text-align: center;
      color: #007bff;
    }
    .table th, .table td {
      vertical-align: middle; /* 位置垂直对齐 */
    }
    .btn-review {
      background-color: #007bff;
      color: white;
    }
    .btn-review:hover {
      background-color:  #0056b3;
      transform: translateY(-2px); /* 悬停提升效果 */
    }
  </style>

  <script>
    $(document).ready(function() {
      // 当页面加载时，为每一行的机构 ID 查询对应的名称
      $('tr.employee_list').each(function () {
        let levelOneId = $(this).find('.level-one-id').text().trim();
        let levelTwoId = $(this).find('.level-two-id').text().trim();
        let levelThreeId = $(this).find('.level-three-id').text().trim();
        let positionId = $(this).find('.position-id').text().trim();

        // 查询机构和职位名称
        if (levelOneId) {
          $.get('/organizations/level1/' + levelOneId, function (data) {
            $(this).find('.level-one-id').text(data);
          }.bind(this));
        }
        if (levelTwoId) {
          $.get('/organizations/level2/' + levelTwoId, function (data) {
            $(this).find('.level-two-id').text(data);
          }.bind(this));
        }
        if (levelThreeId) {
          $.get('/organizations/level3/' + levelThreeId, function (data) {
            $(this).find('.level-three-id').text(data);
          }.bind(this));
        }
        if (positionId) {
          $.get('/organizations/position/' + positionId, function (data) {
            $(this).find('.position-id').text(data);
          }.bind(this));
        }
      });
    });
  </script>
</head>
<body>

<div class="container mt-5">
  <a class="btn btn-secondary mb-4" href="${pageContext.request.contextPath}/employee/home"><i class="fas fa-arrow-left"></i> 返回主页</a>
  <h1>人力资源档案复核</h1>

  <table class="table table-striped">
    <thead class="thead-light">
    <tr>
      <th>档案编号</th>
      <th>姓名</th>
      <th>性别</th>
      <th>一级机构</th>
      <th>二级机构</th>
      <th>三级机构</th>
      <th>职位名称</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="employee" items="${pendingReviews}">
      <tr class="employee_list">
        <td>${employee.recordId}</td>
        <td>${employee.employeeName}</td>
        <td>${employee.gender}</td>
        <td class="level-one-id">${employee.level1Id}</td>
        <td class="level-two-id">${employee.level2Id}</td>
        <td class="level-three-id">${employee.level3Id}</td>
        <td class="position-id">${employee.positionId}</td>
        <td>
          <a href="${pageContext.request.contextPath}/employee/review/${employee.recordId}" class="btn btn-review">复核</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>


</div>

</body>
</html>
