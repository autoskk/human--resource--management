<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.example.pojo.EmployeeRecord" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>审核员工档案</title>
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
    #photoPreview {
      margin-top: 10px; /* 确保有间距 */
    }

    #photoPreview img {
      display: none; /* 初始隐藏 */
      width: 200px; /* 设置宽度 */
      height: auto; /* 自适应高度 */
      border: 1px solid #ddd; /* 增加边框以便于查看 */
      border-radius: 4px; /* 圆角 */
    }
  </style>
  <script>
    $(document).ready(function() {
      $('#photoUpload').change(function(event) {
        const file = event.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function(e) {
            // 显示新选择的照片
            $('#photoPreview img').attr('src', e.target.result).show();
          }
          reader.readAsDataURL(file); // 读取文件
        }
      });
    });
  </script>
</head>
<body>
<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>
<h1>审核员工档案</h1>
<%
  EmployeeRecord employeeRecord = (EmployeeRecord) request.getAttribute("employee");
%>
<form action="${pageContext.request.contextPath}/employee/review" method="post" enctype="multipart/form-data">

  <input type="hidden" name="recordId" value="<%= employeeRecord.getRecordId() %>"/>
  <input type="hidden" name="createdBy" value="<%= employeeRecord.getCreatedBy() %>"/>
  <input type="hidden" name="createdDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(employeeRecord.getCreatedDate()) %>"/>
  <input type="hidden" name="status" value="<%= employeeRecord.getStatus() %>"/>
  <input type="hidden" name="level1Id" value="<%= employeeRecord.getLevel1Id() %>"/>
  <input type="hidden" name="level2Id" value="<%= employeeRecord.getLevel2Id() %>"/>
  <input type="hidden" name="level3Id" value="<%= employeeRecord.getLevel3Id() %>"/>
  <input type="hidden" name="categoryId" value="<%= employeeRecord.getCategoryId() %>"/>
  <input type="hidden" name="positionId" value="<%= employeeRecord.getPositionId() %>"/>
  <%--  <input type="hidden" name="salaryStandardId" value="<%= employeeRecord.getSalaryStandardId() %>"/>--%>
<%--  <input type="hidden" name="photoUrl" value="<%= employeeRecord.getPhotoUrl() %>"/>--%>

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
    <span><%= request.getAttribute("userName") %></span>
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

  <div class="form-group">
    <label for="photoUpload">更换照片:</label>
    <input type="file" id="photoUpload" name="photoUpload" accept="image/*" />
    <div id="photoPreview">
      <img src="${employee.photoUrl}" alt="当前照片" style="width: 200px; height: auto; display: block;"/>
    </div>
  </div>

  <div class="form-group">
    <label for="major">专业:</label>
    <input type="text" name="major" id="major" value="<%= employeeRecord.getMajor() %>" required/>
  </div>

  <div class="form-group">
    <label for="salaryStandardId">薪资标准</label>
    <select name="salaryStandardId" id="salaryStandardId">
      <option value="" disabled selected>${requestScope.standardName}</option>
      <c:forEach var="salaryStandard" items="${salaryStandards}">
        <option value="${salaryStandard.salaryStandardID}"
                <c:if test="${salaryStandard.salaryStandardID == employee.salaryStandardId}">selected</c:if>
        >${salaryStandard.standardName}</option>
      </c:forEach>
    </select>
  </div>

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


  <input type="submit" value="提交审核"/>
</form>
</body>
</html>
