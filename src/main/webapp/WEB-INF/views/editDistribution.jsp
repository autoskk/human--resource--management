<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f4f4f4;
    }

    .form-container, .record-container {
        margin-bottom: 20px;
        padding: 20px;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        text-align: left;
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #f4f4f4;
    }

    button {
        margin-right: 5px;
    }

    .modal {
        display: none; /* Initially hidden */
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0, 0, 0);
        background-color: rgba(0, 0, 0, 0.4);
        padding-top: 60px;
    }

    .modal-content {
        background-color: #fefefe;
        margin: 5% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
    }
</style>

<div class="form-container">
    <h2>登记薪酬发放单</h2>
    <form id="registerDistributionForm">
        <label>发放单编号:</label>
        <input type="text" id="distributionID" name="distributionID" readonly/>

        <label>一级机构:</label>
        <select id="levelOneId" name="levelOneId"  readonly>
            <option value="" disabled selected>请选择一级机构</option>
            <c:forEach var="level1" items="${level1Organizations}">
                <option value="${level1.level1Id}">${level1.level1Name}</option>
            </c:forEach>
        </select>

        <label>二级机构:</label>
        <select id="levelTwoId" name="levelTwoId"  readonly>
            <option value="" disabled selected>请选择二级机构</option>
        </select>

        <label>三级机构:</label>
        <select id="levelThreeId" name="levelThreeId" readonly>
            <option value="" disabled selected>请选择三级机构</option>
        </select>

        <label>人数:</label>
        <input type="number" id="numberOfEmployees" name="numberOfEmployees" readonly/>

        <label>基本薪酬总额:</label>
        <input type="number" id="totalBaseSalary" name="totalBaseSalary" step="0.01" readonly/>

        <label>状态:</label>
        <select name="status" disabled>
            <option value="待登记" selected>待登记</option>
            <option value="待复核">待复核</option>
            <option value="已复核">已复核</option>
        </select>

        <label>登记人:</label>
        <input type="text" name="registrar" readonly/>

        <label>登记时间:</label>
        <input type="text" name="registrationTime" readonly/>

        <div>
            <button type="button" id="saveDistributionButton">保存</button>
            <button type="button" id="registerDistributionButton">登记（待审核状态）</button>
            <button type="button" id="showEmployeeCompensationFormButton">登记员工薪酬信息</button>
            <button type="button" onclick="back()">返回</button>
        </div>
    </form>
</div>

<div class="record-container">
    <h2>员工薪酬信息列表</h2>
    <table id="employeeCompensationTable">
        <thead>
        <tr>
            <th>员工编号</th>
            <th>薪酬标准名称</th>
            <th>姓名</th>
            <th>基本薪资</th>
            <th>养老保险</th>
            <th>医疗保险</th>
            <th>失业保险</th>
            <th>住房公积金</th>
            <th>补助</th>
            <th>奖励奖金</th>
            <th>应扣奖金</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${not empty employeeCompensations}">
            <c:forEach var="record" items="${employeeCompensations}">
                <tr>
                    <td>${record.employeeId}</td>
                    <td class="salaryStandardName">${record.salaryStandardID}</td>
                    <td class="employeeName">${record.salaryStandardID}</td>
                    <td class="baseSalary">${record.baseSalary}</td>
                    <td class="pensionInsurance">${record.pensionInsurance != null ? record.pensionInsurance : '—'}</td>
                    <td class="medicalInsurance">${record.medicalInsurance != null ? record.medicalInsurance : '—'}</td>
                    <td class="unemploymentInsurance">${record.unemploymentInsurance != null ? record.unemploymentInsurance : '—'}</td>
                    <td class="housingFund">${record.housingFund != null ? record.housingFund : '—'}</td>
                    <td>${record.allowances}</td>
                    <td>${record.bonus}</td>
                    <td>${record.deductions}</td>
                    <td>
                        <button onclick="editEmployeeCompensation('${record.employeeId}')">编辑</button>
                        <button onclick="deleteEmployeeCompensation('${record.employeeId}','${record.distributionId}')">
                            删除
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty employeeCompensations}">
            <tr>
                <td colspan="11" style="text-align: center;">没有可显示的员工薪酬信息</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<!-- Employee Compensation Modal -->
