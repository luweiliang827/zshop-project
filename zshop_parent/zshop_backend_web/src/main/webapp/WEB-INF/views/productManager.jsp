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
        $(function(){
            //上传图像预览
            $('#product-image').on('change',function() {
                $('#img').attr('src', window.URL.createObjectURL(this.files[0]));
            });        
            $('#pro-image').on('change',function() {
                $('#img2').attr('src', window.URL.createObjectURL(this.files[0]));
            });

            //服务器端提示消息
            let successMsg='${successMsg}';
            let errorMsg = '${errorMsg}';
            if(successMsg != ''){
                layer.msg(successMsg,{
                    time:1000,
                    skin:'successMsg' //消息提示样式
                })
            }
            if(errorMsg != ''){
                layer.msg(errorMsg,{
                    time:1000,
                    skin:'errorMsg'
                })
            }

            //使用bootstrap validator 插件进行客户端数据校验
            $('#formAddProduct').bootstrapValidator({
                feedbackIcons:{ //根据验证结果显示的各种图案
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields:{
                    name:{
                        validators:{
                            notEmpty:{
                                message:'商品名称不能为空'
                            },
                            remote:{
                                url:'${pageContext.request.contextPath}/backend/product/checkProductName',
                                //设置POST方式提交，可以处理页面传到后台的中文乱码问题
                                type:'POST'
                            },
                            stringLength:{
                                max:'20',
                                message:'商品名称长度必须少于20'
                            }
                        }
                    },
                    price:{
                        validators:{
                            notEmpty: {
                                message: '商品价格不能为空'
                            },
                            regexp:{
                                //价格只能整数或者小数
                                regexp: /^\d+(\.\d+)?$/,
                                message:'商品价格格式不对'
                            }
                        }
                    },
                    file:{
                        validators:{
                            notEmpty:{
                                message:'请选择一张商品图片'
                            }
                        }
                    },
                    productTypeId:{
                        validators:{
                            notEmpty:{
                                message:'请选择商品对应的类型'
                            }
                        }
                    },
                    info:{
                        validators:{
                            notEmpty:{
                                message:'请输入商品描述'
                            }
                        }
                    }
                }
            });

            //分页
            $('#pagination').bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:${pageInfo.pageNum},
                totalPages:${pageInfo.pages},
                itemTexts:function (type,page,current) {
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
                pageUrl:function (type,page,current) {
                    return '${pageContext.request.contextPath}/backend/product/findAll?pageNum='+page;
                }
            })
        });

        //显示商品信息
        function showProductById(id){
            $.post(
                '${pageContext.request.contextPath}/backend/product/findProductById',
                {'id':id},
                function(result){
                    if(result.status == 1){
                        $('#pro-num').val(result.data.id);
                        $('#pro-name').val(result.data.name);
                        $('#pro-price').val(result.data.price);
                        $('#pro-type').val(result.data.productType.id);
                        $('#img2').attr('src','${pageContext.request.contextPath}/backend/product/getImage?path='+result.data.image);
                        $('#pro-info').val(result.data.info);
                    }
                }
            );
        }

        //显示删除的对话框
        function showDeleteModel(id){
            $('#deleteProductId').val(id);
            $('#delProductModal').modal('show');
        }

        function removeProduct(){
            var id = $('#deleteProductId').val();
            $.post(
                '${pageContext.request.contextPath}/backend/product/removeProductById',
                {'id':id},
                function (result) {
                    if(result.status == 1){
                        layer.msg(result.message,{
                            time:1000,
                            skin:'successMsg'
                        },function () {
                            location.href='${pageContext.request.contextPath}/backend/product/findAll?pageNum='+${pageInfo.pageNum};
                        });
                    }else{
                        layer.msg(result.message,{
                            time:1000,
                            skin:'errorMsg'
                        })
                    }
                }
            );
        }
        
    </script>
</head>

