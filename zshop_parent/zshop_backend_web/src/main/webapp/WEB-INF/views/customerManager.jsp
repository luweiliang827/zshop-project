<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html;charset=utf-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>backend</title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/index.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/file.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/zshop.css" />
    <!-- 引入分页插件js -->
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>

    <script>
        $(function () {
            //分页
            $('#pagcation').bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:${pageInfo.pageNum},
                totalPages:${pageInfo.pages},
                itemTexts(type,page,current){
                    switch (type) {
                        case "first":
                            return "首页";
                        case "prev":
                            return "上一页";
                        case "next":
                            return "下一页";
                        case "last":
                            return "末页";
                        case "page":
                            return page;
                    }
                },
                onPageClicked:function (event,originalEvent,type,page) {
                    $("#pageNum").val(page);
                    $('#searchCustomer').submit();
                }
            });

            $('#formAddCustomer').bootstrapValidator({
                feedbackIcons:{ //根据验证结果显示的各种图案
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields:{
                    name:{
                        validators:{
                            notEmpty:{
                                message:'用户名不能为空'
                            }
                        }
                    },
                    loginName: {
                        validators: {
                            notEmpty: {
                                message: '登录名不能为空'
                            }
                        }
                    },
                    password:{
                        validators: {
                            notEmpty:{
                                message:'密码不能为空'
                            }
                        }
                    },
                    phone:{
                        validators:{
                            notEmpty:{
                                message:'电话不能为空'
                            }
                        }
                    },
                    address:{
                        validators:{
                            notEmpty:{
                                message:'地址不能为空'
                            }
                        }
                    },
                    email:{
                        validators:{
                            notEmpty:{
                                message:'邮箱不能为空'
                            },
                            emailAddress:{
                                message:'请输入正确的邮箱地址'
                            }
                        }
                    }
                }
            })
        })
        function addCustomer() {
            $('#formAddCustomer').data("bootstrapValidator").validate();
            let flag = $('#formAddCustomer').data("bootstrapValidator").isValid();
            if(flag){
                $.post(
                    '${pageContext.request.contextPath}/backend/customer/addCustomer',
                    $('#formAddCustomer').serialize(),
                    function(result){
                        if(result.status ==1){
                            layer.msg("添加成功",{
                                time:1000,
                                skin:'successMsg'
                            },function () {
                                location.href='${pageContext.request.contextPath}/backend/customer/findAll?pageNum='+${pageInfo.pageNum}
                            })
                        }
                    }
                );
            }
        }

        function selectCustomerById(id){
            $.post(
                '${pageContext.request.contextPath}/backend/customer/findCustomerById',
                {'id':id},
                function (result) {
                    if(result.status == 1){
                        $('#id').val(result.data.id);
                        $('#name').val(result.data.name);
                        $('#loginName').val(result.data.loginName);
                        $('#phone').val(result.data.phone);
                        $('#address').val(result.data.address);
                    }
                }
            );
        }

        function modifyCustomer(){
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath}/backend/customer/modifyCustomer',
                data:{'id':$('#id').val(),
                      'name':$('#name').val(),
                      'loginName':$('#loginName').val(),
                      'phone':$('#phone').val(),
                      'address':$('#address').val()
                },
                dataType:'json',
                success:function (result) {
                    if(result){
                        if(result.status == 1){
                            layer.msg('修改成功',{
                                time:1000,
                                skin: 'successMsg'
                            },function () {
                                location.href='${pageContext.request.contextPath}/backend/customer/findAll?pageNum='+${pageInfo.pageNum};
                            })
                        }
                    }
                }
            });
        }

        function modifyStatus(id,btn){
            $.get(
                '${pageContext.request.contextPath}/backend/customer/modifyStatus',
                {'id':id},
                function (result) {
                    if(result.status == 1){
                        let $td=$(btn).parent().prev();
                        if($td.text().trim() == '有效'){
                            $td.text('无效');
                            $(btn).val('启用').removeClass('btn-danger').addClass('btn-success');
                        }else{
                            $td.text('有效');
                            $(btn).val('禁用').removeClass('btn-success').addClass('btn-danger');
                        }
                    }
                }
            );
        }
    </script>
</head>

