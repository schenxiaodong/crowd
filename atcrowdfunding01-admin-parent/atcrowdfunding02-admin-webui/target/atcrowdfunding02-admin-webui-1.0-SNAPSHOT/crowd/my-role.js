// 总函数
// 执行分页，生成页面效果，任何时候调用这个函数都会重新加载页面
function generatePage() {

    // 1.获取分页数据
    var pageInfo = getPageInfoRemote();

    // 2.填充表格
    fillTableBody(pageInfo)

}

// 远程访问服务器端获取PageInfo数据
function getPageInfoRemote() {
    // 同步方式
    var ajaxResult = $.ajax({
        "url": "role/get/page/info.json",
        "type": "post",
        "async": false,
        "data": {
            "pageNum": window.pageNum,
            "pageSize": window.pageSize,
            "keyword": window.keyword
        },
        "resultType": "json",
    });

    console.log(ajaxResult);

    // 如果当前响应状态码不是200，说明发生了错误或其他意外情况，显示提示信息，让当前函数停止运行
    var statusCode = ajaxResult.status;
    if(statusCode != 200) {
        layer.msg("失败! 响应状态码=" + statusCode +",说明信息" + ajaxResult.statusText);
        return null;
    }
    // 如果响应状态码是200，说明请求成功，获取PageInfo
    var resultEntity = ajaxResult.responseJSON;

    // 从resultEntity获取result属性
    var result = resultEntity.result;

    // 判断result是否成功
    if(result == "FAILED") {
        layer.msg(resultEntity.message)
    }

    // 确认result为成功后获取pageInfo
    var pageInfo = resultEntity.data;

    // 返回pageInfo
    return pageInfo;
}

// 填充表格
function fillTableBody(pageInfo) {

    // 清楚tbody中的旧的内容
    $("#rolePageBody").empty();

    // 判断pageInfo是否有效
    if(pageInfo == null || pageInfo == undefined || pageInfo.list == null || pageInfo.length ==0) {
        $("#rolePageBody").append("<tr><td colspan='4'>抱歉，没有查询到你搜索的数据</td></tr>")
        return ;
    }

    // 使用pageInfo的list属性填充tbody
    for (var i = 0; i < pageInfo.list.length; i++) {

        var role = pageInfo.list[i];

        var roleId = role.id;

        var roleName = role.name;

        var numberTd = "<td>" + (i+1) + "</td>";

        var checkboxTd = "<td><input type='checkbox'></td>";

        var roleNameTd = "<td>" + roleName + "</td>";

        var checkBtn = "<button type='button' class='btn btn-success btn-xs'><i class=' glyphicon glyphicon-check'></i></button>";

        var pencilBtn = "<button type='button' class='btn btn-primary btn-xs'><i class=' glyphicon glyphicon-pencil'></i></button>";

        var removeBtn= "<button type='button' class='btn btn-danger btn-xs'><i class=' glyphicon glyphicon-remove'></i></button>";

        var buttonTd = "<td>" + checkBtn +" "+ pencilBtn + " " + removeBtn + "</td>";


        var tr = "<tr>" +numberTd + checkboxTd+ roleNameTd + buttonTd + "</tr>";

        $("#rolePageBody").append(tr);

    }

}


// 生成分页页码导航条
function generateNavigator(pageInfo) {

}

// 翻页时的回调函数
function paginationCallback(pageIndex, jQuery) {

}