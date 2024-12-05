<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pojo.EmployeeRecord" %>
<%@ page import="com.example.pojo.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>人力资源档案变更</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <style>
    body {
      background-color: #e9ecef;
    }
    .container {
      margin-top: 50px;
    }
    h1 {
      text-align: center;
      color: #007bff;
    }
    .form-section {
      margin-bottom: 1.5rem;
    }
    .bg-white {
      background-color: #ffffff;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    label {
      font-weight: bold;
      color: #343a40;
    }
    .highlight {
      color: #007bff;
      font-weight: bold;
    }
    .flex-container {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
    }
    .info-col {
      flex: 1;
      padding-right: 20px;
    }
    .photo-container {
      display: flex;
      flex-direction: column; /* 垂直布局 */
      align-items: center; /* 水平居中 */
    }
    .photo-preview {
      width: 180px;
      height: 180px;
      border-radius: 50%;
      overflow: hidden;
      border: 2px solid #007bff;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 10px; /* 照片和输入框之间留出空间 */
      cursor: pointer; /* 鼠标悬停时显示为可点击 */
    }
    .photo-preview img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .photo-upload-input {
      display: none; /* 隐藏 input 元素 */
    }
    .btn-custom {
      background-color: #007bff;
      color: white;
    }
    .btn-custom:hover {
      background-color:  #0056b3;
      transform: translateY(-2px); /* 悬停提升效果 */
    }
  </style>
  <script>
    $(document).ready(function() {
      const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));
      const userRoleId = currentUser ? currentUser.roleId : null;

      var isEditable = (userRoleId === 3);

      if (isEditable) {
        $('input, select').prop('readonly', false).prop('disabled', false);
        $('.btn-success').show();
      } else {
        $('input, select').prop('readonly', true).prop('disabled', true);
        $('.btn-success').hide();
        $('#noPermission').show();
      }

      $('#photoUpload').change(function(event) {
        const file = event.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function(e) {
            $('#photoPreview img').attr('src', e.target.result);
          }
          reader.readAsDataURL(file);
        }
      });

      // 点击图片触发文件输入框
      $('#photoPreview').click(function() {
        $('#photoUpload').click();
      });
    });
  </script>
</head>
<body>
<div class="container">
  <a class="btn btn-secondary mb-4" href="${pageContext.request.contextPath}/employee/list"><i class="fas fa-arrow-left"></i> 返回</a>
  <h1 class="text-center">人力资源档案变更</h1>
  <%
    EmployeeRecord employeeRecord = (EmployeeRecord) request.getAttribute("employee");
    User currentUser = (User) session.getAttribute("currentUser");
    boolean isEditable = currentUser != null && currentUser.getRoleId() == 3;
  %>

  <form action="${pageContext.request.contextPath}/employee/update" method="post" enctype="multipart/form-data" class="p-4 bg-white">
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

    <div class="flex-container">
      <div class="info-col">
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
      </div>

      <div class="photo-container">
        <div class="photo-preview" id="photoPreview">
          <img src="${employee.photoUrl}" alt="当前照片" />
        </div>
        <label for="photoUpload" class="d-block text-center">更换照片</label>
        <input type="file" id="photoUpload" name="photoUpload" class="photo-upload-input" accept="image/*" />
      </div>
    </div>

    <div class="form-section">
      <div class="row">
        <div class="col-md-6">
          <label for="employeeName">姓名:</label>
          <input type="text" name="employeeName" id="employeeName" class="form-control" value="<%= employeeRecord.getEmployeeName() %>" required/>
        </div>
        <div class="col-md-6">
          <label for="gender">性别:</label>
          <select name="gender" id="gender" class="form-control" required>
            <option value="男" <%= "男".equals(employeeRecord.getGender()) ? "selected" : "" %>>男</option>
            <option value="女" <%= "女".equals(employeeRecord.getGender()) ? "selected" : "" %>>女</option>
          </select>
        </div>
      </div>
    </div>
    <div class="form-section">
      <div class="row">
        <div class="col-md-6">
          <label for="email">邮箱:</label>
          <input type="email" name="email" id="email" class="form-control" value="<%= employeeRecord.getEmail() %>" required/>
        </div>
        <div class="col-md-6">
          <label for="mobile">电话:</label>
          <input type="tel" name="mobile" id="mobile" class="form-control" value="<%= employeeRecord.getMobile() %>" required/>
        </div>
      </div>
    </div>
    <div class="form-section">
      <div class="row">
        <div class="col-md-6">
          <label for="address">地址:</label>
          <input type="text" name="address" id="address" class="form-control" value="<%= employeeRecord.getAddress() %>" required/>
        </div>
        <div class="col-md-6">
          <label for="age">年龄:</label>
          <input type="number" name="age" id="age" class="form-control" value="<%= employeeRecord.getAge() %>" required/>
        </div>
      </div>
    </div>
    <div class="form-section">
      <div class="row">
        <div class="col-md-6">
          <label for="educationLevel">学历:</label>
          <select name="educationLevel" id="educationLevel" class="form-control" required>
            <option value="本科" <%= "本科".equals(employeeRecord.getEducationLevel()) ? "selected" : "" %>>本科</option>
            <option value="硕士" <%= "硕士".equals(employeeRecord.getEducationLevel()) ? "selected" : "" %>>硕士</option>
            <option value="博士" <%= "博士".equals(employeeRecord.getEducationLevel()) ? "selected" : "" %>>博士</option>
          </select>
        </div>
        <div class="col-md-6">
          <label for="major">专业:</label>
          <input type="text" name="major" id="major" class="form-control" value="<%= employeeRecord.getMajor() %>" required/>
        </div>
      </div>
    </div>
    <div class="form-section">
      <div class="row">
        <div class="col-md-6">
          <label for="salaryStandardId">薪资标准:</label>
          <select name="salaryStandardId" id="salaryStandardId" class="form-control">
            <option value="" disabled selected>${requestScope.standardName}</option>
            <c:forEach var="salaryStandard" items="${salaryStandards}">
              <option value="${salaryStandard.salaryStandardID}"
                      <c:if test="${salaryStandard.salaryStandardID == employee.salaryStandardId}">selected</c:if>
              >${salaryStandard.standardName}</option>
            </c:forEach>
          </select>
        </div>
        <div class="col-md-6">
          <label for="bank">开户行:</label>
          <input type="text" name="bank" id="bank" class="form-control" value="<%= employeeRecord.getBank() %>" required/>
        </div>
      </div>
    </div>
    <div class="form-section">
      <div class="row">
        <div class="col-md-6">
          <label for="accountNumber">银行账户:</label>
          <input type="text" name="accountNumber" id="accountNumber" class="form-control" value="<%= employeeRecord.getAccountNumber() %>" required/>
        </div>
        <!-- 这里留空以确保个人履历独占一行 -->
        <div class="col-md-6"></div>
      </div>
    </div>
    <div class="form-section">
      <label for="personalHistory">个人履历:</label>
      <textarea name="personalHistory" id="personalHistory" class="form-control" rows="5" required><%= employeeRecord.getPersonalHistory() %></textarea>
    </div>



    <input type="submit" value="更新" class="btn btn-custom mt-3"/>
  </form>
</div>
</body>
</html>