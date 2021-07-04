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
<link rel="stylesheet" href="css/pagination.css" >
<script type="text/javascript" src="jquery/jquery.pagination.js"></script>
<script type="text/javascript" src="crowd/my-role.js"></script>
<script type="text/javascript">
    $(function (){
        // 1.为分页操作准备初始化数据(全局)
        window.pageNum = 1;
        window.pageSize = 5;
        window.keyword = "";


        // 2. 调用执行分页的函数，显示分页效果
        generatePage();

        // 3.给查询按钮绑定单击响应函数
        $("#searchBtn").click(function () {
            // ①.获取关键词数据赋值给对应的全局变量
            window.keyword = $("#keywordInput").val();

            // ②.调用分页函数刷新页面
            generatePage();
        });

        // 4.点击新增按钮打开模态框
        $("#showAddModalBtn").click(function () {
            $("#addModal").modal("show");
        });

        $("#saveRoleBtn").click(function () {

            // ①获取用户在文本框中输入的角色名称
            // #addModal 表示找到整个模态框
            // 空格表示在后代元素中继续查找
            // [name = roleName] 匹配 name 属性等于 roleName 的后代元素
            // $.trim() 去掉前后空格
            var roleName = $.trim($("#addModal [name = roleName]").val());

            // 发送Ajax请求
            $.ajax({
                "url": "role/save.json",
                "type": "post",
                "data": {
                    "name": roleName,

                },
                "dataType": "json",
                "success": function (response) {
                    var result = response.result;

                    if(result == "SUCCESS") {
                        layer.msg("操作成功");

                        // 将页码定位到最后一页
                        window.pageNum = 999999;

                        // 重新加载分页数据
                        generatePage()
                    }

                    if(result == "FAILED") {
                        layer.msg("操作失败 " + response.message)
                    }

                },
                "error": function (response) {
                    layer.msg(response.status + " " + response.statusText);
                }
            });

            // 关闭模态框
            $("#addModal").modal("hide")

            // 清理模态框
            $("#addModal [name = roleName]").val("");

        })

        // 6.给页面上的铅笔按钮绑定单击响应函数，目的是打开模态框
        // 传统的事件绑定方式只能在第一个页面有效，翻页后就失效了
        // $(".pencilBtn").click(function () {
        //     alert("aaaa")
        // })
        // 使用jQuery对象的on()函数可以解决上述问题
        // ①首先找到所有动态生成的元素所附着的静态元素
        // ②on()函数的第一个参数是事件类型
        // ②on()函数的第二个参数是找到真正要绑定事件的元素的选择器
        // ②on()函数的第三个参数是事件的响应函数
        $("#rolePageBody").on("click",".pencilBtn", function () {
            $("#editModal").modal("show");

            // 获取表格中当前行中的角色名称
            // $(this) 获取当前按钮选择器 .parent() 获取父容器的选择器 .prev() 获取同级容器，在当前容器前一个的容器 .text() 的文本值;
            var roleName = $(this).parent().prev().text();

            // 获取当前角色的id
            // 依据是：var pencilBtn = "<button id='"+roleId+"' 这段代码我们把roleId设置到了id属性中了
            window.roleId = this.id;

            layer.msg(roleName)

            // 使用roleName的值设置模态框中的文本框
            $("#editModal [name = roleName]").val(roleName);

        })

        // 7. 给更新模态框中的更新按钮绑定单击响应函数
        $("#updateRoleBtn").click(function () {

            // ①从文本框中获取新的角色名称
            var roleName = $("#editModal [name = roleName]").val();

            // ②发送Ajax请求执行更新
            $.ajax({
                "url": "role/update.json",
                "type": "post",
                "data": {
                    "id": window.roleId,
                    "name": roleName
                },
                "dataType": "json",
                "success": function (response) {
                    var result = response.result;

                    if(result == "SUCCESS") {
                        layer.msg("操作成功");

                        // 重新加载分页数据
                        generatePage()
                    }

                    if(result == "FAILED") {
                        layer.msg("操作失败 " + response.message)
                    }

                },
                "error": function (response) {
                    layer.msg(response.status + " " + response.statusText);
                }
            });

            // ③关闭模态框
            $("#editModal").modal("hide")
        })

        var roleArray = [{roleId: 5,roleName: "aaa"},{roleId: 6,roleName: "bbb"}]

        showConfirmModal(roleArray);

        // 8.点击确认模态框中的确认删除按钮执行删除
        $("#removeRoleBtn").click(function () {
            // 从全局变量获取到角色变量数组，转换为JSON数据
            var requestBody = JSON.stringify(window.roleIdArray);
            $.ajax({
                "url": "role/remove/by/role/id/array.json",
                "type": "POST",
                "data": requestBody,
                "contentType": "application/json;charset=UTF-8",
                "dataType": "json",
                "success": function (response) {
                    var result = response.result;
                    if(result == "SUCCESS") {
                        layer.msg("操作成功");

                        // 重新加载分页数据
                        generatePage()
                    }

                    if(result == "FAILED") {
                        layer.msg("操作失败 " + response.message)
                    }

                },
                "error": function (response) {
                    layer.msg(response.status + " " + response.statusText);
                }
            });

            // 关闭模态框
            $("#confirmModal").modal("hide");

            // 重置全选框状态
            $("#summaryBox").prop("checked", false);
        });

        // 9.给单条删除按钮绑定单击响应函数
        $("#rolePageBody").on("click",".removeBtn", function () {

            // 从当前按钮出发，获取角色的名称
            var roleName = $(this).parent().prev().text();

            // 创建role对象，存入到数组中
            var roleArray = [{
                "roleId": this.id,
                "roleName": roleName
            }]

            // 调用专门的函数打开模态框
            showConfirmModal(roleArray)
        })

        // 10.给多选框绑定单击响应函数
        $("#summaryBox").click(function () {
            // 1.获取当前多选框自身的状态
            var currentStatus = this.checked();

            // 2.用当前多选框的状态设置其他多选框
            $(".itemBox").prop("checked", currentStatus);
        })

        // 11.全选，全不选的反向操作
        $("#rolePageBody").on("click",".itemBox", function () {

            // 获取当前已经选中的 itemBox 的数量
            var checkedBoxCount = $(".itemBox:checked").length;

            // 获取全部.itemBox的数量
            var totalBoxCount = $(".itemBox").length;

            // 通过比较对总的checkedBox 进行设置
            $("#summaryBox").prop("checked", checkedBoxCount == totalBoxCount);
        })

        // 12.给批量删除按钮绑定单击响应函数
        $("#batchRemoveBtn").click(function () {
            // 1.创建一个数组对象，用来存放后面获取到的角色对象
            var roleArray = [];

            // 2.遍历当前选中的多选框
            $(".itemBox:checked").each(function () {
                // 使用this引用当前遍历得到的多选框
                var roleId = this.id;

                // 通过DOM操作获取角色名称
                var roleName = $(this).parent().next().text();

                roleArray.push({
                    "roleId": roleId,
                    "roleName": roleName
                })

            })

            // 3.检查roleArray的长度是否为0
            if (roleArray.length == 0) {
                layer.msg("请至少选择一个执行删除");
                return;
            }

            // 4.调用专门的函数打开模态框
            showConfirmModal(roleArray);

        })
    })
</script>

<body>
<%@ include file="/WEB-INF/include-nav.jsp" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/include-sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="keywordInput" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" id="searchBtn" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" id="batchRemoveBtn" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" id="showAddModalBtn" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <button type="button" id="showEditModalBtn" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 更新</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input id="summaryBox" type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <!-- 通过js向其填充代码. -->
                            <tbody id="rolePageBody">

                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <div id="Pagination" class="pagination"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%@ include file="/WEB-INF/modal-role-add.jsp"%>
<%@ include file="/WEB-INF/modal-role-edit.jsp"%>
<%@ include file="/WEB-INF/modal-role-confirm.jsp"%>
</body>
</html>