<div id="employeeCompensationModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('employeeCompensationModal')">&times;</span>
        <h2>登记员工薪酬信息</h2>
        <form id="employeeCompensationForm">
            <label>员工编号:</label>
            <input type="text" name="employeeId" required/>
            <label>薪酬标准编号:</label>
            <select name="salaryStandardId" id="salaryStandardSelect" onchange="fillSalaryStandardInfo()">
                <option value="">请选择薪酬标准</option>
            </select>
            <label>基本薪资:</label>
            <input type="number" name="baseSalary" id="baseSalary" step="0.01" readonly/>
            <label>养老保险:</label>
            <input type="number" name="pensionInsurance" id="pensionInsurance" step="0.01" readonly/>
            <label>医疗保险:</label>
            <input type="number" name="medicalInsurance" id="medicalInsurance" step="0.01" readonly/>
            <label>失业保险:</label>
            <input type="number" name="unemploymentInsurance" id="unemploymentInsurance" step="0.01" readonly/>
            <label>住房公积金:</label>
            <input type="number" name="housingFund" id="housingFund" step="0.01" readonly/>
            <label>补助:</label>
            <input type="number" name="allowances" step="0.01" value="0.00" required/>
            <label>奖励奖金:</label>
            <input type="number" name="bonus" step="0.01" value="0.00" required/>
            <label>应扣奖金:</label>
            <input type="number" name="deductions" step="0.01" value="0.00" required/>
            <input type="hidden" name="distributionId"/>
            <button type="submit">保存</button>
        </form>
    </div>
</div>

