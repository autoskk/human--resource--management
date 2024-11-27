<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工列表</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
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
        select, input[type="date"], input[type="submit"] {
            padding: 10px;
            margin: 10px 0;
            width: calc(100% - 22px);
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #fff;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        $(document).ready(function() {
            // 当页面加载时，为每一行的机构 ID 查询对应的名称
            $('tr.employee_row').each(function () {
                let levelOneId = $(this).find('.level-one-id').text().trim();
                let levelTwoId = $(this).find('.level-two-id').text().trim();
                let levelThreeId = $(this).find('.level-three-id').text().trim();
                let positionId = $(this).find('.position-id').text().trim();

                // 查询一级机构名称
                if (levelOneId) {
                    $.get('/organizations/level1/' + levelOneId, function (data) {
                        $(this).find('.level-one-id').text(data);
                    }.bind(this));
                }

                // 查询二级机构名称
                if (levelTwoId) {
                    $.get('/organizations/level2/' + levelTwoId, function (data) {
                        $(this).find('.level-two-id').text(data);
                    }.bind(this));
                }

                // 查询三级机构名称
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
        })
    </script>
</head>
<body>
<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>
<h1>员工列表</h1>

<form action="${pageContext.request.contextPath}/employee/list" method="get">
    <label for="queryLevel1Id">一级机构:</label>
    <select id="queryLevel1Id" name="level1Id">
        <option value="" disabled selected>请选择一级机构</option>
        <c:forEach var="level1" items="${level1Organizations}">
            <option value="${level1.level1Id}">${level1.level1Name}</option>
        </c:forEach>
    </select>

    <label for="queryLevel2Id">二级机构:</label>
    <select id="queryLevel2Id" name="level2Id">
        <option value="" disabled selected>请选择二级机构</option>
    </select>

    <label for="queryLevel3Id">三级机构:</label>
    <select id="queryLevel3Id" name="level3Id">
        <option value="" disabled selected>请选择三级机构</option>
    </select>

    <label for="queryCategoryId">职位类别:</label>
    <select id="queryCategoryId" name="categoryId">
        <option value="" disabled selected>请选择职位类别</option>
        <c:forEach var="category" items="${positionCategories}">
            <option value="${category.categoryId}">${category.categoryName}</option>
        </c:forEach>
    </select>

    <label for="queryPositionId">职位:</label>
    <select id="queryPositionId" name="positionId">
        <option value="" disabled selected>请选择职位</option>
    </select>

    <label>建档时间:</label>
    <input type="date" name="startDate"/> -
    <input type="date" name="endDate"/>

    <input type="submit" value="查询"/>
</form>

<table>
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
                <a href="/employee/update?recordId=${employee.recordId}">编辑</a>
                <c:if test="${employee.status == '正常'}">
                    <form action="/employee/delete" method="post" style="display:inline;">
                        <input type="hidden" name="recordId" value="${employee.recordId}">
                        <input type="submit" value="删除" onclick="return confirm('确定要删除该档案吗？')">
                    </form>
                </c:if>
                <c:if test="${employee.status == '已删除'}">
                    <form action="/employee/restore" method="post" style="display:inline;">
                        <input type="hidden" name="recordId" value="${employee.recordId}">
                        <input type="submit" value="恢复" onclick="return confirm('确定要恢复该档案吗？')">
                    </form>
                </c:if>
            </td>

        </tr>
    </c:forEach>
</table>

</body>
</html>
