<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>重置密码</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .container {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
      width: 400px;
      text-align: center;
    }
    h1 {
      margin-bottom: 20px;
      color: #333;
    }
    label {
      display: block;
      margin: 10px 0 5px;
      text-align: left;
      color: #555;
    }
    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      margin-bottom: 15px;
      font-size: 16px;
    }
    button {
      width: 100%;
      padding: 10px;
      border: none;
      border-radius: 4px;
      background-color: #007bff;
      color: white;
      font-size: 16px;
      cursor: pointer;
      margin-bottom: 10px;
    }
    button:hover {
      background-color: #0056b3;
    }
    .btn {
      background-color: #6c757d; /* 灰色 */
    }
    .btn:hover {
      background-color: #5a6268; /* 深灰 */
    }
    #resetMessage {
      margin-top: 15px;
      color: #d9534f; /* 红色 */
    }
  </style>
</head>
<body>

<div class="container">
  <h1>重置密码</h1>
  <form id="resetPasswordForm">
    <label for="username">用户名:</label>
    <input type="text" id="username" name="username" required>

    <label for="newPassword">新密码:</label>
    <input type="password" id="newPassword" name="newPassword" required>

    <label for="confirmPassword">确认密码:</label>
    <input type="password" id="confirmPassword" name="confirmPassword" required>

    <button type="submit">重置密码</button>
    <button type="button" class="btn" onclick="window.location.href='/login'">返回</button>
  </form>
  <div id="resetMessage"></div>
</div>

<script>
  $(document).ready(function() {
    $('#resetPasswordForm').on('submit', function(event) {
      event.preventDefault();

      const username = $('#username').val().trim();
      const newPassword = $('#newPassword').val().trim();
      const confirmPassword = $('#confirmPassword').val().trim();

      if (newPassword !== confirmPassword) {
        $('#resetMessage').html('两次输入的密码不一致，请重新输入。').css('color', '#d9534f'); // 红色
        return;
      }

      $.ajax({
        url: '/users/reset-password',
        type: 'POST',
        data: {
          username: username,
          newPassword: newPassword
        },
        success: function() {
          $('#resetMessage').html('密码重置成功！').css('color', '#5cb85c'); // 绿色
        },
        error: function() {
          $('#resetMessage').html('密码重置失败，请重试。').css('color', '#d9534f'); // 红色
        }
      });
    });
  });
</script>
</body>
</html>