<script>
    $(document).ready(function () {

        // Load distribution data
        loadDistributionData();
        // Generate new distribution ID

        // Load current user info
        const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));
        if (currentUser && currentUser.userName) {
            $('input[name="registrar"]').val(currentUser.userName);
        }

        // // 表单字段输入时触发函数存储到 localStorage
        // $('#registerDistributionForm input, #registerDistributionForm select').on('change input', function() {
        //     saveDistributionData();
        // });

        // Event Handlers
        $('#saveDistributionButton').click(saveDistribution);
        $('#registerDistributionButton').click(registerDistribution);
        $('#showEmployeeCompensationFormButton').click(showEmployeeCompensationForm);

        // Employee Compensation Form Submit
        $('#employeeCompensationForm').submit(function (event) {
            event.preventDefault();
            submitEmployeeCompensation();
        });
    });

    function back() {
        localStorage.removeItem('distributionData');
        const formData = {
            distributionID: $('#distributionID').val(),
            levelOneId: $('#levelOneId').val(),
            levelTwoId: $('#levelTwoId').val(),
            levelThreeId: $('#levelThreeId').val(),
            numberOfEmployees: $('input[name="numberOfEmployees"]').val(),
            totalBaseSalary: parseFloat($('input[name="totalBaseSalary"]').val()) || 0.00,
            status: $('select[name="status"]').val(),
            registrar: $('input[name="registrar"]').val()
        };
        fetch('/salary-distributions/' + formData.distributionID, {
            method: 'PUT',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(formData)
        });
        window.location.href = "/salary-distributions";
    }

    function loadEmployeeCompensations(distributionId) {
        fetch('/employees/compensation/distribution/' + distributionId)
            .then(response => response.json())
            .then(data => {
                let totalBaseSalary = 0;
                let numberOfEmployees = data.length; // 从数据中获取员工数量

                // 创建一个数组用于存储所有的 fetch 请求
                const salaryStandardPromises = data.map((compensation, index) => {
                    // 获取当前行的引用
                    index+=1;
                    const row = document.querySelector('#employeeCompensationTable tbody tr:nth-child('+index+')');

                    // 获取薪酬标准
                    const salaryStandardPromise = fetch('/salary-standards/getStandard/' + compensation.salaryStandardID)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('获取薪水标准失败');
                            }
                            return response.json();
                        })
                        .then(salaryStandard => {
                            // 使用当前行引用填充数据
                            row.querySelector('.salaryStandardName').textContent = salaryStandard.standardName;
                            row.querySelector('.baseSalary').textContent = salaryStandard.baseSalary;
                            row.querySelector('.pensionInsurance').textContent = salaryStandard.pensionInsurance || '—';
                            row.querySelector('.medicalInsurance').textContent = salaryStandard.medicalInsurance || '—';
                            row.querySelector('.unemploymentInsurance').textContent = salaryStandard.unemploymentInsurance || '—';
                            row.querySelector('.housingFund').textContent = salaryStandard.housingFund || '—';
                            totalBaseSalary += salaryStandard.baseSalary; // 累加基本薪资
                        })
                        .catch(error => console.error('加载薪酬标准失败:', error));

                    // 获取员工信息
                    const employeePromise = fetch('/employee/' + compensation.employeeId)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('获取员工失败');
                            }
                            return response.json();
                        })
                        .then(employee => {
                            row.querySelector('.employeeName').textContent = employee.employeeName; // 填充员工姓名
                        })
                        .catch(error => console.error('加载员工失败:', error));

                    return Promise.all([salaryStandardPromise, employeePromise]); // 返回所有 promise
                });

                // 等待所有请求完成
                return Promise.all(salaryStandardPromises).then(() => {
                    // 更新表单字段
                    $('#numberOfEmployees').val(numberOfEmployees);
                    $('#totalBaseSalary').val(totalBaseSalary.toFixed(2)); // 保留两位小数
                });
            })
            .catch(error => alert('加载员工薪酬信息失败: ' + error.message));
    }




    function loadDistributionData() {
        const data = localStorage.getItem('distributionData');
        if (data) {
            const formData = JSON.parse(data);
            $('#distributionID').val(formData.distributionID);
            $('#levelOneId').val(formData.levelOneId);
            $('#levelTwoId').val(formData.levelTwoId);
            $('#levelThreeId').val(formData.levelThreeId);
            $('select[name="status"]').val(formData.status);
            $('input[name="registrar"]').val(formData.registrar);
            loadEmployeeCompensations(formData.distributionID);

            // Load level two and three based on the loaded values
            loadLevelone(formData.levelOneId);

            if (formData.levelOneId) {
                loadLevelTwo(formData.levelOneId, formData.levelTwoId);
            }
            if(formData.levelTwoId){
                loadLevelThree(formData.levelTwoId,formData.levelThreeId)
            }

        } else {
            const distributionID = Math.floor(Math.random() * 1000000);
            $('#distributionID').val(distributionID);
            $('#numberOfEmployees').val(0);
            $('#totalBaseSalary').val(0);
            // Load level two and level three when level one changes
            $('#levelOneId').change(function () {
                const level1Id = $(this).val();
                loadLevelTwo(level1Id)
            });

            // 当二级机构改变时，加载三级机构
            $('#levelTwoId').change(function () {
                const level2Id = $(this).val();
                loadLevelThree(level2Id)
            });
        }
    }

    function loadLevelone(level1Id){
        $.get("/employee/level1", function (data) {
            $("#levelOneId").empty().append('<option value="" disabled selected>请选择一级机构</option>');
            $.each(data, function (index, level1) {
                $("#levelOneId").append('<option value="' + level1.level1Id + '">' + level1.level1Name + '</option>');
            });
            // Set the second level selection if previously chosen
            $('#levelOneId').val(level1Id).change();

        });
    }

    function loadLevelTwo(level1Id, level2Id) {
        $.get("/employee/level2", { level1Id: level1Id }, function (data) {
            $("#levelTwoId").empty().append('<option value="" disabled selected>请选择二级机构</option>');
            $.each(data, function (index, level2) {
                $("#levelTwoId").append('<option value="' + level2.level2Id + '">' + level2.level2Name + '</option>');
            });
            // Set the second level selection if previously chosen
            if (level2Id) {
                $('#levelTwoId').val(level2Id).change();
            }
        });
    }

    function loadLevelThree(level2Id,level3Id) {
        $.get("/employee/level3", { level2Id: level2Id }, function (data) {
            $("#levelThreeId").empty().append('<option value="" disabled selected>请选择三级机构</option>');
            $.each(data, function (index, level3) {
                $("#levelThreeId").append('<option value="' + level3.level3Id + '">' + level3.level3Name + '</option>');
            });
            if (level3Id) {
                $('#levelThreeId').val(level3Id).change();
            }
        });
    }

    function saveDistributionData() {
        const formData = {
            distributionID: $('#distributionID').val(),
            levelOneId: $('#levelOneId').val(),
            levelTwoId: $('#levelTwoId').val(),
            levelThreeId: $('#levelThreeId').val(),
            status: $('select[name="status"]').val(),
            registrar: $('input[name="registrar"]').val()
        };
        localStorage.setItem('distributionData', JSON.stringify(formData));

    }

    function saveDistribution() {
        const formData = {
            distributionID: $('#distributionID').val(),
            levelOneId: $('#levelOneId').val(),
            levelTwoId: $('#levelTwoId').val(),
            levelThreeId: $('#levelThreeId').val(),
            numberOfEmployees: $('#numberOfEmployees').val(),
            totalBaseSalary: parseFloat( $('#totalBaseSalary').val()) || 0.00,
            status: $('select[name="status"]').val(),
            registrar: $('input[name="registrar"]').val()
        };
        fetch('/salary-distributions', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => {
                if (response.status === 201) {
                    alert('薪酬发放单已保存为待登记状态');
                } else {
                    alert('保存失败');
                }
            })
            .catch(error => alert('保存失败: ' + error.message));
    }

    function registerDistribution() {
        const distributionID = $('#distributionID').val();
        fetch('/salary-distributions/getDistribution/' + distributionID, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                const formData = {
                    distributionID: $('#distributionID').val(),
                    levelOneId: $('#levelOneId').val(),
                    levelTwoId: $('#levelTwoId').val(),
                    levelThreeId: $('#levelThreeId').val(),
                    numberOfEmployees: $('#numberOfEmployees').val(),
                    totalBaseSalary: parseFloat( $('#totalBaseSalary').val()) || 0.00,
                    status: "待复核",
                    registrar: $('input[name="registrar"]').val()
                };
                if (response.ok) {
                    return fetch('/salary-distributions/' + distributionID, {
                        method: 'PUT',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify(formData)
                    });
                } else if (response.status === 404) {

                    return fetch('/salary-distributions', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(formData)
                    });
                } else {
                    throw new Error('查找发放单时发生错误');
                }
            })
            .then(response => {
                if (response.ok) {
                    alert('薪酬发放单登记成功！');
                    back();
                } else {
                    alert('登记失败，可能输入有误');
                }
            })
            .catch(error => alert('操作失败: ' + error.message));
    }

    function updateEmployeeCompensations(distributionId) {
        saveDistributionData();
        window.location.href = '/employees/compensation/getEmployeeCompensation/' + distributionId;
    }

    function deleteEmployeeCompensation(employeeId, distributionId) {
        if (confirm('确认要删除此员工薪酬信息吗？')) {
            fetch('/employees/compensation/' + employeeId, {
                method: 'DELETE'
            })
                .then(response => {
                    if (response.ok) {
                        alert('员工薪酬信息已删除');
                        updateEmployeeCompensations(distributionId); // Refresh the list
                    } else {
                        alert('删除失败');
                    }
                })
                .catch(error => alert('删除失败: ' + error.message));
        }
    }

    function showEmployeeCompensationForm() {
        const distributionID = $('input[name="distributionID"]').val();
        if ($('#levelOneId').val() && $('#levelTwoId').val() && $('#levelThreeId').val()) {
            $('input[name="distributionId"]').val(distributionID);  // Set the distribution ID in the modal
            loadSalaryStandards();  // Load salary standards
            $('#employeeCompensationModal').fadeIn();  // Show modal
        } else {
            alert("无法添加，请先选择机构！")
        }

    }

    function loadSalaryStandards() {
        fetch('/salary-standards/getAllSalaryRecords')
            .then(response => response.json())
            .then(data => {
                const select = $('#salaryStandardSelect');
                select.empty(); // Clear existing options
                select.append('<option value="">请选择薪酬标准</option>');
                data.forEach(standard => {
                    select.append(new Option(standard.standardName, standard.salaryStandardID));
                });
            })
            .catch(error => console.error('加载薪酬标准失败:', error));
    }

    function fillSalaryStandardInfo() {
        const selectedStandardId = $('#salaryStandardSelect').val();
        if (selectedStandardId) {
            fetch('/salary-standards/getStandard/' + selectedStandardId)
                .then(response => response.json())
                .then(data => {
                    $('#baseSalary').val(data.baseSalary);
                    $('#pensionInsurance').val(data.pensionInsurance);
                    $('#medicalInsurance').val(data.medicalInsurance);
                    $('#unemploymentInsurance').val(data.unemploymentInsurance);
                    $('#housingFund').val(data.housingFund);
                })
                .catch(error => console.error('获取薪酬标准信息失败:', error));
        } else {
            $('#baseSalary').val('');
            $('#pensionInsurance').val('');
            $('#medicalInsurance').val('');
            $('#unemploymentInsurance').val('');
            $('#housingFund').val('');
        }
    }

    // Function to submit the employee compensation form
    function submitEmployeeCompensation() {
        const distributionID = $('#distributionID').val();
        fetch('/salary-distributions/getDistribution/' + distributionID, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                const formData = {
                    employeeId: $('input[name="employeeId"]').val(),
                    allowances: parseFloat($('input[name="allowances"]').val()) || 0.00,
                    bonus: parseFloat($('input[name="bonus"]').val()) || 0.00,
                    deductions: parseFloat($('input[name="deductions"]').val()) || 0.00,
                    distributionId: $('input[name="distributionId"]').val(),
                    salaryStandardID: $('#salaryStandardSelect').val()

                };
                if (response.ok) {
                    return fetch('/employees/compensation', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(formData)
                    });
                } else if (response.status === 404) {
                    saveDistribution();
                    return fetch('/employees/compensation', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(formData)
                    });
                } else {
                    throw new Error('查找发放单时发生错误');
                }
            })
            .then(response => {
                if (response.status === 201) {
                    alert('员工薪酬信息已保存');
                    updateEmployeeCompensations(distributionID); // Refresh the list after saving
                    closeModal('employeeCompensationModal'); // Close modal
                } else {
                    alert('保存员工薪酬信息失败');
                }
            })
            .catch(error => alert('保存员工薪酬信息失败: ' + error.message));
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }

    $(document).on('click', '.close', function () {
        $(this).closest('.modal').fadeOut();
    });
</script>
