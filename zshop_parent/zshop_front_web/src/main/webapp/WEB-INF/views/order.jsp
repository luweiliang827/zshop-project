<%@page contentType="text/html; charset=utf-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>确认订单</title>
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
                <th>序号</th>
                <th>商品名称</th>
                <th>商品图片</th>
                <th>商品数量</th>
                <th>商品总价</th>
            </tr>
            <tr>
                <td>1</td>
                <td>aaa</td>
                <td><img src="images/hotaddress1.jpeg" alt="" width="60" height="60"></td>
                <td>2</td>
                <td>20</td>
            </tr>
            <tr>
                <td>1</td>
                <td>aaa</td>
                <td><img src="images/hotaddress1.jpeg" alt="" width="60" height="60"></td>
                <td>2</td>
                <td>20</td>
            </tr>
            <tr>
                <td>1</td>
                <td>aaa</td>
                <td><img src="images/hotaddress1.jpeg" alt="" width="60" height="60"></td>
                <td>2</td>
                <td>20</td>
            </tr>
            <tr>
                <td colspan="5" class="foot-msg">
                    总计：<b> <span>1000</span></b>元
                    <a href="cart.jsp">
                        <button class="btn btn-warning pull-right ">返回</button>
                    </a>
                    <button class="btn btn-warning pull-right margin-right-15" data-toggle="modal" data-target="#buildOrder">生成订单</button>
                </td>
            </tr>
        </table>
    </div>
    <!-- content end-->
    <div class="modal fade" id="buildOrder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">提示消息</h4>
                </div>
                <div class="orderMsg">
                    <p>
                        订单生成成功！！
                    </p>
                    <p>
                        订单号：<span>12345679</span>
                    </p>
                </div>
            </div>
        </div>
    </div>
    <!-- footers start -->
    <div class="footers">
        版权所有：南京网博
    </div>
</body>

</html>