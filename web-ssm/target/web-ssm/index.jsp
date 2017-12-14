
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%= this.getServletContext().getContextPath() %>
<html>
<head>
    <title>首页</title>
</head>
<body>
<h1>欢迎进入!</h1>

<form action="${pageContext.request.contextPath}/user/login" method="post">
    <table width="300" border="1" align="center">
        <tr>
            <td colspan="2">登入窗口</td>
        </tr>
        <tr>
            <td>用户名:</td>
            <td><input type="text" name="userName">
            </td>
        </tr>
        <tr>
            <td>密码:</td>
            <td><input type="password" name="userPwd"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" name="submit" value="登录"/>
            </td>
        </tr>
    </table>
</form>
<form action="${pageContext.request.contextPath}/user/query" method="post">
    <input type="submit" value="查询"/>
</form>
</body>
</html>

