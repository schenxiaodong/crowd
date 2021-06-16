<%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2021/6/4
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
  <head>
    <title>$Title$</title>
    <!-- http://localhost:8080/atcrowdfunding02_admin_webui/ -->
    <!--
      {pageContext.request.serverPort}{pageContext.request.contextPath}
      中间不加路径/，因为{pageContext.request.contextPath}前面自带/，
      {pageContext.request.contextPath}后面加/，因为页面内容前面不加/
    -->
    <base href="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/" />
    <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
    <script type="text/javascript">
      $(function () {
        $('#btn1').click(function () {
          $.ajax({
            "url": "send/array/one.html",
            "type": "post",
            "data": {
              "array": [5,8,10]
            },
            "dataType": "text",
            "success": function (response) {
              alert(response)
            },
            "error": function (response) {
              alert(response)
            }
          })
        });
        $('#btn2').click(function () {
          $.ajax({
            "url": "send/array/two.html",
            "type": "post",
            "data": {
              "array[0]": 5,
              "array[1]": 8,
              "array[2]": 10,
            },
            "dataType": "text",
            "success": function (response) {
              alert(response)
            },
            "error": function (response) {
              alert(response)
            }
          })
        });
        $('#btn3').click(function () {
          var data = [5,8,10];
          var tempJson = JSON.stringify(data);

          $.ajax({
            "url": "send/array/three.html",
            "type": "post",
            "data": tempJson,
            "contentType": "application/json;charset=UTF-8",
            "dataType": "text",
            "success": function (response) {
              alert(response)
            },
            "error": function (response) {
              alert(response)
            }
          })
        });

        $("#btn4").click(function() {
          var student = {
            'stuId': 6,
            'stuName': 'tom',
            address: {
              'province': '四川',
              'city': '成都',
              'street': '简阳'
            },
            subjectList: [
              {
                'subjectName': 'JavaEE',
                'subjectScore': 100
              },
              {
                'subjectName': 'SSM',
                'subjectScore': 99
              }
            ],
            map: {
              'k1': 'v1',
              'k2': 'v2'
            }
          };

          var requestBody = JSON.stringify(student);

          $.ajax({
            'url': 'send/complex/object.json',
            'method': 'post',
            'data': requestBody,
            'contentType': 'application/json;charset=UTF-8',
            'dataType': 'json',
            'success': function (response) {
              alert(response);
              console.log(response);
            },
            'error': function (response) {
              console.log(response)
            }
          })
        });

        $("#btn5").click(function () {
          layer.msg("Layer的弹框");
        })





      })

    </script>
  </head>
  <body>
    $END$
    <a href="test/ssm.html">测试SSM整合环境</a><br>
    <button >Test Request Body</button><br>
    <button id="btn1"> Send [2,6,8] One</button>
    <br>
    <button id="btn2"> Send [2,6,8] Two</button>
    <br>
    <button id="btn3"> Send [2,6,8] Three</button>
    <br>
    <button id="btn4"> Send Complex Object</button>

    <br>
    <button id="btn5">点我弹框</button>

  </body>
</html>
