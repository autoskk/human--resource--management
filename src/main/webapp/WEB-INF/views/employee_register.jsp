<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>人力资源档案登记</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
            position: relative; /* 允许绝对定位 */
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
        .form-group {
            display: flex;
            align-items: center;
            margin: 10px 0;
        }
        label {
            font-weight: bold;
            padding-right: 10px;
            flex: 0 0 120px; /* 固定标签宽度 */
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="number"],
        select,
        textarea {
            flex: 1; /* 填充剩余空间 */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            float: right;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        #photoPreview {
            margin-top: 10px; /* 确保有间距 */
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
            // 从 sessionStorage 获取当前用户信息
            const currentUserJson = sessionStorage.getItem('currentUser');
            if (currentUserJson) {
                const currentUser = JSON.parse(currentUserJson);
                // 设置 createdBy 字段为当前用户的用户ID
                $('#createdBy').val(currentUser.userId); // 或者 currentUser.userId
            }
        });


        $(document).ready(function() {
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
        });

        $(document).ready(function () {
            $('#photoUpload').change(function (event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        $('#photoPreview img').attr('src', e.target.result).show(); // 显示预览
                    }
                    reader.readAsDataURL(file); // 读取文件
                }
            });
        });




    </script>
</head>
<body>
<a href="${pageContext.request.contextPath}/employee/home">返回主页</a>
<h1>人力资源档案登记</h1>
<form action="${pageContext.request.contextPath}/employee/register" method="post" enctype="multipart/form-data">

    <input type="hidden" id="createdBy" name="createdBy"/>

    <div class="form-group">
        <label for="employeeName">姓名:</label>
        <input type="text" name="employeeName" id="employeeName" required/>
    </div>

    <div class="form-group">
        <label for="gender">性别:</label>
        <select name="gender" id="gender" required>
            <option value="男">男</option>
            <option value="女">女</option>
        </select>
    </div>



    <div class="form-group">
        <label for="email">邮箱:</label>
        <input type="email" name="email" id="email" required/>
    </div>

    <div class="form-group">
        <label for="mobile">电话:</label>
        <input type="tel" name="mobile" id="mobile" required/>
    </div>

    <div class="form-group">
        <label for="address">地址:</label>
        <input type="text" name="address" id="address" required/>
    </div>

    <div class="form-group">
        <label for="age">年龄:</label>
        <input type="number" name="age" id="age" required/>
    </div>

    <div class="form-group">
        <label for="educationLevel">学历:</label>
        <select name="educationLevel" id="educationLevel" required>
            <option value="本科">本科</option>
            <option value="硕士">硕士</option>
            <option value="博士">博士</option>
        </select>
    </div>

    <div class="form-group">
        <label for="level1Id">所属机构:</label>
        <select id="level1Id" name="level1Id" required>
            <option value="" disabled selected>请选择一级机构</option>
            <c:forEach var="level1" items="${level1Organizations}">
                <option value="${level1.level1Id}">${level1.level1Name}</option>
            </c:forEach>
        </select>
    </div>

    <div class="form-group">
        <label for="level2Id">二级机构:</label>
        <select id="level2Id" name="level2Id" required>
            <option value="" disabled selected>请选择二级机构</option>
        </select>
    </div>

    <div class="form-group">
        <label for="level3Id">三级机构:</label>
        <select id="level3Id" name="level3Id" required>
            <option value="" disabled selected>请选择三级机构</option>
        </select>
    </div>

    <div class="form-group">
        <label for="categoryId">职位类别:</label>
        <select id="categoryId" name="categoryId" required>
            <option value="" disabled selected>请选择职位类别</option>
            <c:forEach var="category" items="${positionCategories}">
                <option value="${category.categoryId}">${category.categoryName}</option>
            </c:forEach>
        </select>
    </div>

    <div class="form-group">
        <label for="positionId">职位:</label>
        <select id="positionId" name="positionId" required>
            <option value="" disabled selected>请选择职位</option>
        </select>
    </div>

    <div class="form-group">
        <label for="photoUpload">上传照片:</label>
        <input type="file" id="photoUpload" name="photoUpload" accept="image/*" required/>
        <div id="photoPreview">
            <img src="" alt="预览照片" />
        </div>
        <input type="hidden" name="photoUrl" id="photoUrl" />
    </div>

<%--    <input type="hidden" name="photoUrl" id="photoUrl"  value="kk"/>--%>

    <div class="form-group">
        <label for="major">专业:</label>
        <input type="text" name="major" id="major" required/>
    </div>

    <div class="form-group">
        <label for="salaryStandardId">薪资标准</label>
        <select name="salaryStandardId" id="salaryStandardId" required>
            <option value="" disabled selected>请选择薪资标准</option>
            <c:forEach var="salaryStandard" items="${salaryStandards}">
                <option value="${salaryStandard.salaryStandardID}">${salaryStandard.standardName}</option>
            </c:forEach>
        </select>
    </div>



    <div class="form-group">
        <label for="bank">开户行:</label>
        <input type="text" name="bank" id="bank" required/>
    </div>

    <div class="form-group">
        <label for="accountNumber">银行账户:</label>
        <input type="text" name="accountNumber" id="accountNumber" required/>
    </div>

    <div class="form-group">
        <label for="personalHistory">个人履历:</label>
        <textarea name="personalHistory" id="personalHistory" rows="5" required></textarea><br/>
    </div>

    <input type="submit" value="提交"/>
</form>
</body>
</html>
