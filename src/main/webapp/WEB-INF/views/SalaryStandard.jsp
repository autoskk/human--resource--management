<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>薪酬管理系统</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        nav {
            background-color: #007bff;
            color: white;
            padding: 10px;
            text-align: center;
        }
        nav a {
            color: white;
            margin: 0 15px;
            text-decoration: none;
        }
        .container {
            margin-top: 20px;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>

<nav>
    <h1>薪酬管理系统</h1>
    <a href="#" id="showPendingDistributions">待登记发放单</a>
    <a href="#" id="showCreateStandard">登记薪酬标准</a>
    <a href="#" id="showSearchStandards">查询薪酬标准</a>
    <a href="#" id="showPendingReviews">待复核薪酬标准</a>
    <a href="#" id="showSalaryDistributions">薪酬发放单查询</a>
    <a href="#" id="showRegisterDistribution">登记薪酬发放单</a>
</nav>

<div class="container">
    <h2>欢迎来到薪酬管理系统</h2>
</div>

<!-- Register Salary Distribution Modal -->
<div id="registerDistributionModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('registerDistributionModal')">&times;</span>
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
                <option value="待审核">待审核</option>
                <option value="已审核">已审核</option>
            </select>

            <label>登记人:</label>
            <input type="text" name="registrar" required/>

            <div>
                <div>
                    <button type="button" onclick="saveDistribution()">保存（待登记状态）</button>
                    <button type="button" onclick="registerDistribution()">登记（待审核状态）</button>
                    <button type="button" onclick="showEmployeeCompensationForm()">登记员工薪酬信息</button>
                </div>
            </div>
        </form>
    </div>
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

            <!-- 显示基本薪资和其他计算字段 -->
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

            <input type="hidden" name="distributionId" />

            <button type="submit">保存</button>
        </form>
    </div>
</div>

<script>
    function showEmployeeCompensationForm() {
        // 设置薪酬发放单编号
        const distributionID =$('input[name="distributionID"]').val();
        $('input[name="distributionId"]').val(distributionID); // 设置为输入框的值

        // 加载薪酬标准
        loadSalaryStandards();

        $('#employeeCompensationModal').fadeIn();
    }

    function loadSalaryStandards() {
        fetch('/salary-standards/getAllSalaryRecords')
            .then(response => response.json())
            .then(data => {
                const select = $('#salaryStandardSelect');
                select.empty(); // 清空原有选项
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
            fetch('/salary-standards/' + selectedStandardId)
                .then(response => response.json())
                .then(data => {
                    // 假设data包含基本工资等信息
                    $('#baseSalary').val(data.baseSalary);

                    // 根据基本工资计算保险和公积金的值
                    const baseSalary = parseFloat(data.baseSalary) || 0;
                    $('#pensionInsurance').val(data.pensionInsurance); // 假设养老保险为基本工资的8%
                    $('#medicalInsurance').val(data.medicalInsurance); // 假设医疗保险为基本工资的2%
                    $('#unemploymentInsurance').val(data.unemploymentInsurance); // 假设失业保险为基本工资的1%
                    $('#housingFund').val(data.housingFund); // 假设住房公积金为基本工资的12%
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

    $('#employeeCompensationForm').submit(function(event) {
        event.preventDefault();
        submitEmployeeCompensation();
    });

    function submitEmployeeCompensation() {
        const formData = {
            employeeId: $('input[name="employeeId"]').val(),
            allowances: parseFloat($('input[name="allowances"]').val()) || 0.00,
            bonus: parseFloat($('input[name="bonus"]').val()) || 0.00,
            deductions: parseFloat($('input[name="deductions"]').val()) || 0.00,
            distributionId: $('input[name="distributionId"]').val(),
            salaryStandardID:$('#salaryStandardSelect').val()

            // pensionInsurance: parseFloat($('#pensionInsurance').val()) || 0.00,
            // medicalInsurance: parseFloat($('#medicalInsurance').val()) || 0.00,
            // unemploymentInsurance: parseFloat($('#unemploymentInsurance').val()) || 0.00,
            // housingFund: parseFloat($('#housingFund').val()) || 0.00
        };

        fetch('/employees/compensation', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => response.status === 201
                ? alert('员工薪酬信息已保存')
                : alert('保存员工薪酬信息失败'))
            .catch(error => alert('保存员工薪酬信息失败: ' + error.message));
    }
</script>


<!-- Pending Distributions Modal -->
<div id="pendingDistributionsModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('pendingDistributionsModal')">&times;</span>
        <h2>待登记薪酬发放单</h2>
        <table>
            <thead>
            <tr>
                <th>发放单编号</th>
                <th>一级机构 ID</th>
                <th>二级机构 ID</th>
                <th>三级机构 ID</th>
                <th>人数</th>
                <th>基本薪酬总额</th>
                <th>状态</th>
                <th>登记人</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="pendingDistributionsTableBody"></tbody>
        </table>
    </div>
</div>

<!-- Create Salary Standard Modal -->
<div id="createStandardModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('createStandardModal')">&times;</span>
        <h2>登记薪酬标准</h2>
        <form id="createStandardForm">
            <label>薪酬标准名称:</label>
            <input type="text" name="standardName" required />
            <label>制定人:</label>
            <input type="text" name="creator" required />
            <label>登记人:</label>
            <input type="text" name="registrar" value="${sessionStorage.getItem('currentUser')}" readonly />
            <label>基本工资:</label>
            <input type="number" name="baseSalary" step="0.01" required />
            <button type="submit">提交</button>
        </form>
    </div>
</div>

<!-- Search Salary Standards Modal -->
<div id="searchStandardsModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('searchStandardsModal')">&times;</span>
        <h2>查询薪酬标准</h2>
        <form id="searchStandardsForm">
            <label>薪酬标准编号:</label>
            <input type="text" name="salaryStandardID"/>
            <label>关键字:</label>
            <input type="text" name="keyword"/>
            <label>登记时间起:</label>
            <input type="date" name="startTime"/>
            <label>登记时间止:</label>
            <input type="date" name="endTime"/>
            <button type="submit">查询</button>
        </form>
        <table>
            <thead>
            <tr>
                <th>编号</th>
                <th>薪酬标准名称</th>
                <th>制定人</th>
                <th>登记人</th>
                <th>登记时间</th>
                <th>复核意见</th>
                <th>状态</th>
                <th>基本工资</th>
            </tr>
            </thead>
            <tbody id="searchResultsTableBody"></tbody>
        </table>
    </div>
</div>

<!-- Pending Reviews Modal -->
<div id="pendingReviewsModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('pendingReviewsModal')">&times;</span>
        <h2>待复核薪酬标准</h2>
        <table>
            <thead>
            <tr>
                <th>编号</th>
                <th>薪酬标准名称</th>
                <th>登记人</th>
                <th>登记时间</th>
                <th>复核意见</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="pendingReviewsTableBody"></tbody>
        </table>
    </div>
</div>

<!-- Salary Distributions Query Modal -->
<div id="salaryDistributionsModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('salaryDistributionsModal')">&times;</span>
        <h2>薪酬发放单查询</h2>
        <form id="salaryDistributionsForm">
            <label>发放单编号:</label>
            <input type="text" name="distributionID"/>
            <button type="submit">查询</button>
        </form>
        <table>
            <thead>
            <tr>
                <th>发放单编号</th>
                <th>一级机构 ID</th>
                <th>二级机构 ID</th>
                <th>三级机构 ID</th>
                <th>人数</th>
                <th>基本薪酬总额</th>
                <th>状态</th>
                <th>登记人</th>
            </tr>
            </thead>
            <tbody id="salaryDistributionsResults"></tbody>
        </table>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#showPendingDistributions').click(function() {
            $('#pendingDistributionsModal').fadeIn();
            loadPendingDistributions();
        });

        $('#showCreateStandard').click(function() {
            $('#createStandardModal').fadeIn();
        });

        $('#showSearchStandards').click(function() {
            $('#searchStandardsModal').fadeIn();
        });

        $('#showPendingReviews').click(function() {
            $('#pendingReviewsModal').fadeIn();
            loadPendingReviews();
        });

        $('#showSalaryDistributions').click(function() {
            $('#salaryDistributionsModal').fadeIn();
        });

        $('#showRegisterDistribution').click(function() {
            $('#registerDistributionModal').fadeIn();
        });

        $('#registerDistributionForm').submit(function(event) {
            event.preventDefault(); // Prevent default form submission
        });

        $('#employeeCompensationForm').submit(function(event) {
            event.preventDefault();
            submitEmployeeCompensation();
        });

        $('#createStandardForm').submit(function(event) {
            event.preventDefault();
            submitSalaryStandard();
        });

        $('#searchStandardsForm').submit(function(event) {
            event.preventDefault();
            searchSalaryStandards();
        });

        $('#salaryDistributionsForm').submit(function(event) {
            event.preventDefault();
            loadSalaryDistributions();
        });
    });

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }


    // 生成唯一的薪酬发放单编号
    function generateDistributionID() {
        const distributionID = Math.floor(Math.random() * 1000000); // 生成0到999999的随机数
        $('#distributionID').val(distributionID); // 设置为输入框的值
    }

    // 页面加载完成后自动生成编号
    $(document).ready(function() {
        generateDistributionID(); // 自动生成编号
    });

    function saveDistribution() {
        const formData = {
            distributionID: $('input[name="distributionID"]').val(),
            levelOneId: $('input[name="levelOneId"]').val(),
            levelTwoId: $('input[name="levelTwoId"]').val(),
            levelThreeId: $('input[name="levelThreeId"]').val(),
            numberOfEmployees: $('input[name="numberOfEmployees"]').val(),
            totalBaseSalary: parseFloat($('input[name="totalBaseSalary"]').val()) || 0.00,
            status: $('select[name="status"]').val(), // New Field
            registrar: $('input[name="registrar"]').val() // New Field
        };

        fetch('/salary-distributions', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => response.status === 201
                ? alert('薪酬发放单已保存为待登记状态')
                : alert('保存失败'))
            .catch(error => alert('保存失败: ' + error.message));
    }

    function registerDistribution() {
        var distributionID = $('#distributionID').val();
        // 首先根据编号查找
        fetch('/salary-distributions/'+distributionID,{
            method: 'GET',
                headers: {
                'Content-Type': 'application/json'
            }
            })
            .then(response => {
                if (response.ok) {
                    // 如果找到，则说明已存在，更新状态为已登记
                    let updatedDistribution = {
                        status: "待复核"
                    };
                    return fetch('/salary-distributions/'+distributionID, {
                        method: 'PUT',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(updatedDistribution)
                    });
                } else if (response.status === 404) {
                    // 如果不存在，则保存新的记录
                    const formData = {
                        distributionID: distributionID,
                        levelOneId: $('input[name="levelOneId"]').val(),
                        levelTwoId: $('input[name="levelTwoId"]').val(),
                        levelThreeId: $('input[name="levelThreeId"]').val(),
                        numberOfEmployees: $('input[name="numberOfEmployees"]').val(),
                        totalBaseSalary: parseFloat($('input[name="totalBaseSalary"]').val()) || 0.00,
                        status: '待复核',
                        registrar: $('input[name="registrar"]').val()
                    };
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
                } else {
                    alert('登记失败，可能是数据不正确');
                }
                closeModal('registerDistributionModal');
            })
            .catch(error => alert('操作失败: ' + error.message));
    }

    function submitSalaryStandard() {
        const formData = {
            standardName: $('input[name="standardName"]').val(),
            creator: $('input[name="creator"]').val(),
            registrar: $('input[name="registrar"]').val(),
            baseSalary: parseFloat($('input[name="baseSalary"]').val()) || 0.00
        };

        fetch('/salary-standards/create', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'currentUser': formData.registrar
            },
            body: JSON.stringify(formData)
        })
            .then(response => {
                if (response.ok) {
                    alert('薪酬标准创建成功');
                    closeModal('createStandardModal');
                } else {
                    alert('薪酬标准创建失败');
                }
            })
            .catch(error => alert('薪酬标准创建失败: ' + error.message));
    }

    function searchSalaryStandards() {
        const salaryStandardID = $('input[name="salaryStandardID"]').val();
        const keyword = $('input[name="keyword"]').val();
        const startTime = $('input[name="startTime"]').val();
        const endTime = $('input[name="endTime"]').val();

        const query = new URLSearchParams({
            salaryStandardID,
            keyword,
            startTime,
            endTime
        }).toString();

        fetch('/salary-standards/search?' + query)
            .then(response => response.json())
            .then(data => {
                const tableBody = $('#searchResultsTableBody');
                tableBody.empty();

                data.forEach(standard => {
                    const row = `<tr>
                        <td>${standard.salaryStandardID}</td>
                        <td>${standard.standardName}</td>
                        <td>${standard.creator}</td>
                        <td>${standard.registrar}</td>
                        <td>${standard.registrationTime}</td>
                        <td>${standard.reviewComment || '无'}</td>
                        <td>${standard.status}</td>
                        <td>${standard.baseSalary}</td>
                    </tr>`;
                    tableBody.append(row);
                });
            })
            .catch(error => console.error('Error fetching search results:', error));
    }

    function loadPendingDistributions() {
        fetch('/salary-distributions/pending')
            .then(response => response.json())
            .then(data => {
                const tableBody = document.getElementById('pendingDistributionsTableBody');
                tableBody.innerHTML = '';

                data.forEach(distribution => {
                    const row = `<tr>
                        <td>${distribution.distributionID}</td>
                        <td>${distribution.levelOneId}</td>
                        <td>${distribution.levelTwoId}</td>
                        <td>${distribution.levelThreeId}</td>
                        <td>${distribution.numberOfEmployees}</td>
                        <td>${distribution.totalBaseSalary}</td>
                        <td>${distribution.status}</td>
                        <td>${distribution.registrar}</td>
                        <td><button onclick="registerDistribution(${distribution.distributionID})">登记</button></td>
                    </tr>`;
                    tableBody.innerHTML += row;
                });
            })
            .catch(error => console.error('Error fetching pending distributions:', error));
    }

    function loadPendingReviews() {
        fetch('/salary-standards/status/pending')
            .then(response => response.json())
            .then(data => {
                const tableBody = document.getElementById('pendingReviewsTableBody');
                tableBody.innerHTML = '';

                data.forEach(standard => {
                    const row = `<tr>
                        <td>${standard.salaryStandardID}</td>
                        <td>${standard.standardName}</td>
                        <td>${standard.registrar}</td>
                        <td>${standard.registrationTime}</td>
                        <td>
                            <input type="text" placeholder="复核意见" onchange="setReviewComment(${standard.salaryStandardID}, this.value)" />
                        </td>
                        <td>
                            <button onclick="approveReview(${standard.salaryStandardID})">通过</button>
                            <button onclick="rejectReview(${standard.salaryStandardID})">拒绝</button>
                        </td>
                    </tr>`;
                    tableBody.innerHTML += row;
                });
            })
            .catch(error => console.error('Error fetching pending reviews:', error));
    }

    function loadSalaryDistributions() {
        const distributionID = $('input[name="distributionID"]').val();

        const query = new URLSearchParams({
            distributionID
        }).toString();

        fetch('/salary-distributions/' + distributionID)
            .then(response => {
                if (!response.ok) throw new Error('发放单未找到');
                return response.json();
            })
            .then(distribution => {
                const tableBody = $('#salaryDistributionsResults');
                tableBody.empty();
                const row = `<tr>
                    <td>${distribution.distributionID}</td>
                    <td>${distribution.levelOneId}</td>
                    <td>${distribution.levelTwoId}</td>
                    <td>${distribution.levelThreeId}</td>
                    <td>${distribution.numberOfEmployees}</td>
                    <td>${distribution.totalBaseSalary}</td>
                    <td>${distribution.status}</td>
                    <td>${distribution.registrar}</td>
                </tr>`;
                tableBody.append(row);
            })
            .catch(error => console.error('Error fetching salary distribution:', error));
    }

    $(document).on('click', '.close', function(){
        $(this).closest('.modal').fadeOut();
    });
</script>

</body>
</html>
