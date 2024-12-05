<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>用户注册</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      padding: 0;
      margin: 0;
    }
    .container {
      max-width: 400px;
      margin: 50px auto; /* 上下居中 */
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    }
    h1 {
      text-align: center;
      color: #333;
      margin-bottom: 20px;
    }
    label {
      display: block;
      margin: 10px 0 5px;
      color: #555;
    }
    input[type="text"], input[type="password"], select {
      width: 100%;
      padding: 12px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 14px;
      transition: border-color 0.3s; /* 添加过渡效果 */
    }
    input:focus, select:focus {
      border-color: #007bff; /* 聚焦时的边框颜色 */
      outline: none; /* 移除默认轮廓 */
    }
    button {
      background-color: #007bff;
      color: white;
      padding: 12px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      width: 100%;
      font-size: 16px;
      transition: background-color 0.3s; /* 添加过渡效果 */
    }
    button:hover {
      background-color: #0056b3;
    }
    .btn {
      background-color: #6c757d;
    }
    .btn:hover {
      background-color: #5a6268;
    }
    #registerMessage {
      text-align: center;
      margin-top: 15px;
      color: #d9534f; /* Bootstrap危险色 */
      font-weight: bold; /* 加粗文本 */
    }
    @media (max-width: 400px) {
      .container {
        padding: 15px; /* 小屏幕时少一点内边距 */
      }
    }
  </style>
</head>
<body>
<div class="container">
  <h1>用户注册</h1>
  <form id="registerForm">
    <label for="username">用户名:</label>
    <input type="text" id="username" name="username" required>

    <label for="password">密码:</label>
    <input type="password" id="password" name="password" required>

    <label for="role">角色:</label>
    <select id="role" name="role" required>
      <!-- 角色选项将通过JS动态填充 -->
    </select>
    <button type="submit">注册</button>
    <button type="button" class="btn" onclick="window.location.href='/login'">返回</button>
  </form>
  <div id="registerMessage"></div>
</div>

<script>
  $(document).ready(function(){
    // 获取角色列表并填充下拉框
    $.ajax({
      url: '/roles', // 获取角色的API
      type: 'GET',
      success: function(roles) {
        roles.forEach(function(role) {
          $('#role').append(new Option(role.roleName, role.roleId)); // 假设role有name和id属性
        });
      },
      error: function() {
        $('#registerMessage').html('无法加载角色列表。');
      }
    });

    // 处理注册表单提交
    $('#registerForm').on('submit', function(event) {
      event.preventDefault();

      const username = $('#username').val();
      const password = $('#password').val();
      const roleId = $('#role').val(); // 获取选择的角色ID

      $.ajax({
        url: '/users', // 用户添加 API 端点
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
          userName: username,
          userPassword: password,
          roleId: roleId // 创建角色对象
        }),
        success: function() {
          $('#registerMessage').html('注册成功! 您可以现在登录。');
          window.location.href = 'login';
        },
        error: function() {
          $('#registerMessage').html('注册失败。请重试。');
        }
      });
    });
  });
</script>
</body>
</html>
