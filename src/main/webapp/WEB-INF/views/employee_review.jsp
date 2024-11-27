<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>人力资源档案复核</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 20px;
    }
    h1 {
      color: #333;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      padding: 10px;
      border: 1px solid #ddd;
      text-align: left;
    }
    th {
      background-color: #f2f2f2;
    }
    a {
      display: inline-block;
      margin: 10px;
      padding: 5px 10px;
      background-color: #28a745;
      color: white;
      text-decoration: none;
      border-radius: 5px;
    }
    a:hover {
      background-color: #218838;
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

        // 查询一级机构名称
        if (levelOneId) {
          $.get('/organizations/level1/' + levelOneId, function (data) {
            $(this).find('.level-one-id').text(data);
          }.bind(this));
        }

        // 查询二级机构名称
        if (levelTwoId) {
          $.get('/organizations/level2/' + levelTwoId, function (data) {
            $(this).find('.level-two-id').text(data);
          }.bind(this));
        }

        // 查询三级机构名称
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
      })
    })


  </script>

</head>
<body>

<h1>人力资源档案复核</h1>

<table>
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
        <a href="${pageContext.request.contextPath}/employee/review/${employee.recordId}">复核</a>
      </td>
    </tr>
  </c:forEach>
</table>

<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>

</body>
</html>
