<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工列表</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .employee-row {
            cursor: pointer;
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
            $('tr.employee_row').each(function () {
                let levelOneId = $(this).find('.level-one-id').text().trim();
                let levelTwoId = $(this).find('.level-two-id').text().trim();
                let levelThreeId = $(this).find('.level-three-id').text().trim();
                let positionId = $(this).find('.position-id').text().trim();

                // 查询机构名称和职位名称
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
                if (positionId) {
                    $.get('/organizations/position/' + positionId, function (data) {
                        $(this).find('.position-id').text(data);
                    }.bind(this));
                }
            });

            // 下拉框依赖数据更新行为
            $('#queryLevel1Id').change(function () {
                var level1Id = $(this).val();
                $.get("/employee/level2", {level1Id: level1Id}, function (data) {
                    $("#queryLevel2Id").empty().append('<option value="" disabled selected>请选择二级机构</option>');
                    $.each(data, function (index, level2) {
                        $("#queryLevel2Id").append('<option value="' + level2.level2Id + '">' + level2.level2Name + '</option>');
                    });
                    $("#queryLevel3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>');
                });
            });

            $('#queryLevel2Id').change(function () {
                var level2Id = $(this).val();
                $.get("/employee/level3", {level2Id: level2Id}, function (data) {
                    $("#queryLevel3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>');
                    $.each(data, function (index, level3) {
                        $("#queryLevel3Id").append('<option value="' + level3.level3Id + '">' + level3.level3Name + '</option>');
                    });
                });
            });

            $('#queryCategoryId').change(function () {
                var categoryId = $(this).val();
                $.get("/employee/positions", {categoryId: categoryId}, function (data) {
                    $("#queryPositionId").empty().append('<option value="" disabled selected>请选择职位</option>');
                    $.each(data, function (index, position) {
                        $("#queryPositionId").append('<option value="' + position.positionId + '">' + position.positionName + '</option>');
                    });
                });
            });
        });

        $(document).ready(function() {
            // 获取当前用户信息
            const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));
            const userRoleId = currentUser ? currentUser.roleId : null; // 获取用户的 role_id

            // 根据 role_id 控制编辑按钮的显示

            if (userRoleId) {
                $('tr.employee_row').each(function() {
                    // 控制编辑按钮的显示
                    if (userRoleId === 3) {
                        $(this).find('.btn-warning').show(); // 角色为3的用户显示编辑按钮
                    } else {
                        $(this).find('.btn-warning').hide(); // 角色为其他的用户隐藏编辑按钮
                    }

                    // 控制删除按钮的显示
                    if (userRoleId === 4) {
                        $(this).find('.btn-danger').show();
                        $(this).find('.btn-info').show(); // 显示查看按钮// 角色为4的用户不显示删除按钮
                    } else if (userRoleId === 3) {
                        $(this).find('.btn-danger').hide();
                        $(this).find('.btn-info').hide();// 角色为3的用户显示删除按钮
                    }
                });
            }


        });
    </script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <a class="btn btn-secondary mb-4" href="${pageContext.request.contextPath}/employee/home"><i class="fas fa-arrow-left"></i> 返回主页</a>
    <h1>员工列表</h1>

    <form action="${pageContext.request.contextPath}/employee/list" method="get" class="mb-4 bg-white p-4 rounded shadow-sm">
        <div class="form-group">
            <label for="queryLevel1Id">一级机构:</label>
            <select id="queryLevel1Id" name="level1Id" class="form-control">
                <option value="" disabled selected>请选择一级机构</option>
                <c:forEach var="level1" items="${level1Organizations}">
                    <option value="${level1.level1Id}">${level1.level1Name}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="queryLevel2Id">二级机构:</label>
            <select id="queryLevel2Id" name="level2Id" class="form-control">
                <option value="" disabled selected>请选择二级机构</option>
            </select>
        </div>

        <div class="form-group">
            <label for="queryLevel3Id">三级机构:</label>
            <select id="queryLevel3Id" name="level3Id" class="form-control">
                <option value="" disabled selected>请选择三级机构</option>
            </select>
        </div>

        <div class="form-group">
            <label for="queryCategoryId">职位类别:</label>
            <select id="queryCategoryId" name="categoryId" class="form-control">
                <option value="" disabled selected>请选择职位类别</option>
                <c:forEach var="category" items="${positionCategories}">
                    <option value="${category.categoryId}">${category.categoryName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="queryPositionId">职位:</label>
            <select id="queryPositionId" name="positionId" class="form-control">
                <option value="" disabled selected>请选择职位</option>
            </select>
        </div>

        <div class="form-group">
            <label>建档时间:</label>
            <div class="d-flex">
                <input type="date" name="startDate" class="form-control mr-2"/> -
                <input type="date" name="endDate" class="form-control"/>
            </div>
        </div>

        <input type="submit" value="查询" class="btn btn-primary"/>
    </form>

    <table class="table table-striped table-bordered">
        <thead class="thead-light">
        <tr>
            <th>档案编号</th>
            <th>姓名</th>
            <th>性别</th>
            <th>一级机构</th>
            <th>二级机构</th>
            <th>三级机构</th>
            <th>职位名称</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="employee" items="${employees}">
            <tr class="employee_row">
                <td>${employee.recordId}</td>
                <td>${employee.employeeName}</td>
                <td>${employee.gender}</td>
                <td class="level-one-id">${employee.level1Id}</td>
                <td class="level-two-id">${employee.level2Id}</td>
                <td class="level-three-id">${employee.level3Id}</td>
                <td class="position-id">${employee.positionId}</td>
                <td>
                    <a class="btn btn-warning btn-sm"
                       href="/employee/update?recordId=${employee.recordId}">编辑</a>
                    <a class="btn btn-info btn-sm"
                       href="/employee/update?recordId=${employee.recordId}">查看</a>
                    <c:if test="${employee.status == '正常'}">
                        <form action="/employee/delete" method="post" style="display:inline;">
                            <input type="hidden" name="recordId" value="${employee.recordId}">
                            <input type="submit" value="删除" onclick="return confirm('确定要删除该档案吗？')" class="btn btn-danger btn-sm">
                        </form>
                    </c:if>
                    <c:if test="${employee.status == '已删除'}">
                        <form action="/employee/restore" method="post" style="display:inline;">
                            <input type="hidden" name="recordId" value="${employee.recordId}">
                            <input type="submit" value="恢复" onclick="return confirm('确定要恢复该档案吗？')" class="btn btn-info btn-sm">
                        </form>
                    </c:if>
                </td>


            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
