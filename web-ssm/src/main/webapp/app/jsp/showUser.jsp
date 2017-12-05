<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>添加用户</title>
    <SCRIPT LANGUAGE=javascript>
        function p_del() {
            var msg = "您真的确定要删除吗？\n\n请确认！";
            if (confirm(msg) == true) {
                return true;
            } else {
                return false;
            }
        }
    </SCRIPT>

    <SCRIPT LANGUAGE=javascript>
        function re() {
            var msa = "您真的确定要退出吗？\n\n请确认！";
            if (confirm(msa) == true) {
                return true;
            } else {
                return false;
            }
        }
    </SCRIPT>
</head>
<body>
<div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<h>#</h>
<marquee width=400 behavior=alternate direction=left align=middle border=1 style="color:red;"
         onmousemove="stop()" onmouseout="start()">欢迎光临${user.userName}</marquee>
<br>

<h>$-----------------------------------------------------------------------------$</h>
<br>
<c:if test="${!empty userList}">
    <c:forEach var="user" items="${userList}">
        头像：<img src="<%=basePath%>${user.imageUrl}" style="width: 80px" style="height:60px" alt=""/>
        姓名：${user.userName}&nbsp;&nbsp;
        手机号：${user.userPhone} &nbsp;&nbsp;
        邮箱：${user.userEmail}
    </c:forEach>
</c:if>
<br>
    <c:if test="${!empty users}">
        <c:forEach var="user" items="${users}">
            头像：<img src="<%=basePath%>${user.imageUrl}" style="width: 80px" style="height:60px" alt=""/>
            姓名：${user.userName}&nbsp;&nbsp;
            手机号：${user.userPhone} &nbsp;&nbsp;
            邮箱：${user.userEmail}
        </c:forEach>
    </c:if>

<div style="position:absolute;font-size:20px;color:blue;font-weight:bold;width:360px;">
    <script>
        document.write((zjd=new Date()).getFullYear()+"年"+(zjd.getMonth()+1)+"月"+zjd.getDate() + "日 星期"+"日一二三四五六".charAt(zjd.getDay())+ " "+zjd.getHours() +":"+zjd.getMinutes()+":"+zjd.getSeconds());
    </script>
</div>
</div>
</body>
</html>
