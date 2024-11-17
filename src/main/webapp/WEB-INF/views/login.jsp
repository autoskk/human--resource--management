<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户登录</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>用户登录</h1>
<form id="loginForm">
    <label for="username">用户名:</label>
    <input type="text" id="username" name="username" required>
    <br>
    <label for="password">密码:</label>
    <input type="password" id="password" name="password" required>
    <br>
    <button type="submit">登录</button>
</form>
<div id="loginMessage"></div>

<script>
    $(document).ready(function(){
        $('#loginForm').on('submit', function(event) {
            event.preventDefault();

            const username = $('#username').val();
            const password = $('#password').val();

            $.ajax({
                url: '/api/users/login',
                type: 'POST',
                data: {
                    username: username,
                    password: password
                },
                success: function(data) {
                    $('#loginMessage').html('登录成功! 欢迎, ' + data.username);
                },
                error: function() {
                    $('#loginMessage').html('登录失败。请检查您的用户名和密码。');
                }
            });
        });
    });
</script>
</body>
</html>
