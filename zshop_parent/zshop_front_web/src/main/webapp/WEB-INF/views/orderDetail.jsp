<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>订单详情</title>
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
                    <h3>我的订单</h3>
                </div>
            </div>
        </div>
        <div class="row head-msg">
            <div class="col-md-12">
                用户:<b><span>user</span></b>
            </div>
            <div class="col-md-12">
                订单: <b><span>123456</span></b>
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
                <td> <img src="images/hotaddress1.jpeg" alt="" width="60" height="60"></td>
                <td>2</td>
                <td>20</td>
            </tr>
            <tr>
                <td>1</td>
                <td>aaa</td>
                <td> <img src="images/hotaddress1.jpeg" alt="" width="60" height="60"></td>
                <td>2</td>
                <td>20</td>
            </tr>
            <tr>
                <td>1</td>
                <td>aaa</td>
                <td> <img src="images/hotaddress1.jpeg" alt="" width="60" height="60"></td>
                <td>2</td>
                <td>20</td>
            </tr>
            <tr>
                <td colspan="5" class="foot-msg">
                    共<b><span>10</span></b>条&nbsp; &nbsp; 总计
                    <b><span>1000</span></b>元
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