<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: luweiliang
  Date: 2019/6/8
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 模板插件 -->
<script src="${pageContext.request.contextPath}/js/template.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css" />
<script id="welcome" type="text/html">
    <li class="userName">
        欢迎您：{{name}}
    </li>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle user-active" data-toggle="dropdown" role="button">
            <img class="img-circle" src="${pageContext.request.contextPath}/images/user.jpeg" height="30" />
            <span class="caret"></span>
        </a>
        <ul class="dropdown-menu">
            <li>
                <a href="#" data-toggle="modal" data-target="#modifyPasswordModal">
                    <i class="glyphicon glyphicon-cog"></i>修改密码
                </a>
            </li>
            <li>
                <a href="#" onclick="logOut()">
                    <i class="glyphicon glyphicon-off"></i> 退出
                </a>
            </li>
        </ul>
    </li>
</script>
<script id="login" type="text/html">
    <li>
        <a href="#" data-toggle="modal" data-target="#loginModal">登陆</a>
    </li>
    <li>
        <a href="#" data-toggle="modal" data-target="#registModal">注册</a>
    </li>
</script>
<script type="text/javascript">
    //根据用户名密码登录
    function loginByLoginName(){

        $('#frmLoginByName').data('bootstrapValidator').validate();//启用验证
        let falg = $('#frmLoginByName').data('bootstrapValidator').isValid(); //验证是否通过
        if(falg){
            $.post(
                '${pageContext.request.contextPath}/front/customer/loginByLoginName',
                $('#frmLoginByName').serialize(),
                function (result ) {
                    if(result.status == 1){
                        //刷新页面
                        // location.href='${pageContext.request.contextPath}/front/product/search';

                        //局部刷新
                        $('#loginModal').modal('hide'); //隐藏模态框
                        $('#loginName').val("");
                        $('#password').val("");
                        let content = template('welcome',result.data);  //获取模板
                        $('#navbarInfo').html(content); //加载模板
                    }else{
                        $('#loginInfo').html(result.message);
                    }
                }
            );
        }
    }
    
    function logOut() {
        $.post(
            '${pageContext.request.contextPath}/front/customer/logout',
            function (result) {
                if(result.status ==1){
                    //刷新页面
                    //location.href='${pageContext.request.contextPath}/front/product/search';

                    //局部刷新
                    let content = template('login');
                    $('#navbarInfo').html(content);
                }
            }
        );
    }

    //初始化bootstrapValidator
    $(function () {
        //创建登录信息表单验证
        $('#frmLoginByName').bootstrapValidator({
            feedbackIcons:{ //根据验证结果显示的各种图案
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields:{
                loginName:{
                    validators:{
                        notEmpty:{
                            message:'用户名不能为空'
                        }
                    }
                },
                password:{
                    validators: {
                        notEmpty: {
                            message:'密码不能为空'
                        }
                    }
                }
            }
        });

        $('#frmsms').bootstrapValidator({
            feedbackIcons:{ //根据验证结果显示的各种图案
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                phone: {
                    validators:{
                        notEmpty:{
                            message:'手机号不能为空'
                        }
                    }
                },
                smsValidCode:{
                    validators:{
                        notEmpty:{
                            message:'验证码不能为空'
                        },
                        stringLength:{
                            min:'6',
                            max:'6',
                            message:'请输入六位数长度的验证码'
                        }
                    }
                }
            }
        });
    })

    //发送短信验证码
    function sendValidCode(btn){
        $.post(
            '${pageContext.request.contextPath}/sms/sendValidCode',
            {'phone':$('#phone').val()},
            function (result) {
                if(result.status == 1){
                    let time=60;
                    //启动计时器，时间每秒递减
                    timer = setInterval(function () {
                        if(time > 0){
                            $(btn).attr('disabled',true);
                            $(btn).html('重新发送('+time+')');
                            time--;
                        }else{
                            $(btn).attr('disabled',false);
                            $(btn).html('重新发送');
                            clearInterval(time);  //停止计时器
                        }
                    },1000)
                }
            }
        );
    }

    //短信验证码登录
    function loginBySms(){
        $('#frmsms').data('bootstrapValidator').validate() //启用验证
        let falg = $('#frmsms').data('bootstrapValidator').isValid(); //验证是否通过
        if(falg){
            $.post(
                '${pageContext.request.contextPath}/front/customer/loginBySms',
                $('#frmsms').serialize(),
                function (result) {
                    if(result.status == 1){
                        //局部刷新
                        $('#loginModal').modal('hide');//隐藏模态框
                        $('#phone').val("");
                        $('#smsValidCode').val("");
                        let content = template('welcome',result.data);  //获取模板
                        $('#navbarInfo').html(content); //加载模板
                    }else {
                        $('#loginSms').html(result.message);
                    }
                }
            );
        }
    }
</script>
<!-- navbar start -->
<div class="navbar navbar-default clear-bottom">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand logo-style" href="http://edu.51cto.com/center/lec/info/index?user_id=12392007">
                <img class="brand-img" src="${pageContext.request.contextPath}/images/com-logo1.png" alt="logo" height="70">
            </a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active">
                    <a href="#">商城主页</a>
                </li>
                <li>
                    <a href="myOrders.jsp">我的订单</a>
                </li>
                <li>
                    <a href="cart.jsp">购物车</a>
                </li>
                <li class="dropdown">
                    <a href="center.jsp">会员中心</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right" id="navbarInfo">
                <c:choose>
                    <c:when test="${empty customer}">
                        <li>
                            <a href="#" data-toggle="modal" data-target="#loginModal">登陆</a>
                        </li>
                        <li>
                            <a href="#" data-toggle="modal" data-target="#registModal">注册</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="userName">
                            欢迎您：${sessionScope.get("customer").name}
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle user-active" data-toggle="dropdown" role="button">
                                <img class="img-circle" src="${pageContext.request.contextPath}/images/user.jpeg" height="30" />
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#" data-toggle="modal" data-target="#modifyPasswordModal">
                                        <i class="glyphicon glyphicon-cog"></i>修改密码
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onclick="logOut()">
                                        <i class="glyphicon glyphicon-off"></i> 退出
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</div>
<!-- navbar end -->

<!-- 修改密码模态框 start -->
<div class="modal fade" id="modifyPasswordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModa  lLabel">修改密码</h4>
            </div>
            <form action="" class="form-horizontal" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">原密码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">新密码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">重复密码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                    <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                    <button type="submit" class="btn btn-warning">修&nbsp;&nbsp;改</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 修改密码模态框 end -->

<!-- 登录模态框 start  -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <!-- 用户名密码登陆 start -->
        <div class="modal-content" id="login-account">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户名密码登录 &nbsp;&nbsp;&nbsp;<small id="loginInfo" class="text-danger"></small></h4>
            </div>
            <form class="form-horizontal" method="post" id="frmLoginByName">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户名：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" id="loginName" placeholder="请输入用户名" name="loginName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password" id="password" placeholder="请输入密码" name="password">
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="text-align: center">
                    <a class="btn-link">忘记密码？</a> &nbsp;
                    <button type="button" class="btn btn-warning" onclick="loginByLoginName()">登&nbsp;&nbsp;陆</button> &nbsp;&nbsp;
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                    <a class="btn-link" id="btn-sms-back">短信快捷登录</a>
                </div>
            </form>
        </div>
        <!-- 用户名密码登陆 end -->
        <!-- 短信快捷登陆 start -->
        <div class="modal-content" id="login-sms" style="display: none;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">短信快捷登陆 &nbsp;&nbsp;&nbsp;<small id="loginSms" class="text-danger"></small></h4>
            </div>
            <form class="form-horizontal" method="post" id="frmsms">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">手机号：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" id="phone" name="phone" placeholder="请输入手机号">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">验证码：</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="smsValidCode" id="smsValidCode" placeholder="请输入验证码">
                        </div>
                        <div class="col-sm-2">
                            <button class="pass-item-timer" type="button" onclick="sendValidCode(this)">发送验证码</button>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="text-align: center">
                    <a class="btn-link">忘记密码？</a> &nbsp;
                    <button type="button" class="btn btn-warning" onclick="loginBySms()">登&nbsp;&nbsp;陆</button> &nbsp;&nbsp;
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                    <a class="btn-link" id="btn-account-back">用户名密码登录</a>
                </div>
            </form>
        </div>
        <!-- 短信快捷登陆 end -->
    </div>
</div>
<!-- 登录模态框 end  -->

<!-- 注册模态框 start -->
<div class="modal fade" id="registModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">会员注册</h4>
            </div>
            <form action="" class="form-horizontal" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户姓名:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">登陆账号:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">登录密码:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">联系电话:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">联系地址:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                    <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                    <button type="submit" class="btn btn-warning">注&nbsp;&nbsp;册</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 注册模态框 end -->