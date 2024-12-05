<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录</title>
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
            color: #333;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        h1 {
            text-align: center;
            color: #007bff;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .links {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
        }
        #loginMessage {
            margin-top: 15px;
            text-align: center;
            color: red; /* 失败时的提示颜色 */
        }
    </style>
</head>
<body>

<div class="container">
    <h1>用户登录</h1>
    <form id="loginForm">
        <label for="username">用户名:</label>
        <input type="text" id="username" name="username" required autofocus>

        <label for="password">密码:</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">登录</button>
    </form>
    <div class="links">
        <a href="/register">去注册</a>
        <a href="/reset-password">忘记密码?</a>
    </div>
    <div id="loginMessage"></div>
</div>

<script>
    $(document).ready(function(){
        // 获取当前用户信息
        const currentUser = JSON.parse(sessionStorage.getItem('currentUser'));
        if(currentUser){
            $('#loginMessage').html('您已登录，欢迎回来，' + currentUser.userName).css('color', 'green');
            // 可选: 跳转到登记薪酬标准页面
            window.location.href = 'index'; // 或其他页面
        }
        $('#loginForm').on('submit', function(event) {
            event.preventDefault();

            const username = $('#username').val();
            const password = $('#password').val();

            $.ajax({
                url: '/users/login',
                type: 'POST',
                data: {
                    username: username,
                    password: password
                },
                success: function(user) {
                    // 登录成功，将 currentUser 存储到 Session Storage
                    sessionStorage.setItem('currentUser', JSON.stringify(user));
                    $('#loginMessage').html('登录成功! 欢迎, ' + username).css('color', 'green');
                    // 可选: 跳转到登记薪酬标准页面
                    window.location.href = 'index'; // 或其他页面
                },
                error: function() {
                    $('#loginMessage').html('登录失败。请检查您的用户名和密码。').css('color', 'red');
                }
            });
        });
    });
</script>

</body>
</html>
