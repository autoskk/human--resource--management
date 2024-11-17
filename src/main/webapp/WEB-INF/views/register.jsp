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
  <button type="submit">注册</button>
</form>
<div id="registerMessage"></div>

<script>
  $(document).ready(function(){
    $('#registerForm').on('submit', function(event) {
      event.preventDefault();

      const username = $('#username').val();
      const password = $('#password').val();

      $.ajax({
        url: '/api/users', // 用户添加 API 端点
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
          username: username,
          password: password
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
