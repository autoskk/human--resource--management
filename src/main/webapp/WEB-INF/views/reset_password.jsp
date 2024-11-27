<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>重置密码</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>重置密码</h1>
<form id="resetPasswordForm">
  <label for="username">用户名:</label>
  <input type="text" id="username" name="username" required>
  <br>
  <label for="newPassword">新密码:</label>
  <input type="password" id="newPassword" name="newPassword" required>
  <br>
  <button type="submit">重置密码</button>
</form>
<div id="resetMessage"></div>

<script>
  $(document).ready(function(){
    $('#resetPasswordForm').on('submit', function(event) {
      event.preventDefault();

      const username = $('#username').val();
      const newPassword = $('#newPassword').val();

      $.ajax({
        url: '/users/reset-password',
        type: 'POST',
        data: {
          username: username,
          newPassword: newPassword
        },
        success: function() {
          $('#resetMessage').html('密码重置成功！');
        },
        error: function() {
          $('#resetMessage').html('密码重置失败。请重试。');
        }
      });
    });
  });
</script>
</body>
</html>
