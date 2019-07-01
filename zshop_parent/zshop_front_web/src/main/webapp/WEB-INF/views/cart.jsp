<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>我的购物车</title>
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/style.css" />
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.js"></script>
</head>

<body>
    <div class="navbar navbar-default clear-bottom">
        <div class="container">
            <!-- logo start -->
            <div class="navbar-header">
                <a class="navbar-brand logo-style" href="http://edu.51cto.com/center/lec/info/index?user_id=12392007">
                        <img class="brand-img" src="images/com-logo1.png" alt="logo" height="70">
                    </a>
            </div>
            <!-- logo end -->
            <!-- navbar start -->
            <jsp:include page="top.jsp"/>
            <!-- navbar end -->
        </div>
    </div>
    <!-- content start -->
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <div class="page-header" style="margin-bottom: 0px;">
                    <h3>我的购物车</h3>
                </div>
            </div>
        </div>
        <table class="table table-hover table-striped table-bordered">
            <tr>
                <th>
                    <input type="checkbox" id="all">
                </th>
                <th>序号</th>
                <th>商品名称</th>
                <th>商品图片</th>
                <th>商品数量</th>
                <th>商品总价</th>
                <th>操作</th>
            </tr>
            <tr>
                <td>
                    <input type="checkbox">
                </td>
                <td>1</td>
                <td>奶茶</td>
                <td> <img src="images/hotaddress1.jpeg" alt="" width="60" height="60"></td>
                <td>
                    <input type="text" value="2" size="5">
                </td>
                <td>20</td>
                <td>
                    <button class="btn btn-success" type="button"> <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>修改</button>
                    <button class="btn btn-danger" type="button" onclick="javaScript:return confirm('是否确认删除');">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                    </button>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="checkbox">
                </td>
                <td>1</td>
                <td>奶茶</td>
                <td> <img src="images/hotaddress1.jpeg" alt="" width="60" height="60"></td>
                <td>
                    <input type="text" value="2" size="5">
                </td>
                <td>20</td>
                <td>
                    <button class="btn btn-success" type="button"> <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>修改</button>
                    <button class="btn btn-danger" type="button" onclick="javaScript:return confirm('是否确认删除');">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                    </button>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="checkbox">
                </td>
                <td>1</td>
                <td>奶茶</td>
                <td> <img src="images/hotaddress1.jpeg" alt="" width="60" height="60"></td>
                <td>
                    <input type="text" value="2" size="5">
                </td>
                <td>20</td>
                <td>
                    <button class="btn btn-success" type="button"> <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>修改</button>
                    <button class="btn btn-danger" type="button" onclick="javaScript:return confirm('是否确认删除');">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                    </button>
                </td>
            </tr>
            <tr>
                <td colspan="7" align="right">
                    <button class="btn btn-warning margin-right-15" type="button"> 删除选中项</button>
                    <button class="btn btn-warning  margin-right-15" type="button"> 清空购物车</button>
                    <button class="btn btn-warning margin-right-15" type="button"> 继续购物</button>
                    <a href="order.jsp">
                        <button class="btn btn-warning " type="button"> 结算</button>
                    </a>
                </td>
            </tr>
            <tr>
                <td colspan="7" align="right" class="foot-msg">
                    总计： <b><span>1000</span> </b>元
                </td>
            </tr>
        </table>
    </div>
    <!-- content end-->
    <!-- footers start -->
    <div class="footers">
        版权所有：南京网博
    </div>
    <!-- footers end -->
</body>

</html>