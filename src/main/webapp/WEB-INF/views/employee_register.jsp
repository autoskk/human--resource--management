<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>人力资源档案登记</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
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
            const currentUserJson = sessionStorage.getItem('currentUser');
            if (currentUserJson) {
                const currentUser = JSON.parse(currentUserJson);
                $('#createdBy').val(currentUser.userId);
            }

            $('#level1Id').change(function() {
                var level1Id = $(this).val();
                $.get("/employee/level2", { level1Id: level1Id }, function(data) {
                    $("#level2Id").empty().append('<option value="" disabled selected>请选择二级机构</option>');
                    $.each(data, function(index, level2) {
                        $("#level2Id").append('<option value="' + level2.level2Id + '">' + level2.level2Name + '</option>');
                    });
                    $("#level3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>');
                });
            });

            $('#level2Id').change(function() {
                var level2Id = $(this).val();
                $.get("/employee/level3", { level2Id: level2Id }, function(data) {
                    $("#level3Id").empty().append('<option value="" disabled selected>请选择三级机构</option>');
                    $.each(data, function(index, level3) {
                        $("#level3Id").append('<option value="' + level3.level3Id + '">' + level3.level3Name + '</option>');
                    });
                });
            });

            $('#categoryId').change(function() {
                var categoryId = $(this).val();
                $.get("/employee/positions", { categoryId: categoryId }, function(data) {
                    $("#positionId").empty().append('<option value="" disabled selected>请选择职位</option>');
                    $.each(data, function(index, position) {
                        $("#positionId").append('<option value="' + position.positionId + '">' + position.positionName + '</option>');
                    });
                });
            });

            $('#photoUpload').change(function(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        $('#photoPreview img').attr('src', e.target.result).show(); // 显示预览
                    }
                    reader.readAsDataURL(file); // 读取文件
                }
            });
        });
    </script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <a class="btn btn-secondary mb-3" href="${pageContext.request.contextPath}/employee/home">返回主页</a>
    <h1>人力资源档案登记</h1>
    <form action="${pageContext.request.contextPath}/employee/register" method="post" enctype="multipart/form-data" class="bg-white p-4 rounded shadow-sm">
        <input type="hidden" id="createdBy" name="createdBy"/>

        <div class="form-group">
            <label for="employeeName">姓名:</label>
            <input type="text" name="employeeName" id="employeeName" class="form-control" required/>
        </div>

        <div class="form-group">
            <label for="gender">性别:</label>
            <select name="gender" id="gender" class="form-control" required>
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
        </div>

        <div class="form-group">
            <label for="email">邮箱:</label>
            <input type="email" name="email" id="email" class="form-control" required/>
        </div>

        <div class="form-group">
            <label for="mobile">电话:</label>
            <input type="tel" name="mobile" id="mobile" class="form-control" required/>
        </div>

        <div class="form-group">
            <label for="address">地址:</label>
            <input type="text" name="address" id="address" class="form-control" required/>
        </div>

        <div class="form-group">
            <label for="age">年龄:</label>
            <input type="number" name="age" id="age" class="form-control" required/>
        </div>

        <div class="form-group">
            <label for="educationLevel">学历:</label>
            <select name="educationLevel" id="educationLevel" class="form-control" required>
                <option value="本科">本科</option>
                <option value="硕士">硕士</option>
                <option value="博士">博士</option>
            </select>
        </div>

        <div class="form-group">
            <label for="level1Id">所属机构:</label>
            <select id="level1Id" name="level1Id" class="form-control" required>
                <option value="" disabled selected>请选择一级机构</option>
                <c:forEach var="level1" items="${level1Organizations}">
                    <option value="${level1.level1Id}">${level1.level1Name}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="level2Id">二级机构:</label>
            <select id="level2Id" name="level2Id" class="form-control" required>
                <option value="" disabled selected>请选择二级机构</option>
            </select>
        </div>

        <div class="form-group">
            <label for="level3Id">三级机构:</label>
            <select id="level3Id" name="level3Id" class="form-control" required>
                <option value="" disabled selected>请选择三级机构</option>
            </select>
        </div>

        <div class="form-group">
            <label for="categoryId">职位类别:</label>
            <select id="categoryId" name="categoryId" class="form-control" required>
                <option value="" disabled selected>请选择职位类别</option>
                <c:forEach var="category" items="${positionCategories}">
                    <option value="${category.categoryId}">${category.categoryName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="positionId">职位:</label>
            <select id="positionId" name="positionId" class="form-control" required>
                <option value="" disabled selected>请选择职位</option>
            </select>
        </div>

        <div class="form-group">
            <label for="photoUpload">上传照片:</label>
            <input type="file" id="photoUpload" name="photoUpload" accept="image/*" class="form-control-file" required/>
            <div id="photoPreview" class="mt-2">
                <img src="" alt="预览照片" />
            </div>
            <input type="hidden" name="photoUrl" id="photoUrl" />
        </div>

        <div class="form-group">
            <label for="major">专业:</label>
            <input type="text" name="major" id="major" class="form-control" required/>
        </div>

        <div class="form-group">
            <label for="salaryStandardId">薪资标准:</label>
            <select name="salaryStandardId" id="salaryStandardId" class="form-control" required>
                <option value="" disabled selected>请选择薪资标准</option>
                <c:forEach var="salaryStandard" items="${salaryStandards}">
                    <option value="${salaryStandard.salaryStandardID}">${salaryStandard.standardName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="bank">开户行:</label>
            <input type="text" name="bank" id="bank" class="form-control" required/>
        </div>

        <div class="form-group">
            <label for="accountNumber">银行账户:</label>
            <input type="text" name="accountNumber" id="accountNumber" class="form-control" required/>
        </div>

        <div class="form-group">
            <label for="personalHistory">个人履历:</label>
            <textarea name="personalHistory" id="personalHistory" rows="5" class="form-control" required></textarea>
        </div>

        <input type="submit" value="提交" class="btn btn-success"/>
    </form>
</div>
</body>
</html>
