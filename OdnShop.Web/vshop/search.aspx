﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="OdnShop.Web.vshop.search" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>商品搜索-<%= shopconfig.ShopName %></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="images/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="images/font-awesome.min.css" rel="stylesheet" type="text/css" media="all" />
<link href="images/flexslider.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="images/jquery.min.js"></script>
<script type="text/javascript" src="images/jquery-ui.min.js"></script>
<script type="text/javascript" src="images/switchable.js"></script>
</head>
<body>

<header class="topheader">
<div class="headerleft"><a href="javascript:history.go(-1)"><span>返回</span></a></div>
<div class="headercenter">
<h2>商品搜索</h2>
</div>
<div class="headeright"><a href="index.aspx"><span>首页</span></a></div>
</header>

<!-- 搜索开始 -->
<div class="mainsearch">
<form action="search.aspx" method="get" name="searchForm">
<input  class="searchinput" name="kw" id="keywordBox" type="search" value="<%= SearchKw %>" placeholder="请输入搜索关键词">
<button class="searchbutton" type="submit" value="搜索"></button>
</form>
</div>
<!-- 搜索结束 -->

<main class="mains">
<h2><span>猜您喜欢<!-- 或搜索结果 --></span></h2>
</main>
<div class="prolist" id="gallery-wrapper">
<ul>
<asp:Repeater runat="server" ID="rptProducts">
      <ItemTemplate>
<li class="item">
<a href="productshow.aspx?id=<%# Eval("productid")%>"><img src="<%# Eval("includepicpath")%>" alt="item" /></a>
<h4><a href="productshow.aspx?id=<%# Eval("productid")%>"><%# Eval("productname")%></a></h4>
<span>&yen;<%# Eval("price")%></span><del style="display:none">&yen;500</del>
<p class="add-to-cart" onClick="toshare(<%# Eval("productid")%>)"><span>添加到购物车</span></p>
</li>
    </ItemTemplate>
     </asp:Repeater>
</ul>
<div class="mores"><a href="productlist.aspx">更多产品</a></div>
</div>

<!-- 弹出购物车s -->
<script type="text/javascript">
    function toshare(pid) {
        $("#showproduct" + pid).addClass("am-modal-active");
        //$(".am-share").addClass("am-modal-active");
        if ($(".sharebg").length > 0) {
            $(".sharebg").addClass("sharebg-active");
        } else {
            $("body").append('<div class="sharebg"></div>');
            $(".sharebg").addClass("sharebg-active");
        }
        $(".sharebg-active,.share_btn").click(function () {
            $("#showproduct" + pid).removeClass("am-modal-active");
            //$(".am-share").removeClass("am-modal-active");
            setTimeout(function () {
                $(".sharebg-active").removeClass("sharebg-active");
                $(".sharebg").remove();
            }, 300);
        })
    }		
</script>
<asp:Repeater runat="server" ID="rptAddToCarPopWin">
      <ItemTemplate>
<div class="am-share" id="showproduct<%# Eval("productid")%>">
<dl>
<dt><img src="<%# Eval("includepicpath")%>" alt=""/></dt>
<dd>
<h4><%# Eval("productname")%></h4>
<span id="showprice<%# Eval("productid")%>">&yen;<%# Eval("price")%></span><del style="display:none">&yen;500</del> 
<p>库存：<%# Eval("productcount")%></p>
<!--规格属性-->
    <div class="iteminfo_buying" style="<%# Eval("itemprice").ToString() == "" ? "display:none" : "" %>">
        <div class="sys_item_spec">
            <dl class="iteminfo_parameter sys_item_specpara" data-sid="<%# Eval("productid")%>">
                <dt>属性<input type="hidden" id="itemvalue<%# Eval("productid")%>" /></dt>
                <dd>
                    <ul class="sys_spec_img">
                    <%# getitems(Eval("itemprice").ToString(),"showprice"+Eval("productid")) %>
                    </ul>
                </dd>
            </dl>
        </div>
    </div>
<!--规格属性-->
</dd>
</dl>

<div class="changegoodsnumber">
<h4>数量：</h4><p><span onClick="change_goods_number('1',<%# Eval("productid")%>)" >-</span><input type="hidden" id="back_number<%# Eval("productid")%>" value="1" /><input type="text" class="formnum"  name="<%# Eval("productid")%>" id="goods_number<%# Eval("productid")%>" autocomplete="off" value="1" onFocus="back_goods_number(<%# Eval("productid")%>)"  onblur="change_goods_number('2',<%# Eval("productid")%>)" /><span onClick="change_goods_number('3',<%# Eval("productid")%>)">+</span></p>
</div>

<ul class="gocartli">
<li><a href="javascript:void(0)" onclick="addtocart(<%# Eval("productid")%>);">加入购物车</a></li>
<li><a href="cart.aspx?action=add&pid=<%# Eval("productid")%>" id="gotobuy<%# Eval("productid")%>">立即购买</a></li>
</ul>

<button class="share_btn"><span>取消</span></button>
</div>
</ItemTemplate>
   </asp:Repeater>
