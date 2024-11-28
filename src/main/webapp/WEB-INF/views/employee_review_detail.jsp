<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.example.pojo.EmployeeRecord" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>审核员工档案</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

  <style>
    body {
      background-color: #f8f9fa; /* 更加柔和的背景色 */
    }
    .form-section {
      margin-bottom: 2rem; /* 增加每个部分之间的间距 */
    }
    #photoPreview {
      margin-top: 10px; /* 照片预览与上方输入框的间距 */
      text-align: center; /* 将照片居中显示 */
    }
    #photoPreview img {
      width: 200px; /* 设置宽度 */
      height: auto; /* 自适应高度 */
      border: 1px solid #ddd; /* 增加边框 */
      border-radius: 4px; /* 圆角 */
    }
    .highlight {
      font-weight: bold; /* 重要信息突出显示 */
    }
  </style>

  <script>
    $(document).ready(function() {
      $('#photoUpload').change(function(event) {
        const file = event.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function(e) {
            $('#photoPreview img').attr('src', e.target.result); // 显示新的照片
          }
          reader.readAsDataURL(file); // 读取文件
        }
      });
    });
  </script>
</head>
<body>
<div class="container mt-5">
  <a href="${pageContext.request.contextPath}/employee/home" class="btn btn-secondary mb-4">返回主页</a>
  <h1 class="my-4 text-center">审核员工档案</h1>

  <%
    EmployeeRecord employeeRecord = (EmployeeRecord) request.getAttribute("employee");
  %>

  <form action="${pageContext.request.contextPath}/employee/review" method="post" enctype="multipart/form-data" class="bg-white p-4 border rounded shadow-sm">
    <input type="hidden" name="recordId" value="<%= employeeRecord.getRecordId() %>"/>
    <input type="hidden" name="createdBy" value="<%= employeeRecord.getCreatedBy() %>"/>
    <input type="hidden" name="createdDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(employeeRecord.getCreatedDate()) %>"/>
    <input type="hidden" name="status" value="<%= employeeRecord.getStatus() %>"/>
    <input type="hidden" name="level1Id" value="<%= employeeRecord.getLevel1Id() %>"/>
    <input type="hidden" name="level2Id" value="<%= employeeRecord.getLevel2Id() %>"/>
    <input type="hidden" name="level3Id" value="<%= employeeRecord.getLevel3Id() %>"/>
    <input type="hidden" name="categoryId" value="<%= employeeRecord.getCategoryId() %>"/>
    <input type="hidden" name="positionId" value="<%= employeeRecord.getPositionId() %>"/>
    <input type="hidden" name="photoUrl" value="<%= employeeRecord.getPhotoUrl() %>"/>

    <div class="form-section">
      <label>档案编号: <span class="highlight"><%= employeeRecord.getRecordId() %></span></label>
    </div>
    <div class="form-section">
      <label>状态: <span class="highlight"><%= employeeRecord.getStatus() %></span></label>
    </div>
    <div class="form-section">
      <label>登记人: <span class="highlight"><%= request.getAttribute("userName") %></span></label>
    </div>
    <div class="form-section">
      <label>登记时间: <span class="highlight"><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(employeeRecord.getCreatedDate()) %></span></label>
    </div>
    <div class="form-section">
      <label>一级机构: <span class="highlight"><%= request.getAttribute("level1OrgName") %></span></label>
    </div>
    <div class="form-section">
      <label>二级机构: <span class="highlight"><%= request.getAttribute("level2OrgName") %></span></label>
    </div>
    <div class="form-section">
      <label>三级机构: <span class="highlight"><%= request.getAttribute("level3OrgName") %></span></label>
    </div>
    <div class="form-section">
      <label>职位分类: <span class="highlight"><%= request.getAttribute("categoryName") %></span></label>
    </div>
    <div class="form-section">
      <label>职位: <span class="highlight"><%= request.getAttribute("positionName") %></span></label>
    </div>

    <div class="form-section">
      <label for="employeeName">姓名:</label>
      <input type="text" name="employeeName" id="employeeName" class="form-control" value="<%= employeeRecord.getEmployeeName() %>" required/>
    </div>

    <div class="form-section">
      <label for="gender">性别:</label>
      <select name="gender" id="gender" class="form-control" required>
        <option value="男" <%= "男".equals(employeeRecord.getGender()) ? "selected" : "" %>>男</option>
        <option value="女" <%= "女".equals(employeeRecord.getGender()) ? "selected" : "" %>>女</option>
      </select>
    </div>

    <div class="form-section">
      <label for="email">邮箱:</label>
      <input type="email" name="email" id="email" class="form-control" value="<%= employeeRecord.getEmail() %>" required/>
    </div>

    <div class="form-section">
      <label for="mobile">电话:</label>
      <input type="tel" name="mobile" id="mobile" class="form-control" value="<%= employeeRecord.getMobile() %>" required/>
    </div>

    <div class="form-section">
      <label for="address">地址:</label>
      <input type="text" name="address" id="address" class="form-control" value="<%= employeeRecord.getAddress() %>" required/>
    </div>

    <div class="form-section">
      <label for="age">年龄:</label>
      <input type="number" name="age" id="age" class="form-control" value="<%= employeeRecord.getAge() %>" required/>
    </div>

    <div class="form-section">
      <label for="educationLevel">学历:</label>
      <select name="educationLevel" id="educationLevel" class="form-control" required>
        <option value="本科" <%= "本科".equals(employeeRecord.getEducationLevel()) ? "selected" : "" %>>本科</option>
        <option value="硕士" <%= "硕士".equals(employeeRecord.getEducationLevel()) ? "selected" : "" %>>硕士</option>
        <option value="博士" <%= "博士".equals(employeeRecord.getEducationLevel()) ? "selected" : "" %>>博士</option>
      </select>
    </div>

    <div class="form-section">
      <label for="photoUpload">更换照片:</label>
      <input type="file" id="photoUpload" name="photoUpload" class="form-control-file" accept="image/*" />
      <div id="photoPreview">
        <img src="${employee.photoUrl}" alt="当前照片" />
      </div>
    </div>

    <div class="form-section">
      <label for="major">专业:</label>
      <input type="text" name="major" id="major" class="form-control" value="<%= employeeRecord.getMajor() %>" required/>
    </div>

    <div class="form-section">
      <label for="salaryStandardId">薪资标准:</label>
      <select name="salaryStandardId" id="salaryStandardId" class="form-control">
        <option value="" disabled selected>${requestScope.standardName}</option>
        <c:forEach var="salaryStandard" items="${salaryStandards}">
          <option value="${salaryStandard.salaryStandardID}" <c:if test="${salaryStandard.salaryStandardID == employee.salaryStandardId}">selected</c:if>>${salaryStandard.standardName}</option>
        </c:forEach>
      </select>
    </div>

    <div class="form-section">
      <label for="bank">开户行:</label>
      <input type="text" name="bank" id="bank" class="form-control" value="<%= employeeRecord.getBank() %>" required/>
    </div>

    <div class="form-section">
      <label for="accountNumber">银行账户:</label>
      <input type="text" name="accountNumber" id="accountNumber" class="form-control" value="<%= employeeRecord.getAccountNumber() %>" required/>
    </div>

    <div class="form-section">
      <label for="personalHistory">个人履历:</label>
      <textarea name="personalHistory" id="personalHistory" class="form-control" rows="5" required><%= employeeRecord.getPersonalHistory() %></textarea>
    </div>

    <input type="submit" value="提交审核" class="btn btn-success mt-3"/>
  </form>
</div>
</body>
</html>
