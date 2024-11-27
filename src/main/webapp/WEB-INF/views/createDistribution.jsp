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
        <label>一级机构 ID:</label>
        <input type="number" name="levelOneId" required/>
        <label>二级机构 ID:</label>
        <input type="number" name="levelTwoId" required/>
        <label>三级机构 ID:</label>
        <input type="number" name="levelThreeId" required/>
        <label>人数:</label>
        <input type="number" name="numberOfEmployees" required/>
        <label>基本薪酬总额:</label>
        <input type="number" name="totalBaseSalary" step="0.01" required/>
        <label>状态:</label>
        <select name="status" disabled>
            <option value="待登记" selected>待登记</option>
            <option value="待复核">待复核</option>
            <option value="已复核">已复核</option>
        </select>
        <label>登记人:</label>
        <input type="text" name="registrar" readonly/>
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
            <th>薪酬标准编号</th>
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
                    <td>${record.salaryStandardID}</td>
                    <td>${record.baseSalary}</td>
                    <td>${record.pensionInsurance != null ? record.pensionInsurance : '—'}</td>
                    <td>${record.medicalInsurance != null ? record.medicalInsurance : '—'}</td>
                    <td>${record.unemploymentInsurance != null ? record.unemploymentInsurance : '—'}</td>
                    <td>${record.housingFund != null ? record.housingFund : '—'}</td>
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

        // Generate new distribution ID
        const distributionID = Math.floor(Math.random() * 1000000);
        $('#distributionID').val(distributionID);

        // Load current user info
        const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));
        if (currentUser && currentUser.userName) {
            $('input[name="registrar"]').val(currentUser.userName);
        }

        loadDistributionData();

        // 表单字段输入时触发函数存储到 localStorage
        $('#registerDistributionForm input, #registerDistributionForm select').on('change input', function () {
            saveDistributionData();
        });

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

    function back(){
        localStorage.removeItem('distributionData');
        window.location.href="/salary-distributions";

    }

    function saveDistributionData() {
        const formData = {
            distributionID: $('#distributionID').val(),
            levelOneId: $('input[name="levelOneId"]').val(),
            levelTwoId: $('input[name="levelTwoId"]').val(),
            levelThreeId: $('input[name="levelThreeId"]').val(),
            numberOfEmployees: $('input[name="numberOfEmployees"]').val(),
            totalBaseSalary: $('input[name="totalBaseSalary"]').val(),
            status: $('select[name="status"]').val(),
            registrar: $('input[name="registrar"]').val()
        };
        localStorage.setItem('distributionData', JSON.stringify(formData));
    }

    function loadDistributionData() {
        const data = localStorage.getItem('distributionData');
        if (data) {
            const formData = JSON.parse(data);
            $('#distributionID').val(formData.distributionID);
            $('input[name="levelOneId"]').val(formData.levelOneId);
            $('input[name="levelTwoId"]').val(formData.levelTwoId);
            $('input[name="levelThreeId"]').val(formData.levelThreeId);
            $('input[name="numberOfEmployees"]').val(formData.numberOfEmployees);
            $('input[name="totalBaseSalary"]').val(formData.totalBaseSalary);
            $('select[name="status"]').val(formData.status);
            $('input[name="registrar"]').val(formData.registrar);
        }
    }

    function saveDistribution() {
        const formData = {
            distributionID: $('#distributionID').val(),
            levelOneId: $('input[name="levelOneId"]').val(),
            levelTwoId: $('input[name="levelTwoId"]').val(),
            levelThreeId: $('input[name="levelThreeId"]').val(),
            numberOfEmployees: $('input[name="numberOfEmployees"]').val(),
            totalBaseSalary: parseFloat($('input[name="totalBaseSalary"]').val()) || 0.00,
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
                    levelOneId: $('input[name="levelOneId"]').val(),
                    levelTwoId: $('input[name="levelTwoId"]').val(),
                    levelThreeId: $('input[name="levelThreeId"]').val(),
                    numberOfEmployees: $('input[name="numberOfEmployees"]').val(),
                    totalBaseSalary: parseFloat($('input[name="totalBaseSalary"]').val()) || 0.00,
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
                    alert('登记失败，可能是数据不正确');
                }
            })
            .catch(error => alert('操作失败: ' + error.message));
    }

    function loadEmployeeCompensations(distributionId) {
        window.location.href = '/employees/compensation/distribution/' + distributionId;
    }

    function deleteEmployeeCompensation(employeeId, distributionId) {
        if (confirm('确认要删除此员工薪酬信息吗？')) {
            fetch('/employees/compensation/' + employeeId, {
                method: 'DELETE'
            })
                .then(response => {
                    if (response.ok) {
                        alert('员工薪酬信息已删除');
                        loadEmployeeCompensations(distributionId); // Refresh the list
                    } else {
                        alert('删除失败');
                    }
                })
                .catch(error => alert('删除失败: ' + error.message));
        }
    }

    function showEmployeeCompensationForm() {
        const distributionID = $('input[name="distributionID"]').val();
        $('input[name="distributionId"]').val(distributionID);  // Set the distribution ID in the modal
        loadSalaryStandards();  // Load salary standards
        $('#employeeCompensationModal').fadeIn();  // Show modal
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
        const formData = {
            employeeId: $('input[name="employeeId"]').val(),
            allowances: parseFloat($('input[name="allowances"]').val()) || 0.00,
            bonus: parseFloat($('input[name="bonus"]').val()) || 0.00,
            deductions: parseFloat($('input[name="deductions"]').val()) || 0.00,
            distributionId: $('input[name="distributionId"]').val(),
            salaryStandardID: $('#salaryStandardSelect').val()
        };

        fetch('/employees/compensation', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => {
                if (response.status === 201) {
                    alert('员工薪酬信息已保存');
                    loadEmployeeCompensations(formData.distributionId); // Refresh the list after saving
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
