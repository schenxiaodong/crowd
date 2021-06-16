<%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2021/6/7
  Time: 22:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zh-CN">
<%@ include file="/WEB-INF/include-head.jsp" %>
<script type="text/javascript">
    $(function () {
        $("#asyncBtn").click(function () {
            console.log("Ajax函数之前")
            $.ajax({
                "url": "test/ajax/async.html",
                "type": "post",
                "dataType": "text",
                // 3.增加属性关闭async使ajax同步
                // 关闭异步工作模型，使用同步方式工作。此时，所有的线程都在同一个线程中执行
                "async": false,
                "success": function (response){

                    // success 是接收到服务器端响应后执行
                    console.log("Ajax函数内部的success函数" + response);
                }
            });
            // 1. 在$.ajax()执行后执行，不等待$.ajax()执行完成
            // console.log("Ajax函数之后")

            // 2. 实验setTimeout函数强行使线程同步
            // setTimeout(function () {
            //     console.log("Ajax函数之后")
            // }, 5000)

            // 3
            console.log("Ajax函数之后")
        })
    })
</script>
<body>
<%@ include file="/WEB-INF/include-nav.jsp" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/include-sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <button id="asyncBtn">发送Ajax请求</button>
        </div>
    </div>
</div>

</body>
</html>