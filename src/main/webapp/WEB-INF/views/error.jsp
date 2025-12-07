<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Education Platform</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            text-align: center;
            max-width: 500px;
        }
        .error-container h1 {
            color: #dc3545;
            font-size: 72px;
            margin-bottom: 20px;
        }
        .error-container h2 {
            color: #333;
            margin-bottom: 15px;
        }
        .error-container p {
            color: #666;
            margin-bottom: 30px;
        }
        .btn-home {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>⚠️</h1>
        <h2>Oops! Something went wrong</h2>
        <p>${error != null ? error : 'An unexpected error occurred. Please try again later.'}</p>
        <a href="${pageContext.request.contextPath}/login" class="btn-home">Go to Login</a>
    </div>
</body>
</html>