<body>
    <div class="panel panel-default" id="userPic">
        <div class="panel-heading">
            <h3 class="panel-title">商品管理</h3>
        </div>
        <div class="panel-body">
            <input type="button" value="添加商品" class="btn btn-primary" id="doAddPro">
            <br>
            <br>
            <div class="show-list text-center">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">编号</th>
                            <th class="text-center">商品</th>
                            <th class="text-center">价格</th>
                            <th class="text-center">产品类型</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                        <c:forEach items="${pageInfo.list}" var="product">
                            <tr>
                                <td>${product.id}</td>
                                <td>${product.name}</td>
                                <td>${product.price}</td>
                                <td>${product.productType.name}</td>
                                <td>
                                    <c:if test="${product.productType.status == 1}">有效商品</c:if>
                                    <c:if test="${product.productType.status == 0}">无效商品</c:if>
                                </td>
                                <td class="text-center">
                                    <input type="button" class="btn btn-warning btn-sm doProModify" value="修改" onclick="showProductById(${product.id})">
                                    <input type="button" class="btn btn-warning btn-sm doProDelete" value="删除" onclick="showDeleteModel(${product.id})">
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <ul id="pagination"></ul>
            </div>
        </div>
    </div>

    <!-- 添加商品 start -->     
    <div class="modal fade" tabindex="-1" id="Product">
        <!-- 窗口声明 -->
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <form action="${pageContext.request.contextPath}/backend/product/addProduct" id="formAddProduct" class="form-horizontal" method="post" enctype="multipart/form-data">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加商品</h4>
                </div>
                <div class="modal-body text-center row">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}"/>
                    <div class="col-sm-8">
                        <div class="form-group">
                            <label for="product-name" class="col-sm-4 control-label">商品名称：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="product-name" name="name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-price" class="col-sm-4 control-label">商品价格：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="product-price" name="price">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-image" class="col-sm-4 control-label">商品图片：</label>
                            <div class="col-sm-8">
                                <a href="javascript:;" class="file">选择文件
                                    <input type="file" name="file" id="product-image">
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-type" class="col-sm-4 control-label">商品类型：</label>
                            <div class="col-sm-8">
                                <select class="form-control" name="productTypeId" id="product-type">
                                    <option value="">---请选择---</option>
                                    <c:forEach items="${productTypes}" var="productType">
                                        <option value="${productType.id}">${productType.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="product-info" class="col-sm-4 control-label">商品描述：</label>
                            <div class="col-sm-8">
                                <textarea rows="3" cols="20" maxlength="100" type="text" class="form-control" id="product-info" name="info">
                                </textarea><%--<span id="text-count" value="">0</span>/100--%>
                            </div>
                        </div>
                    </div>  
                    <div class="col-sm-4">
                        <!-- 显示图像预览 -->
                        <img style="width: 160px;height: 180px;" id="img">
                    </div>  
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="submit">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
            </form>
        </div>
    </div>
    <!-- 添加商品 end -->  
    
    <!-- 修改商品 start -->  
    <div class="modal fade" tabindex="-1" id="myProduct">
        <!-- 窗口声明 -->
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <form action="${pageContext.request.contextPath}/backend/product/modifyProduct" method="post" enctype="multipart/form-data" class="form-horizontal">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改商品</h4>
                </div>
                <div class="modal-body text-center row">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}"/>
                    <div class="col-sm-8">
                        <div class="form-group">
                            <label for="pro-num" class="col-sm-4 control-label">商品编号：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="pro-num" name="id" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-name" class="col-sm-4 control-label">商品名称：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="pro-name" name="name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-price" class="col-sm-4 control-label">商品价格：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="pro-price" name="price">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-image" class="col-sm-4 control-label">商品图片：</label>
                            <div class="col-sm-8">
                                <a class="file">
                                    选择文件 <input type="file" name="file" id="pro-image" name="file">
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-type" class="col-sm-4 control-label">商品类型：</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="pro-type" name="productTypeId">
                                    <option>---请选择---</option>
                                    <c:forEach items="${productTypes}" var="productType">
                                        <option value="${productType.id}">${productType.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pro-info" class="col-sm-4 control-label">商品描述：</label>
                            <div class="col-sm-8">
                                <textarea rows="3" cols="20" type="text" class="form-control" id="pro-info" name="info">
                                </textarea>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <!-- 显示图像预览 -->
                        <img style="width: 160px;height: 180px;" id="img2">
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary updatePro" type="submit">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
            </form>
        </div>
    </div>
    <!-- 修改商品 end -->
    
    <!-- 确认删除商品类型 start -->
    <div class="modal fade" tabindex="-1" id="delProductModal">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">提示消息</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-center">
                        <h4>确认要删除该商品类型吗？</h4>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" id="deleteProductId"/>
                    <button class="btn btn-warning updateProType" onclick="removeProduct()" data-dismiss="modal">删除</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 确认删除商品类型 end -->
</body>

</html>