<body>
    <div class="panel panel-default" id="userInfo" id="homeSet">
        <div class="panel-heading">
            <h3 class="panel-title">客户管理</h3>
        </div>
        <div class="panel-body">
            <div class="showusersearch">
                <form class="form-inline" method="post" id="searchCustomer" action="${pageContext.request.contextPath}/backend/customer/findAll">
                  <div class="form-group">
                    <label for="customer_name">姓名:</label>
                    <input type="text" class="form-control"id="customer_name" name="name" placeholder="请输入姓名" size="15px" value="${customer.name}">
                  </div>
                  <div class="form-group">
                    <label for="customer_loginName">帐号:</label>
                    <input type="text" class="form-control" id="customer_loginName" name="loginName" placeholder="请输入帐号" size="15px" value="${customer.loginName}">
                  </div>
                  <div class="form-group">
                    <label for="customer_phone">电话:</label>
                    <input type="text" class="form-control" id="customer_phone" name="phone" placeholder="请输入电话" size="15px" value="${customer.phone}">
                  </div>
                  <div class="form-group">
                    <label for="customer_address">地址:</label>
                    <input type="text" class="form-control" id="customer_address" name="address" placeholder="请输入地址" value="${customer.address}">
                  </div>
                  <div class="form-group">
                    <label for="customer_isValid">状态:</label>
                        <select class="form-control" id="customer_isValid" name="isValid">
                            <option value="-1">全部</option>
                            <option value="1" <c:if test="${customer.isValid == 1}">selected</c:if>>---有效---</option>
                            <option value="0" <c:if test="${customer.isValid == 0}">selected</c:if>>---无效---</option>
                        </select>
                  </div>
                  <input type="submit" value="查询" class="btn btn-primary" id="doSearch">
                </form>
            </div>
            <br>
            <input type="button" value="添加客户" class="btn btn-primary" id="doAddManger">
            <div class="show-list text-center" style="position: relative;top: 10px;">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">序号</th>
                            <th class="text-center">姓名</th>
                            <th class="text-center">帐号</th>
                            <th class="text-center">电话</th>
                            <th class="text-center">地址</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                        <c:forEach items="${pageInfo.list}" var="customer">
                            <tr>
                                <td>${customer.id}</td>
                                <td>${customer.name}</td>
                                <td>${customer.loginName}</td>
                                <td>${customer.phone}</td>
                                <td>${customer.address}</td>
                                <td>
                                    <c:if test="${customer.isValid == 1}">有效</c:if>
                                    <c:if test="${customer.isValid == 0}">无效</c:if>
                                </td>
                                <td class="text-center">
                                    <input type="button" class="btn btn-warning btn-sm doModify" value="修改" onclick="selectCustomerById(${customer.id})">
                                    <input type="button" class="btn btn-danger btn-sm doDisable" value="禁用" onclick="modifyStatus(${customer.id},this)">
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <ul id="pagcation"></ul>
            </div>
        </div>
    </div>

    <!-- 添加系统用户 start -->
    <div class="modal fade" tabindex="-1" id="myMangerUser">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加客户</h4>
                </div>
                <form id="formAddCustomer">
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <div class="form-group">
                                <label for="marger-username" class="col-sm-4 control-label">用户姓名：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="marger-username" name="name">
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <div class="form-group">
                                <label for="marger-loginName" class="col-sm-4 control-label">帐号：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="marger-loginName" name="loginName">
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <div class="form-group">
                                <label for="marger-password" class="col-sm-4 control-label">登录密码：</label>
                                <div class="col-sm-4">
                                    <input type="password" class="form-control" id="marger-password" name="password">
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <div class="form-group">
                                <label for="marger-phone" class="col-sm-4 control-label">联系电话：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="marger-phone" name="phone">
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <div class="form-group">
                                <label for="marger-adreess" class="col-sm-4 control-label">联系地址：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="marger-adreess" name="address"/>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <div class="form-group">
                                <label for="marger-adrees" class="col-sm-4 control-label">联系邮箱：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="marger-adrees" name="email"/>
                                </div>
                            </div>
                        </div>
                        <br>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary " type="button" onclick="addCustomer()">添加</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal" type="button">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- 添加系统用户 end -->

    <!-- 修改客户信息 start -->
    <div class="modal fade" tabindex="-1" id="myModal">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改客户</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="id" class="col-sm-4 control-label">编号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" disabled="disabled" id="id">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="name" class="col-sm-4 control-label">姓名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="name">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="loginName" class="col-sm-4 control-label">帐号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="loginName">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="phone" class="col-sm-4 control-label">电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="phone">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="address" class="col-sm-4 control-label">地址：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="address">
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" onclick="modifyCustomer()">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 修改客户信息 end -->
</body>

</html>