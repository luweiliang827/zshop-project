<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
           $('#pagination').bootstrapPaginator({
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
                   $('#formSearch').submit();
               }
           })

        });

        //添加系统用户
        function addSysUser(){
            $.post(
                '${pageContext.request.contextPath}/backend/sysuser/addSysUser',
                //获取form表单中的数据
                $('#formAddUser').serialize(),
                function (result) {
                    if(result.status == 1){
                        layer.msg(result.message,{
                            time:1000,
                            skin:'successMsg'
                        },function () {
                            location.href='${pageContext.request.contextPath}/backend/sysuser/findAll?pageNum='+${pageInfo.pageNum};
                        })
                    }
                }
            );
        }

        //显示修改信息
        function showSysUser(id){
            $.post(
                '${pageContext.request.contextPath}/backend/sysuser/findSysUserById',
                {'id':id},
                function (result) {
                    if(result.status == 1){
                        $('#MargerStaffId').val(result.data.id);
                        $('#MargerStaffname').val(result.data.name);
                        $('#MargerLoginName').val(result.data.login_name);
                        $('#MargerPhone').val(result.data.phone);
                        $('#MargerAdrees').val(result.data.email);
                        $('#MargerRole').val(result.data.role.id);
                    }
                }
            );
        }

        //修改用户信息
        function modifySysUser(){
            $.post(
                '${pageContext.request.contextPath}/backend/sysuser/modifySysUser',
                $('#formModify').serialize(),
                function (result) {
                    if(result.status == 1){
                        layer.msg("修改成功",{
                            time:1000,
                            skin:'successMsg'
                        },function () {
                            location.href='${pageContext.request.contextPath}/backend/sysuser/findAll?pageNum='+${pageInfo.pageNum};
                        })
                    }
                }
            );
        }

        //修改状态
        function modifyStatus(id,btn){
            $.post(
                '${pageContext.request.contextPath}/backend/sysuser/modifyStatus',
                {'id':id},
                function (result) {
                    if(result.status == 1){
                        let $td = $(btn).parent().parent().children().eq(5);
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
    <!-- 系统用户管理 -->
    <div class="panel panel-default" id="adminSet">
        <div class="panel-heading">
            <h3 class="panel-title">系统用户管理</h3>
        </div>
        <div class="panel-body">
            <div class="showmargersearch">
                <form class="form-inline" id="formSearch" action="${pageContext.request.contextPath}/backend/sysuser/findSysUserByParams" method="post">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}" id="pageNum"/>
				  <div class="form-group">
				    <label for="userName">姓名:</label>
				    <input type="text" class="form-control" id="userName" name="name" placeholder="请输入姓名" value="${sysUserParam.name}">
				  </div>
				  <div class="form-group">
				    <label for="loginName">帐号:</label>
				    <input type="text" class="form-control" id="loginName" name="loginName" placeholder="请输入帐号" value="${sysUserParam.loginName}">
				  </div>
				  <div class="form-group">
				    <label for="phone">电话:</label>
				    <input type="text" class="form-control" id="phone" name="phone" placeholder="请输入电话" value="${sysUserParam.phone}">
				  </div>
				  <div class="form-group">
				    <label for="role">角色</label>
	                    <select class="form-control" name="roleId" id="role">
	                        <option value="-1">全部</option>
	                        <c:forEach items="${roles}" var="role">
                                <option value="${role.id}" <c:if test="${role.id == sysUserParam.roleId}">selected</c:if>>${role.roleName}</option>
                            </c:forEach>
	                    </select>
				  </div>
				  <div class="form-group">
				    <label for="status">状态</label>
	                    <select class="form-control" name="isValid" id="status">
	                        <option value="-1">全部</option>
	                        <option value="1" <c:if test="${sysUserParam.isValid == 1}">selected</c:if>>---有效---</option>
	                        <option value="0" <c:if test="${sysUserParam.isValid == 0}">selected</c:if>>---无效---</option>
	                    </select>
				  </div>
				  <input type="submit" value="查询" class="btn btn-primary" id="doSearch">
				</form>
            </div>
            <br>
            <input type="button" value="添加系统用户" class="btn btn-primary" id="doAddManger">
            <div class="show-list text-center" style="position: relative; top: 10px;">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">序号</th>
                            <th class="text-center">姓名</th>
                            <th class="text-center">帐号</th>
                            <th class="text-center">电话</th>
                            <th class="text-center">邮箱</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">注册时间</th>
                            <th class="text-center">角色</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                        <c:forEach items="${pageInfo.list}" var="sysUser">
                            <tr>
                                <td>${sysUser.id}</td>
                                <td>${sysUser.name}</td>
                                <td>${sysUser.login_name}</td>
                                <td>${sysUser.phone}</td>
                                <td>${sysUser.email}</td>
                                <td>
                                    <c:if test="${sysUser.isvalid == 1}">有效</c:if>
                                    <c:if test="${sysUser.isvalid == 0}">无效</c:if>
                                </td>
                                <td>
                                    <fmt:formatDate value="${sysUser.createDate}" type="both"/>
                                </td>
                                <td>${sysUser.role.roleName}</td>
                                <td class="text-center">
                                    <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改" onclick="showSysUser(${sysUser.id})">
                                    <c:if test="${sysUser.isvalid == 1}">
                                        <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用" onclick="modifyStatus(${sysUser.id},this)">
                                    </c:if>
                                    <c:if test="${sysUser.isvalid == 0}">
                                        <input type="button" class="btn btn-success btn-sm doMangerDisable" value="启用" onclick="modifyStatus(${sysUser.id},this)">
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!--显示分页-->
                <ul id="pagination"></ul>
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
                    <h4 class="modal-title">添加系统用户</h4>
                </div>
                <form id="formAddUser">
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
                            <label for="marger-loginName" class="col-sm-4 control-label">登录帐号：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-loginName" name="login_name">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="marger-password" class="col-sm-4 control-label">登录密码：</label>
                            <div class="col-sm-4">
                                <input type="password" class="form-control" id="marger-password" name="password">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="marger-phone" class="col-sm-4 control-label">联系电话：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-phone" name="phone">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="marger-adrees" class="col-sm-4 control-label">联系邮箱：</label>
                            <div class="col-sm-4">
                                <input type="email" class="form-control" id="marger-adrees" name="email"/>
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="role" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                            <div class=" col-sm-4">
                                <select class="form-control" id="roleId" name="roleId">
                                    <option>---请选择---</option>
                                    <c:forEach items="${roles}" var="userrole">
                                        <option value="${userrole.id}">${userrole.roleName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <br>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary add-Manger" type="button" onclick="addSysUser()">添加</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal" type="button">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- 添加系统用户 end -->

    <!-- 修改系统用户 start -->
    <div class="modal fade" tabindex="-1" id="myModal-Manger">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">系统用户修改</h4>
                </div>
                <form id="formModify">
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <label for="MargerUsername" class="col-sm-4 control-label">用户编号：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="MargerStaffId" name="id" readonly="readonly"/>
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="MargerUsername" class="col-sm-4 control-label">用户姓名：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="MargerStaffname" name="name"/>
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="MargerLoginName" class="col-sm-4 control-label">登录帐号：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="MargerLoginName" name="login_name" readonly="readonly">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="MargerPhone" class="col-sm-4 control-label">联系电话：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="MargerPhone" name="phone">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="MargerAdrees" class="col-sm-4 control-label">联系邮箱：</label>
                            <div class="col-sm-4">
                                <input type="email" class="form-control" id="MargerAdrees" name="email">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="MargerRole" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                            <div class=" col-sm-4">
                                <select class="form-control" id="MargerRole" name="roleId">
                                    <option>---请选择---</option>
                                    <c:forEach items="${roles}" var="role">
                                        <option value="${role.id}">${role.roleName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <br>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary doMargerModal" type="button" onclick="modifySysUser()">修改</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- 修改系统用户 end -->

</body>

</html>