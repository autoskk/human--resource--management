<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>用户注册</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>用户注册</h1>
<form id="registerForm">
  <label for="username">用户名:</label>
  <input type="text" id="username" name="username" required>
  <br>
  <label for="password">密码:</label>
  <input type="password" id="password" name="password" required>
  <br>
  <label for="role">角色:</label>
  <select id="role" name="role" required>
    <!-- 角色选项将通过JS动态填充 -->
  </select>
  <br>
  <button type="submit">注册</button>
</form>
<div id="registerMessage"></div>

<script>
  $(document).ready(function(){
    // 获取角色列表并填充下拉框
    $.ajax({
      url: '/api/roles', // 获取角色的API
      type: 'GET',
      success: function(roles) {
        roles.forEach(function(role) {
          $('#role').append(new Option(role.roleName, role.roleID)); // 假设role有name和id属性
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
        url: '/api/users', // 用户添加 API 端点
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
          username: username,
          password: password,
          roleId: roleId // 创建角色对象
        }),
        success: function() {
          $('#registerMessage').html('注册成功! 您可以现在登录。');
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
