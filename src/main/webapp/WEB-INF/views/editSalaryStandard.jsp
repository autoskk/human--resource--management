<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>编辑薪资标准</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 20px;
      background-color: #f4f4f4;
    }
    h2 {
      text-align: center;
      color: #007bff;
      margin-bottom: 20px;
      font-size: 24px; /* 增大标题字体 */
    }
    form {
      background: white;
      padding: 30px; /* 增加内边距 */
      border-radius: 10px;  /* 更明显的圆角 */
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      max-width: 600px; /* 设置表单最大宽度 */
      margin: 0 auto; /* 居中表单 */
    }
    label {
      display: block;
      margin: 15px 0 5px;
      font-weight: bold; /* 加粗标签 */
      color: #333; /* 改进标签颜色 */
    }
    input[type="text"],
    input[type="number"],
    select {
      width: 100%;
      padding: 12px; /* 增加填充 */
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
      transition: border-color 0.3s;
      font-size: 16px; /* 增加字体大小 */
    }
    input[type="text"]:focus,
    input[type="number"]:focus,
    select:focus {
      border-color: #007bff; /* 输入框聚焦时改变边框颜色 */
      outline: none; /* 去掉默认的聚焦outline */
    }
    input[readonly] {
      background-color: #f0f0f0; /* 只读字段背景 */
    }
    .button-group {
      display: flex;
      justify-content: center; /* 水平居中 */
      margin-top: 20px; /* 为按钮组添加上边距 */
    }

    .btn {
      margin: 0 10px; /* 为按钮添加左右间距 */
      background-color: #007bff;
      color: white;
      padding: 12px; /* 增加按钮内边距 */
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
  </style>
  <script>
    function calculateInsurance() {
      const baseSalary = parseFloat(document.getElementById('baseSalary').value) || 0;
      // 计算五险一金
      const pensionInsurance = (baseSalary * 0.08).toFixed(2);
      const medicalInsurance = (baseSalary * 0.02 + 3).toFixed(2);
      const unemploymentInsurance = (baseSalary * 0.005).toFixed(2);
      const housingFund = (baseSalary * 0.08).toFixed(2);

      // 设置计算结果
      document.getElementById('pensionInsurance').value = pensionInsurance;
      document.getElementById('medicalInsurance').value = medicalInsurance;
      document.getElementById('unemploymentInsurance').value = unemploymentInsurance;
      document.getElementById('housingFund').value = housingFund;
    }

    // 页面加载时计算之前的保险值
    window.onload = function() {
      calculateInsurance(); // 页面加载时自动计算五险一金
    }
  </script>
</head>
<body>

<h2>编辑薪资标准</h2>
<c:if test="${not empty message}">
  <div class="alert">${message}</div> <!-- 显示编辑提示信息 -->
</c:if>
<form action="/salary-standards/edit" method="post">
  <input type="hidden" name="salaryStandardID" value="${salaryStandard.salaryStandardID}" />

  <label for="status">状态:</label>
  <input type="text" id="status" name="status" value="${salaryStandard.status}" readonly/>

  <label for="standardName">薪资标准名称:</label>
  <input type="text" id="standardName" name="standardName" value="${salaryStandard.standardName}" required/>

  <label for="baseSalary">基本工资:</label>
  <input type="number" id="baseSalary" name="baseSalary" value="${salaryStandard.baseSalary}" step="0.01" required oninput="calculateInsurance()"/>

  <label for="pensionInsurance">养老金:</label>
  <input type="number" id="pensionInsurance" name="pensionInsurance" value="${salaryStandard.pensionInsurance}" readonly/>

  <label for="medicalInsurance">医疗保险:</label>
  <input type="number" id="medicalInsurance" name="medicalInsurance" value="${salaryStandard.medicalInsurance}" readonly/>

  <label for="unemploymentInsurance">失业保险:</label>
  <input type="number" id="unemploymentInsurance" name="unemploymentInsurance" value="${salaryStandard.unemploymentInsurance}" readonly/>

  <label for="housingFund">住房公积金:</label>
  <input type="number" id="housingFund" name="housingFund" value="${salaryStandard.housingFund}" readonly/>

  <label for="reviewComment">复核意见:</label>
  <input type="text" id="reviewComment" name="reviewComment" value="${salaryStandard.reviewComment}" readonly />

  <label for="registrar">登记人:</label>
  <input type="text" id="registrar" name="registrar" value="${salaryStandard.registrar}" readonly/>

  <label for="creator">制定人:</label>
  <input type="text" id="creator" name="creator" value="${salaryStandard.creator}" readonly>

  <div class="button-group">
    <button type="submit" class="btn">提交</button>
    <button type="button" class="btn" onclick="window.location.href='/salary-standards'">返回</button>
  </div>
</form>

</body>
</html>
