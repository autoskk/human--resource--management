<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pojo.EmployeeRecord" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>人力资源档案变更</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 20px;
      position: relative;
    }
    h1 {
      color: #333;
    }
    form {
      background: #fff;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      margin-bottom: 20px;
    }
    .form-group {
      display: flex;
      align-items: center;
      margin: 10px 0;
    }
    label {
      font-weight: bold;
      padding-right: 10px;
      flex: 0 0 120px;
    }
    input[type="text"],
    input[type="email"],
    input[type="tel"],
    input[type="number"],
    textarea {
      flex: 1;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    input[type="submit"] {
      background-color: #28a745;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      float: right;
    }
    input[type="submit"]:hover {
      background-color: #218838;
    }
    .photo-container {
      position: absolute;
      top: 20px;
      right: 20px;
      border: 2px solid #ccc;
      border-radius: 5px;
      padding: 10px;
      text-align: center;
      background-color: #fff;
      max-width: 220px;
    }
    #photoDropZone {
      border: 2px dashed #ccc;
      border-radius: 5px;
      padding: 10px;
      margin-bottom: 10px;
      cursor: pointer;
    }
    #photoPreview {
      display: none;
      margin-bottom: 10px;
    }
    #photoPreview img {
      width: 100%;
      height: auto;
    }
    #photoUrl {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
  </style>
  <script>
    $(document).ready(function() {
      var dropZone = $('#photoDropZone');
      dropZone.on('dragover', function(event) {
        event.preventDefault();
        dropZone.addClass('hover');
      });

      dropZone.on('dragleave', function() {
        dropZone.removeClass('hover');
      });

      dropZone.on('drop', function(event) {
        event.preventDefault();
        dropZone.removeClass('hover');

        var files = event.originalEvent.dataTransfer.files;
        if (files.length > 0) {
          var file = files[0];
          var reader = new FileReader();
          reader.onload = function(e) {
            $('#photoUrl').val(e.target.result);
            $('#photoPreview img').attr('src', e.target.result);
            $('#photoPreview').show();
          }
          reader.readAsDataURL(file);
        }
      });
    });
  </script>
</head>
<body>
<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>
<h1>人力资源档案变更</h1>
<%
  EmployeeRecord employeeRecord = (EmployeeRecord) request.getAttribute("employee");
%>
<form action="${pageContext.request.contextPath}/employee/update" method="post">

  <input type="hidden" name="recordId" value="<%= employeeRecord.getRecordId() %>"/>

  <div class="form-group">
    <label>档案编号:</label>
    <span><%= employeeRecord.getRecordId() %></span>
  </div>

  <div class="form-group">
    <label>状态:</label>
    <span><%= employeeRecord.getStatus() %></span>
  </div>

  <div class="form-group">
    <label>登记人:</label>
    <span><%= employeeRecord.getCreatedBy() %></span>
  </div>

  <div class="form-group">
    <label>登记时间:</label>
    <span><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(employeeRecord.getCreatedDate()) %></span>
  </div>

  <div class="form-group">
    <label>一级机构:</label>
    <span><%= request.getAttribute("level1OrgName") %></span>
  </div>

  <div class="form-group">
    <label>二级机构:</label>
    <span><%= request.getAttribute("level2OrgName") %></span>
  </div>

  <div class="form-group">
    <label>三级机构:</label>
    <span><%= request.getAttribute("level3OrgName") %></span>
  </div>

  <div class="form-group">
    <label>职位分类:</label>
    <span><%= request.getAttribute("categoryName") %></span>
  </div>

  <div class="form-group">
    <label>职位:</label>
    <span><%= request.getAttribute("positionName") %></span>
  </div>

  <div class="form-group">
    <label for="employeeName">姓名:</label>
    <input type="text" name="employeeName" id="employeeName" value="<%= employeeRecord.getEmployeeName() %>" required/>
  </div>

  <div class="form-group">
    <label for="gender">性别:</label>
    <select name="gender" id="gender" required>
      <option value="男" <%= "男".equals(employeeRecord.getGender()) ? "selected" : "" %>>男</option>
      <option value="女" <%= "女".equals(employeeRecord.getGender()) ? "selected" : "" %>>女</option>
    </select>
  </div>

  <div class="form-group">
    <label for="email">邮箱:</label>
    <input type="email" name="email" id="email" value="<%= employeeRecord.getEmail() %>" required/>
  </div>

  <div class="form-group">
    <label for="mobile">电话:</label>
    <input type="tel" name="mobile" id="mobile" value="<%= employeeRecord.getMobile() %>" required/>
  </div>

  <div class="form-group">
    <label for="address">地址:</label>
    <input type="text" name="address" id="address" value="<%= employeeRecord.getAddress() %>" required/>
  </div>

  <div class="form-group">
    <label for="age">年龄:</label>
    <input type="number" name="age" id="age" value="<%= employeeRecord.getAge() %>" required/>
  </div>

  <div class="form-group">
    <label for="educationLevel">学历:</label>
    <select name="educationLevel" id="educationLevel" required>
      <option value="本科" <%= "本科".equals(employeeRecord.getEducationLevel()) ? "selected" : "" %>>本科</option>
      <option value="硕士" <%= "硕士".equals(employeeRecord.getEducationLevel()) ? "selected" : "" %>>硕士</option>
      <option value="博士" <%= "博士".equals(employeeRecord.getEducationLevel()) ? "selected" : "" %>>博士</option>
    </select>
  </div>

  <div class="photo-container">
    <div id="photoDropZone">拖放照片至此</div>
    <div id="photoPreview">
      <img src="" alt="预览照片"/>
    </div>
    <input type="text" name="photoUrl" id="photoUrl" placeholder="照片URL" value="<%= employeeRecord.getPhotoUrl() %>" readonly/>
  </div>

  <div class="form-group">
    <label for="major">专业:</label>
    <input type="text" name="major" id="major" value="<%= employeeRecord.getMajor() %>" required/>
  </div>

<%--  <div class="form-group">--%>
<%--    <label for="salaryStandardId">薪资标准:</label>--%>
<%--    <select id="salaryStandardId" name="salaryStandardId" required>--%>
<%--      <option value="" disabled selected>请选择薪资标准</option>--%>
<%--      <c:forEach var="standard" items="${salaryStandards}">--%>
<%--        <option value="${standard.salaryStandardId}" <%= employeeRecord.getSalaryStandardId().equals(standard.getSalaryStandardId()) ? "selected" : "" %>>${standard.standardName}</option>--%>
<%--      </c:forEach>--%>
<%--    </select>--%>
<%--  </div>--%>

  <div class="form-group">
    <label for="bank">开户行:</label>
    <input type="text" name="bank" id="bank" value="<%= employeeRecord.getBank() %>" required/>
  </div>

  <div class="form-group">
    <label for="accountNumber">银行账户:</label>
    <input type="text" name="accountNumber" id="accountNumber" value="<%= employeeRecord.getAccountNumber() %>" required/>
  </div>

  <div class="form-group">
    <label for="personalHistory">个人履历:</label>
    <textarea name="personalHistory" id="personalHistory" rows="5" required><%= employeeRecord.getPersonalHistory() %></textarea>
  </div>

  <input type="submit" value="更新"/>
</form>
</body>
</html>
