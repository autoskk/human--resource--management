<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>编辑薪资标准</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4; }
    form { background: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
    label { display: block; margin: 10px 0 5px; }
    input[type="text"], input[type="number"] {
      width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 4px;
    }
    input[readonly] {
      background-color: #f0f0f0; /* 只读字段背景 */
    }
    .btn { background-color: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer; }
    .btn:hover { background-color: #0056b3; }
    .alert { color: green; margin-bottom: 15px; }
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
  <input type="text" id="status" name="status" value="${salaryStandard.status} " readonly/>
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

  <button type="submit" class="btn">提交</button>
  <button type="button" class="btn" onclick="window.location.href='/salary-standards'">返回</button>
</form>

</body>
</html>