// 声明专门的函数显示确认模态框
function showConfirmModal(roleArray) {
    // 显示模态框
    $("#confirmModal").modal("show");
    // 清楚旧数据
    $("#roleNameSpan").empty();

    // 在全局变量范围创建数组角色用来存放角色id
    window.roleIdArray = []

    // 遍历数组
    for (var i = 0; i < roleArray.length; i++) {
        var role = roleArray[i];
        var roleName = role.roleName;
        $("#roleNameSpan").append(roleName + "\t");

        var roleId = role.roleId;

        // 调用数组对象的push()方法存入新元素
        window.roleIdArray.push(roleId);
    }
}

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

    // console.log(ajaxResult);

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

    // 这里清空是为了让没有搜索结果时不显示页码导航条
    $("#Pagination").empty();

    console.log(pageInfo == null)
    console.log(pageInfo == undefined)
    console.log(pageInfo.list == null)
    console.log(pageInfo.length ==0)
    // 判断pageInfo是否有效
    if(pageInfo == null || pageInfo == undefined || pageInfo.list == null || pageInfo.list.length ==0) {
        $("#rolePageBody").append("<tr><td colspan='4'>抱歉，没有查询到你搜索的数据</td></tr>")
        return ;
    }

    // 使用pageInfo的list属性填充tbody
    for (var i = 0; i < pageInfo.list.length; i++) {

        var role = pageInfo.list[i];

        var roleId = role.id;

        var roleName = role.name;

        var numberTd = "<td>" + (i+1) + "</td>";

        var checkboxTd = "<td><input id='"+roleId+"' class='itemBox' type='checkbox'></td>";

        var roleNameTd = "<td>" + roleName + "</td>";

        var checkBtn = "<button type='button' class='btn btn-success btn-xs'><i class=' glyphicon glyphicon-check'></i></button>";

        // 通过button标签的id属性（别的属性也可以）把roleId传递到button按钮的单击响应函数中，在单击响应函数中使用this.id拿到值
        var pencilBtn = "<button id='"+roleId+"' type='button' class='btn btn-primary btn-xs pencilBtn'><i class=' glyphicon glyphicon-pencil'></i></button>";

        // 通过button标签的id属性（别的属性也可以）把roleId传递到button按钮的单击响应函数中，在单击响应函数中使用this.id拿到值
        var removeBtn= "<button id='"+roleId+"' type='button' class='btn btn-danger btn-xs removeBtn'><i class=' glyphicon glyphicon-remove'></i></button>";

        var buttonTd = "<td>" + checkBtn +" "+ pencilBtn + " " + removeBtn + "</td>";


        var tr = "<tr>" +numberTd + checkboxTd+ roleNameTd + buttonTd + "</tr>";

        $("#rolePageBody").append(tr);

    }

    // 生成分页导航条
    generateNavigator(pageInfo);

}


// 生成分页页码导航条
function generateNavigator(pageInfo) {
    // 1. 获取总记录数
    var totalRecord = pageInfo.total;

    // 声明一个JSON对象存储Pagination要设置的属性
    var properties = {
        num_edge_entries: 3,            //边缘页数
        num_display_entries: 5,         //主体页数
        callback: paginationCallback,   //指定用户点击“翻页”的按钮时跳转的页面的回掉
        items_per_page: pageInfo.pageSize, //每页要显示的数据的数量
        // 当前页 pagination内部使用pageIndex来管理页码，pageIndex从0开始，pageNum从1开始，所以要-1
        current_page: pageInfo.pageNum-1,
        prev_text: "上一页",    //“前一页”分页按钮上显示的文字
        next_text: "下一页"     //“下一页”分页按钮上显示的文字
    };

    // 生成页码导航条
    $("#Pagination").pagination(totalRecord, properties)
}

// 翻页时的回调函数
function paginationCallback(pageIndex, jQuery) {
    // 根据pageIndex计算得到的pageNum
    window.pageNum = pageIndex +1;

    // 调用分页函数
    generatePage();
    // window.location.href = "admin/get/page.html?pageNum=" + pageNum + "&keyword=${param.keyword}";

    // 由于每一个按钮都是超链接，所以在这个函数最后去取消超链接的默认行为
    return false;
}


