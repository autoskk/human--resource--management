<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>人力资源档案登记</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #e9ecef;
        }
        .container {
            margin-top: 50px;
        }
        h1 {
            color: #007bff;
            font-weight: bold;
        }
        .bg-white {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        label {
            font-weight: bold;
            color: #343a40;
        }
        .highlight {
            color: #007bff;
            font-weight: bold;
        }
        .photo-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px; /* 适当的底部间距 */
        }
        .photo-preview {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            overflow: hidden;
            border: 2px solid #007bff;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .photo-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none; /* 初始隐藏 */
        }
        .photo-upload-input {
            display: none; /* 隐藏文件输入 */
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
        }
        .btn-custom:hover {
            background-color: #0727f1;
        }
        .form-section {
            margin-bottom: 1rem;
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

            // 点击照片预览触发文件选择
            $('#photoPreview').click(function() {
                $('#photoUpload').click();
            });
        });
    </script>
</head>
<body>
<div class="container">
    <a class="btn btn-secondary mb-4" href="${pageContext.request.contextPath}/employee/home"><i class="fas fa-arrow-left"></i> 返回主页</a>
    <h1 class="text-center">人力资源档案登记</h1>



    <form action="${pageContext.request.contextPath}/employee/register" method="post" enctype="multipart/form-data" class="p-4 bg-white">
        <input type="hidden" id="createdBy" name="createdBy"/>

        <div class="photo-container text-center">
            <div class="photo-preview" id="photoPreview">
                <img src="" alt="预览照片" />
            </div>
            <input type="file" id="photoUpload" name="photoUpload" class="photo-upload-input" accept="image/*" required/>
            <label for="photoUpload" class="d-block text-center mb-2">上传照片</label>
            <input type="hidden" name="photoUrl" id="photoUrl" />
        </div>

        <div class="row">
            <!-- 第一行 -->
            <div class="col-md-6 form-section">
                <label for="employeeName">姓名:</label>
                <input type="text" name="employeeName" id="employeeName" class="form-control" required/>
            </div>
            <div class="col-md-6 form-section">
                <label for="gender">性别:</label>
                <select name="gender" id="gender" class="form-control" required>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </div>

            <!-- 第二行 -->
            <div class="col-md-6 form-section">
                <label for="email">邮箱:</label>
                <input type="email" name="email" id="email" class="form-control" required/>
            </div>
            <div class="col-md-6 form-section">
                <label for="mobile">电话:</label>
                <input type="tel" name="mobile" id="mobile" class="form-control" required/>
            </div>

            <!-- 第三行 -->
            <div class="col-md-6 form-section">
                <label for="address">地址:</label>
                <input type="text" name="address" id="address" class="form-control" required/>
            </div>
            <div class="col-md-6 form-section">
                <label for="age">年龄:</label>
                <input type="number" name="age" id="age" class="form-control" required/>
            </div>

            <!-- 第四行 -->
            <div class="col-md-6 form-section">
                <label for="educationLevel">学历:</label>
                <select name="educationLevel" id="educationLevel" class="form-control" required>
                    <option value="本科">本科</option>
                    <option value="硕士">硕士</option>
                    <option value="博士">博士</option>
                </select>
            </div>
            <div class="col-md-6 form-section">
                <label for="level1Id">所属机构:</label>
                <select id="level1Id" name="level1Id" class="form-control" required>
                    <option value="" disabled selected>请选择一级机构</option>
                    <c:forEach var="level1" items="${level1Organizations}">
                        <option value="${level1.level1Id}">${level1.level1Name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- 第五行 -->
            <div class="col-md-6 form-section">
                <label for="level2Id">二级机构:</label>
                <select id="level2Id" name="level2Id" class="form-control" required>
                    <option value="" disabled selected>请选择二级机构</option>
                </select>
            </div>
            <div class="col-md-6 form-section">
                <label for="level3Id">三级机构:</label>
                <select id="level3Id" name="level3Id" class="form-control" required>
                    <option value="" disabled selected>请选择三级机构</option>
                </select>
            </div>

            <!-- 第六行 -->
            <div class="col-md-6 form-section">
                <label for="categoryId">职位类别:</label>
                <select id="categoryId" name="categoryId" class="form-control" required>
                    <option value="" disabled selected>请选择职位类别</option>
                    <c:forEach var="category" items="${positionCategories}">
                        <option value="${category.categoryId}">${category.categoryName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6 form-section">
                <label for="positionId">职位:</label>
                <select id="positionId" name="positionId" class="form-control" required>
                    <option value="" disabled selected>请选择职位</option>
                </select>
            </div>

            <!-- 第七行 -->
            <div class="col-md-6 form-section">
                <label for="major">专业:</label>
                <input type="text" name="major" id="major" class="form-control" required/>
            </div>
            <div class="col-md-6 form-section">
                <label for="salaryStandardId">薪资标准:</label>
                <select name="salaryStandardId" id="salaryStandardId" class="form-control" required>
                    <option value="" disabled selected>请选择薪资标准</option>
                    <c:forEach var="salaryStandard" items="${salaryStandards}">
                        <option value="${salaryStandard.salaryStandardID}">${salaryStandard.standardName}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- 第八行 -->
            <div class="col-md-6 form-section">
                <label for="bank">开户行:</label>
                <input type="text" name="bank" id="bank" class="form-control" required/>
            </div>
            <div class="col-md-6 form-section">
                <label for="accountNumber">银行账户:</label>
                <input type="text" name="accountNumber" id="accountNumber" class="form-control" required/>
            </div>
        </div>

        <div class="form-section">
            <label for="personalHistory">个人履历:</label>
            <textarea name="personalHistory" id="personalHistory" rows="5" class="form-control" required></textarea>
        </div>

        <input type="submit" value="提交" class="btn btn-custom mt-3"/>
    </form>
</div>
</body>
</html>
