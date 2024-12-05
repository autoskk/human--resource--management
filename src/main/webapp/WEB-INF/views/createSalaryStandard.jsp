<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>创建薪资标准</title>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // 计算五险一金
        function calculateInsurance() {
            const baseSalary = parseFloat(document.getElementById('baseSalary').value) || 0;

            const pensionInsurance = (baseSalary * 0.08).toFixed(2);
            const medicalInsurance = (baseSalary * 0.02 + 3).toFixed(2);
            const unemploymentInsurance = (baseSalary * 0.005).toFixed(2);
            const housingFund = (baseSalary * 0.08).toFixed(2);

            document.getElementById('pensionInsurance').value = pensionInsurance;
            document.getElementById('medicalInsurance').value = medicalInsurance;
            document.getElementById('unemploymentInsurance').value = unemploymentInsurance;
            document.getElementById('housingFund').value = housingFund;
        }

        // 页面加载时获取薪酬经理列表
        $(document).ready(function() {
            // 通过 AJAX 获取薪酬经理列表
            $.ajax({
                url: '/users/roleId/6',
                type: 'GET',
                success: function(managers) {
                    managers.forEach(function(manager) {
                        $('#creator').append(new Option(manager.userName, manager.userName));
                    });
                },
                error: function() {
                    alert('无法加载薪酬经理列表。');
                }
            });

            // 设置当前用户信息
            const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));
            if (currentUser) {
                document.getElementById('registrar').value = currentUser.userName; // 登记人只读
            }
        });

        // 处理表单提交
        function handleSubmit(event) {
            event.preventDefault(); // 阻止默认提交

            const formData = {
                standardName: document.getElementById('standardName').value,
                creator: document.getElementById('creator').value, // 从下拉框获取值
                registrar: document.getElementById('registrar').value,
                baseSalary: parseFloat(document.getElementById('baseSalary').value) || 0.00,
            };

            fetch('/salary-standards/create', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            })
                .then(response => {
                    if (response.ok) {
                        alert('薪酬标准创建成功');
                        window.location.href = '/salary-standards';
                    } else {
                        return response.text().then(text => {
                            alert('薪酬标准创建失败: ' + text);
                        });
                    }
                })
                .catch(error => alert('薪酬标准创建失败: ' + error.message));
        }
    </script>
</head>
<body>
<h2>创建薪资标准</h2>
<form onsubmit="handleSubmit(event)">
    <label for="standardName">薪资标准名称:</label>
    <input type="text" id="standardName" name="standardName" required>

    <label for="creator">制定人:</label>
    <select id="creator" name="creator" required>
        <option value="">请选择薪酬经理</option>
        <!-- 薪酬经理列表将通过JS动态填充 -->
    </select>

    <label for="registrar">登记人:</label>
    <input type="text" id="registrar" name="registrar" readonly>

    <label for="baseSalary">基本工资:</label>
    <input type="number" id="baseSalary" name="baseSalary" step="0.01" required oninput="calculateInsurance()">

    <label for="pensionInsurance">养老金:</label>
    <input type="number" id="pensionInsurance" name="pensionInsurance" step="0.01" readonly>

    <label for="medicalInsurance">医疗保险:</label>
    <input type="number" id="medicalInsurance" name="medicalInsurance" step="0.01" readonly>

    <label for="unemploymentInsurance">失业保险:</label>
    <input type="number" id="unemploymentInsurance" name="unemploymentInsurance" step="0.01" readonly>

    <label for="housingFund">住房公积金:</label>
    <input type="number" id="housingFund" name="housingFund" step="0.01" readonly>

    <div class="button-group">
        <button type="submit" class="btn">提交</button>
        <button type="button" class="btn" onclick="window.location.href='/salary-standards'">返回</button>
    </div>
</form>

</body>
</html>
