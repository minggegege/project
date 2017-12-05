
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%= this.getServletContext().getContextPath() %>
<html>
<head>
    <title>站内搜索引擎</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/user/login" method="post">
    <input type="checkbox"/>标题
    关键字：<input type="text" style="width: 150px" name="name">
    <input type="submit" value="搜索" style="background-color: gray"/>
    <input type="button" value="高级搜索▼" style="background-color: orange"/>
</form>
    <p></p>
    <%--<input type="checkbox"/>标题
    关键字：<input type="text" style="width: 150px"/>
    <select>
        <option>==所有站点==</option>
        <option>新闻资讯</option>
        <option>专题</option>
        <option>企业发布</option>
        <option>知识库</option>
    </select><p></p>
    起始时间：<input type="text" style="width: 150px"/>
    终止时间：<input type="text" style="width: 150px"/>
    <input type="submit" value="搜索"/><input type="button" value="收起▲"/>--%>

<c:if test="${null!=pageBean}">
    <table align="center" border="1px">
        <tr>
            <td>专题名</td>
            <td>专题类型</td>
            <td>专题信息</td>
            <td>发布时间</td>
        </tr>
        <c:forEach items="${pageBean.beanList}" var="aa">
            <tr>
                <td>${aa.topicName }</td>
                <td>${aa.topicType }</td>
                <td>${aa.topicInfo }</td>
                <td>${aa.publishDate }</td>
            </tr>
        </c:forEach>
        <jsp:include page="paging.jsp"></jsp:include>
    </table>
</c:if>
</body>
</html>