<script>
function back_goods_number(id){
 var goods_number = document.getElementById('goods_number'+id).value;
  document.getElementById('back_number'+id).value = goods_number;
}
function change_goods_number(type, id)
{
  var goods_number = document.getElementById('goods_number'+id).value;
  if(type != 2){back_goods_number(id)}
  if(type == 1){goods_number--;}
  if(type == 3){goods_number++;}
  if(goods_number <=0 ){goods_number=1;}
  if(!/^[0-9]*$/.test(goods_number)){goods_number = document.getElementById('back_number'+id).value;}
  document.getElementById('goods_number'+id).value = goods_number;
	//$.post('/mobile/index.php?m=default&c=flow&a=ajax_update_cart', {
	//	rec_id : id,goods_number : goods_number
	//}, function(data) {
	//	change_goods_number_response(data,id);
	//}, 'json');  
} 
// 处理返回信息并显示
function change_goods_number_response(result,id)
{
	if (result.error == 0){
		var rec_id = result.rec_id;
		$("#goods_number_"+rec_id).val(result.goods_number);
		document.getElementById('total_number').innerHTML = result.total_number;//更新数量
		document.getElementById('goods_subtotal').innerHTML = result.total_desc;//更新小计
		if (document.getElementById('ECS_CARTINFO')){
			//更新购物车数量
			document.getElementById('ECS_CARTINFO').innerHTML = result.cart_info;
		}
	}else if (result.message != ''){
		alert(result.message);
		var goods_number = document.getElementById('back_number'+id).value;
 		document.getElementById('goods_number'+id).value = goods_number;
	}                
}

	/*点击下拉手风琴效果*/
	$('.collapse').collapse()
	$(".checkout-select a").click(function(){
		if(!$(this).hasClass("select")){
			$(this).addClass("select");
		}else{	
			$(this).removeClass("select");
		}
	});
	
</script>
<!-- 弹出购物车e -->

<!-- 底部菜单s -->
<footer class="footer">
<a href="productcategory.aspx"><i class="footer-category"></i>分类</a><!-- 如是当前页a里加id="active" -->
<a href="search.aspx" id="active"><i class="footer-search"></i>搜索</a>
<a href="index.aspx"><i class="footer-home"></i>首页</a>
<a href="cart.aspx"><i class="footer-cart"></i>购物车<span id="cartnum"><%= ShopCartNumber %></span></a> <!-- 如果购物车没数据就不显示<span>6</span> -->
<a href="user.aspx"><i class="footer-user"></i>我的</a>
</footer>
<!-- 底部菜单e -->
<!-- 返回顶部s -->
<script type="text/javascript" src="images/move-top.js"></script>
<script type="text/javascript" src="images/easing.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $().UItoTop({ easingType: 'easeOutQuart' });
        if (<%= ShopCartNumber %> == 0)
            $("#cartnum").hide();
    });

    function addtocart(id) {
        var itemflag = 0;
        //if ($(".sys_item_spec .sys_item_specpara").attr("data-attrval") != "undefined")
        //    itemflag = $(".sys_item_spec .sys_item_specpara").attr("data-attrval");

        if ($("#itemvalue" + id).val() != "")
            itemflag = $("#itemvalue" + id).val();

        var buycount = document.getElementById('goods_number' + id).value;
        $.post('cart_ajax.aspx?action=addtocart', {
            pid: id, buycount: buycount, itemflag: itemflag
        }, function (data) {
            $("#cartnum").html(data.shopcount);
        }, 'json');

        $("#cartnum").show();

        $("#showproduct" + id).removeClass("am-modal-active");
        //$(".am-share").removeClass("am-modal-active");
        setTimeout(function () {
            $(".sharebg-active").removeClass("sharebg-active");
            $(".sharebg").remove();
        }, 300);
    }
</script>
<script>
    //商品规格选择
    $(function () {
        $(".sys_item_spec .sys_item_specpara").each(function () {
            var i = $(this);
            var p = i.find("ul>li");
            p.click(function () {
                if (!!$(this).hasClass("selected")) {
                    $(this).removeClass("selected");
                    i.removeAttr("data-attrval");
                    $("#itemvalue" + i.attr("data-sid")).val(0);
                    $("#gotobuy" + i.attr("data-sid")).attr("href", "cart.aspx?action=add&pid=" + i.attr("data-sid") + "&buycount=" + $("#goods_number" + i.attr("data-sid")).val());
                } else {
                    $(this).addClass("selected").siblings("li").removeClass("selected");
                    i.attr("data-attrval", $(this).attr("data-aid"));
                    $("#itemvalue" + i.attr("data-sid")).val($(this).attr("data-aid"));
                    $("#gotobuy" + i.attr("data-sid")).attr("href", "cart.aspx?action=add&pid=" + i.attr("data-sid") + "&itemflag=" + $(this).attr("data-aid") + "&buycount=" + $("#goods_number" + i.attr("data-sid")).val());
                }
            })
        })
    })
</script>
<a href="#head" id="toTop" style="display: block;"> <span id="toTopHover" style="opacity:1;"> </span></a>
<!-- 返回顶部e -->
</body>
</html>
