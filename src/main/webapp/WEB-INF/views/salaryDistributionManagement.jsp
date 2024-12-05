<!DOCTYPE html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="zh-CN" dir="ltr">

<head>
    <meta charset="utf-8">
    <title>薪资发放管理</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <style media="screen">
        a:link {
            text-decoration: none;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: "Roboto", sans-serif;
            background-color: #f8f9fa; /* 轻微背景色，提供视觉振奋 */
        }

        header {
            position: fixed;
            background: #ffffff; /* 将导航栏背景设置为白色 */
            padding: 20px;
            width: 100%;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
            z-index: 1;
        }

        .left_area h3 {
            color: #333; /* 改为较深的颜色以适应新的背景 */
            margin: 0;
            text-transform: uppercase;
            font-size: 22px;
            font-weight: 900;
        }

        .logout_btn {
            padding: 5px;
            background: #19B3D3; /* 保持颜色，以突出显示 */
            text-decoration: none;
            float: right;
            margin-top: -30px;
            margin-right: 40px;
            border-radius: 2px;
            font-size: 15px;
            font-weight: 600;
            color: #fff;
            transition: 0.5s;
            cursor: pointer;
        }

        .logout_btn:hover {
            background: #0B87A6;
        }

        .sidebar {
            background: #ffffff; /* 将侧边栏背景设置为白色 */
            margin-top: 70px;
            padding-top: 30px;
            position: fixed;
            left: 0;
            width: 250px;
            height: 100%;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* 添加阴影与立体感 */
            transition: 0.5s;
        }

        .sidebar .profile_image {
            width: 100px;
            height: 100px;
            border-radius: 100px;
            margin-bottom: 10px;
        }

        .sidebar h4 {
            color: #333; /* 统一文本颜色 */
            margin-top: 0;
            margin-bottom: 20px;
        }

        .sidebar a {
            color: #333; /* 改为较深的颜色以适应新的背景 */
            display: block;
            width: 100%;
            line-height: 60px;
            text-decoration: none;
            padding-left: 40px;
            box-sizing: border-box;
            transition: 0.5s;
        }

        .sidebar a:hover {
            background: #19B3D3; /* 保持原有悬停效果 */
            color: #fff; /* 悬停背景下文本颜色变为白色 */
        }

        label #sidebar_btn {
            z-index: 1;
            color: #333; /* 改为较深的颜色以适应新的背景 */
            position: fixed;
            cursor: pointer;
            left: 300px; /* 根据布局需调整 */
            font-size: 20px;
            margin: 5px 0;
            transition: 0.5s;
        }

        label #sidebar_btn:hover {
            color: #19B3D3;
        }

        #check {
            display: none;
        }

        /* 收缩侧边栏的样式 */
        #check:checked ~ .sidebar {
            left: -190px; /* 收缩的宽度 */
        }

        #check:checked ~ .sidebar a span {
            display: none; /* 隐藏文字 */
        }

        #check:checked ~ .sidebar a {
            font-size: 20px;
            margin-left: 170px; /* 调整以保持图标的位置 */
            width: 80px; /* 调整宽度 */
        }

        /* 隐藏子菜单 */
        .submenu {
            display: none;
            padding-left: 20px;
        }

        .submenu a {
            line-height: 40px; /* 子菜单项的高度 */
            color: #333; /* 文本颜色 */
        }

        .content {
            margin-left: 250px;
            padding: 40px;
            padding-top: 120px; /* 添加这个属性来保障内容不被导航栏覆盖 */
            background: #ffffff; /* 内容区域背景颜色 */
            height: calc(100vh - 100px); /* 减去导航栏高度，确保内容区域不溢出 */
            transition: 0.5s;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 添加阴影 */
        }

        #check:checked ~ .content {
            margin-left: 60px; /* 内容区的 margin 调整 */
        }

        /* 增加模块描述样式 */
        .module-description {
            background: #f9f9f9; /* 模块描述背景颜色 */
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
            transition: box-shadow 0.3s;
        }

        .module-description:hover {
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        }

        h2 {
            color: #333;
            font-size: 24px;
            margin-bottom: 15px;
            text-align: center;
        }

        h3 {
            color: #2c3e50;
            font-size: 20px;
            margin-top: 30px;
            margin-bottom: 10px;
            border-bottom: 2px solid #19B3D3;
            padding-bottom: 5px;
        }

        p {
            color: #666;
            line-height: 1.5;
            margin-bottom: 15px;
        }

        ul {
            list-style-type: disc;
            padding-left: 20px;
        }

        .quick-actions {
            background: #e0f7fa;
            padding: 15px;
            border-radius: 5px;
            margin-top: 10px;
        }

        .quick-actions li {
            margin: 10px 0;
            font-size: 16px;
        }

        .quick-actions a {
            color: #00796b;
            text-decoration: none;
            font-weight: bold;
        }

        .quick-actions a:hover {
            text-decoration: underline;
            color: #004d40;
        }

        /*content {*/
        /*    font-family: 'Arial', sans-serif;*/
        /*    margin: 0;*/
        /*    padding: 20px;*/
        /*    background-color: #e9ecef;*/
        /*    color: #495057;*/
        /*}*/

        h2 {
            text-align: center;
            color: #007bff;
        }

        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .form-row {
            display: flex;
            justify-content: space-between;
            gap: 20px; /* 控制两列之间的间距 */
        }

        .form-group {
            flex: 1; /* 使每个输入部分均分 */
            min-width: 200px; /* 设置最小宽度 */
        }

        .search-form {
            display: flex;
            flex-direction: column;
            gap: 10px; /* 表单各部分间隔 */
        }

        label {
            font-weight: bold;
        }

        input[type="text"], input[type="date"], select {
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            width: 100%;
        }


        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        td button {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        th, td {
            border: 1px solid #dee2e6;
            padding: 15px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .button-group {
            display: flex;
            justify-content: center; /* 水平居中 */
            margin-top: 0px; /* 为按钮组添加上边距 */
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

        .btn:last-child {
            margin-right: 0; /* 最后一个按钮不使用右外边距 */
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .edit-btn {
            background: #28a745;
            color: white;
        }

        .approve-btn {
            background: #ffc107;
            color: white;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
        }

        .edit-btn:hover {
            background: #218838;
        }

        .approve-btn:hover {
            background: #e0a800;
        }

        .delete-btn:hover {
            background: #c82333;
        }
    </style>

<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">--%>
</head>

<body>
<input type="checkbox" id="check">
<header>
    <label for="check">
        <i class="fas fa-bars" id="sidebar_btn"></i>
    </label>
    <div class="left_area">
        <h3>人力资源管理系统</h3>
    </div>
    <div class="right_area">
        <a href="javascript:void(0);" class="logout_btn" id="logoutButton" onclick="handleLoginLogout()">登录</a>
    </div>
</header>

<div class="sidebar">
    <div style="text-align: center;">
        <img src="https://img95.699pic.com/xsj/10/gk/q8.jpg!/fh/300" class="profile_image" alt="">
        <h4 id="createdBy"></h4>
    </div>

    <a href="${pageContext.request.contextPath}/employee/home"><i class="fas fa-home"></i><span>首页</span></a>

    <a href="javascript:void(0);" onclick="toggleSubmenu('hrManagement');">
        <i class="fas fa-address-card"></i><span>人力资源档案管理</span></a>
    <div id="hrManagement" class="submenu">
        <a href="javascript:void(0);" onclick="checkAccess('register')">档案登记</a>
        <a href="javascript:void(0);" onclick="checkAccess('list')">档案列表</a>
        <a href="javascript:void(0);" onclick="checkAccess('review')">档案复核</a>
    </div>

    <a href="javascript:void(0);" onclick="toggleSubmenu('salaryManagement');">
        <i class="fas fa-money-check"></i><span>薪酬管理</span></a>
    <div id="salaryManagement" class="submenu">
        <a href="javascript:void(0);" onclick="checkAccess('salaryDistributionManagement')">薪酬发放管理</a>
        <a href="javascript:void(0);" onclick="checkAccess('salaryStandardManagement')">薪酬标准管理</a>
    </div>
</div>

<div class="content">
    <a class="btn btn-secondary mb-4" href="${pageContext.request.contextPath}/index"><i class="fas fa-arrow-left"></i> 返回</a>
    <h2>薪资发放管理</h2>
    <div>
        <form action="/salary-distributions/search" method="get" class="search-form">
            <div class="form-row">
                <div class="form-group">
                    <label for="distributionID">薪酬发放单编号:</label>
                    <input type="text" name="distributionID" id="distributionID" placeholder="请输入发放单编号"/>
                </div>
                <div class="form-group">
                    <div class="button-group">
                        <button type="submit" class="btn">查询</button>
                        <button type="button" class="btn"  id="importDistribution">导入</button>
                        <button type="button" class="btn" id="createDistribution">创建薪酬发放单</button>
                        <button type="button" class="btn"  onclick="window.location.href='/searchEmployeeCompensation'">查询员工薪酬</button>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="keyword">关键词:</label>
                    <input type="text" name="keyword" id="keyword" placeholder="请输入关键词"  class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="time">选择时间:</label>
                    <select id="time"  name="time" class="form-control">
                        <option value="" selected>请选择时间</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>一级机构:</label>
                    <select id="levelOneId" name="levelOneId" >
                        <option value=""  selected>请选择一级机构</option>
                        <c:forEach var="level1" items="${level1Organizations}">
                            <option value="${level1.level1Id}">${level1.level1Name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>二级机构:</label>
                    <select id="levelTwoId" name="levelTwoId" >
                        <option value=""  selected>请选择二级机构</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>三级机构:</label>
                    <select id="levelThreeId" name="levelThreeId" >
                        <option value=""  selected>请选择三级机构</option>
                    </select>
                </div>
            </div>
            <input type="hidden" name="status" id="status"/>
        </form>
    </div>

    <!-- 导入模态框 -->
    <div class="modal fade" id="importModal" tabindex="-1" role="dialog" aria-labelledby="importModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="importModalLabel">导入薪资发放单</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="importForm" >
                        <div class="form-group">
                            <label for="time">选择时间:</label>
                            <select name="importTime" id="importTime" class="form-control">
                                <option value="">请选择时间</option>
                                <!-- 选项由JavaScript动态添加 -->
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="confirmImport">导入</button>
                </div>
            </div>
        </div>
    </div>


    <table>
        <thead>
        <tr>
            <th>发放单编号</th>
            <th>一级机构名称</th>
            <th>二级机构名称</th>
            <th>三级机构名称</th>
            <th>人数</th>
            <th>基本薪酬总额</th>
            <th>状态</th>
            <th>登记时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="distributionsTableBody">
        <c:if test="${not empty salaryDistribution}">
            <c:forEach var="distribution" items="${salaryDistribution}">
                <tr class="distribution-row">
                    <td>${distribution.distributionID}</td>
                    <td class="level-one-id">${distribution.levelOneId}</td>
                    <td class="level-two-id">${distribution.levelTwoId}</td>
                    <td class="level-three-id">${distribution.levelThreeId}</td>
                    <td>${distribution.numberOfEmployees}</td>
                    <td>${distribution.totalBaseSalary}</td>
                    <td>${distribution.status}</td>
                    <td>
                        <fmt:formatDate value="${distribution.registrationTime}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <button onclick="editDistribution(${distribution.distributionID})" class="edit-btn"
                                style="display:none;">登记
                        </button>
                        <button onclick="reviewDistribution(${distribution.distributionID})" class="approve-btn"
                                style="display:none;">复核
                        </button>
                        <button onclick="deleteDistribution(${distribution.distributionID})" class="delete-btn"
                                style="display:none;">删除
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </c:if>

        <c:if test="${empty salaryDistribution}">
            <tr>
                <td colspan="9" style="text-align: center;">没有可显示的薪资发放单</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<script>
    $(document).ready(function () {
        // 设置当前日期为起始和结束时间的默认值
        // const today = new Date().toISOString().split('T')[0];
        // document.getElementById('startTime').value = today;
        // document.getElementById('endTime').value = today;

        // 生成最近6年的月份选项
        const currentYear = new Date().getFullYear();
        const selectElement1 = $('#time');
        const selectElement2 = $('#importTime');

        for (let year = currentYear + 1; year >= currentYear - 4; year--) {
            for (let month = 12; month >= 1; month--) {
                const formattedMonth = month < 10 ? '0' + month : month; // 保证月份为两位数
                const value = '' + year + formattedMonth; // 生成字符串格式如 '202411'
                selectElement1.append(new Option(year + '年' + formattedMonth + '月', value));
                selectElement2.append(new Option(year + '年' + formattedMonth + '月', value));
            }
        }

        // 点击导入按钮
        $('#importDistribution').click(function() {
            $('#importModal').modal('show'); // 显示模态框
        });

        // 处理导入按钮的点击事件
        $('#confirmImport').click(function() {
            const time = $('#importTime').val();
            if (!time) {
                alert('请先选择导入时间。');
                return;
            }
            window.location.href = '/salary-distributions/import/' + time;
        });

        $('#levelOneId').change(function() {
            var level1Id = $(this).val();
            $.get("/employee/level2", { level1Id: level1Id }, function(data) {
                $("#levelTwoId").empty().append('<option value="" disabled selected>请选择二级机构</option>');
                $.each(data, function(index, level2) {
                    $("#levelTwoId").append('<option value="' + level2.level2Id + '">' + level2.level2Name + '</option>');
                });
                $("#level3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>');
            });
        });

        $('#levelTwoId').change(function() {
            var level2Id = $(this).val();
            $.get("/employee/level3", { level2Id: level2Id }, function(data) {
                $("#levelThreeId").empty().append('<option value="" disabled selected>请选择三级机构</option>');
                $.each(data, function(index, level3) {
                    $("#levelThreeId").append('<option value="' + level3.level3Id + '">' + level3.level3Name + '</option>');
                });
            });
        });

        // 获取当前用户信息
        const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));

        // 权限控制
        if (currentUser && currentUser.roleId) {
            const roleId = currentUser.roleId;

            if (roleId === 5) { // 薪酬专员
                document.getElementById('status').value = "待登记";
                // 循环显示可用操作按钮
                $('tr.distribution-row').each(function () {
                    const status = $(this).find('td:eq(6)').text().trim(); // 状态列
                    if (status === '待登记') {
                        $(this).find('.edit-btn').show(); // 显示登记按钮
                    }
                    $(this).find('.delete-btn').show(); // 显示删除按钮

                    let levelOneId = $(this).find('.level-one-id').text().trim();
                    let levelTwoId = $(this).find('.level-two-id').text().trim();
                    let levelThreeId = $(this).find('.level-three-id').text().trim();

                    // 查询机构名称
                    if (levelOneId) {
                        $.get('/organizations/level1/' + levelOneId, function (data) {
                            $(this).find('.level-one-id').text(data);
                        }.bind(this));
                    }
                    if (levelTwoId) {
                        $.get('/organizations/level2/' + levelTwoId, function (data) {
                            $(this).find('.level-two-id').text(data);
                        }.bind(this));
                    }
                    if (levelThreeId) {
                        $.get('/organizations/level3/' + levelThreeId, function (data) {
                            $(this).find('.level-three-id').text(data);
                        }.bind(this));
                    }
                });
            } else if (roleId === 6) { // 薪酬经理
                document.getElementById('status').value = "待复核";
                // 循环显示可用操作按钮
                $('tr.distribution-row').each(function () {
                    const status = $(this).find('td:eq(6)').text().trim(); // 状态列
                    if (status === '待复核') {
                        $(this).find('.approve-btn').show(); // 显示复核按钮
                    }
                    $(this).find('.delete-btn').show(); // 显示删除按钮

                    let levelOneId = $(this).find('.level-one-id').text().trim();
                    let levelTwoId = $(this).find('.level-two-id').text().trim();
                    let levelThreeId = $(this).find('.level-three-id').text().trim();

                    // 查询机构名称
                    if (levelOneId) {
                        $.get('/organizations/level1/' + levelOneId, function (data) {
                            $(this).find('.level-one-id').text(data);
                        }.bind(this));
                    }
                    if (levelTwoId) {
                        $.get('/organizations/level2/' + levelTwoId, function (data) {
                            $(this).find('.level-two-id').text(data);
                        }.bind(this));
                    }
                    if (levelThreeId) {
                        $.get('/organizations/level3/' + levelThreeId, function (data) {
                            $(this).find('.level-three-id').text(data);
                        }.bind(this));
                    }
                });
            }
        }

        $('#createDistribution').click(function () {
            window.location.href = '/createDistribution'; // 假设登记页面的URL
        });
    });

    function editDistribution(distributionID) {
        fetch('/salary-distributions/getDistribution/' + distributionID)
            .then(response => response.json())
            .then(data => {
                localStorage.setItem('distributionData', JSON.stringify(data));
                window.location.href = '/employees/compensation/getEmployeeCompensationEdit/' + distributionID;
            })
            .catch(error => console.error('获取信息失败:', error));
    }

    function reviewDistribution(distributionID) {
        fetch('/salary-distributions/getDistribution/' + distributionID)
            .then(response => response.json())
            .then(data => {
                localStorage.setItem('distributionData', JSON.stringify(data));
                window.location.href = '/employees/compensation/getEmployeeCompensationPending/' + distributionID;
            })
            .catch(error => console.error('获取信息失败:', error));
    }

    function deleteDistribution(distributionID) {
        if (confirm('确定要删除该薪资发放单吗？')) {
            fetch('/salary-distributions/' + distributionID, {method: 'DELETE'})
                .then(response => response.text())
                .then(data => {
                    alert(data);
                    window.location.href = '/salary-distributions';
                })
                .catch(error => alert('删除失败: ' + error));
        }
    }

    function toggleSubmenu(id) {
        var submenu = document.getElementById(id);
        var checkbox = document.getElementById('check');

        if (!checkbox.checked) {
            submenu.style.display = submenu.style.display === "block" ? "none" : "block";
        } else {
            checkbox.checked = false;  // 展开导航栏
            submenu.style.display = submenu.style.display === "block" ? "none" : "block";
        }
    }

    document.getElementById('check').addEventListener('change', function () {
        if (this.checked) {
            var submenus = document.querySelectorAll('.submenu');
            submenus.forEach(function(submenu) {
                submenu.style.display = 'none'; // 隐藏子菜单
            });
        }
    });

    function handleLoginLogout() {
        const currentUserJson = sessionStorage.getItem('currentUser');
        if (currentUserJson) {
            logout();
        } else {
            window.location.href = "/login";
        }
    }

    function logout() {
        sessionStorage.removeItem('currentUser');
        $('#createdBy').text('');
        $('#logoutButton').text('登录');
        alert("已登出");
        window.location.href="/index";
    }

    function checkAccess(action) {
        const currentUserJson = sessionStorage.getItem('currentUser');
        if (!currentUserJson) {
            alert("请先登录才能访问此页面。");
            return;
        }
        const currentUser = JSON.parse(currentUserJson);

        const roleAccess = {
            register: [3],
            review: [4],
            list: [3, 4],
            salaryDistributionManagement: [5, 6],
            salaryStandardManagement: [5, 6]
        };

        if (roleAccess[action] && roleAccess[action].includes(currentUser.roleId)) {
            var targetUrl="";
            if(action=="register"||action=="review"||action=="list"){
                targetUrl = "/employee/" + action;

            }
            else{
                targetUrl = "/" + action;
            }
            window.location.href = targetUrl;
        } else {
            alert("您没有权限访问此页面。");
        }
    }

    $(document).ready(function () {
        const currentUserJson = sessionStorage.getItem('currentUser');
        if (currentUserJson) {
            const currentUser = JSON.parse(currentUserJson);
            $('#createdBy').text(currentUser.userName);
            $('#logoutButton').text('登出');
        }
    });
</script>

</body>
</html>