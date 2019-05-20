<%@ page import="java.sql.*" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.String" %><%--
  Created by IntelliJ IDEA.
  User: kermi
  Date: 2018/9/5
  Time: 09:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<head>
    <meta charset="UTF-8">
    <title>登录/注册</title>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-3.3.1.min.js"></script>
    <script>
        var a_idx = 0;
        jQuery(document).ready(function($) {
            //		鼠标点击特效----start
            $("body").click(function(e) {
                var a = ["天真","富强", "民主", "文明", "和谐", "自由", "平等", "公正" ,"法治", "爱国", "敬业", "诚信", "友善"];
                var $i = $("<span/>").text(a[a_idx]);
                a_idx = (a_idx + 1) % a.length;
                var x = e.pageX,
                    y = e.pageY;
                $i.css({
                    "z-index": 6666666,
                    "top": y - 20,
                    "left": x,
                    "position": "absolute",
                    "font-weight": "bold",
                    "color": "#ff6651"
                });
                $("body").append($i);
                $i.animate({
                        "top": y - 200,
                        "opacity": 0
                    },
                    1500,
                    function() {
                        $i.remove();
                    });
            });
        })
    </script>
    <script>
        jQuery(document).ready(function ($) {
            $("#sign_panel").hide();
            $("#switch-login").click(function (e) {
                $("#sign_panel").slideUp(250);
                $("#login_panel").slideDown(250);
            });
            $("#switch-signup").click(function (e) {
                $("#login_panel").slideUp(250);
                $("#sign_panel").slideDown(250);
            })
        })
    </script>
    <script type="text/javascript">
        function checkEmail() {
            var getEmail = document.getElementById("user-account");
            var email = getEmail.value;
            var regex = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
            if(email === "") {
                alert("邮箱不能为空！");
                return false;
            }else if(! regex.test(email)) {
                alert("请输入正确的Email邮箱!");
                return false;
            }
            return true;
        }
    </script>
    <style type="text/css">
        *{
            cursor:url(res/鼠标指针/3d-blue.cur),default;
        }
        a{
            text-decoration: none;
        }
        body{
            position: relative;
            /*background: #e6e6e6;*/
            background: #e5fbfb;
            /*text-align: center;*/
        }
        input{
            outline: none;
        }
        .form-card{
            margin: auto;
            background: white;
            position: relative;
            display: block;
            /*border-radius: 8px;*/
            float: top;
        }
        .card-white{
            /*box-shadow: 0 1px 8px rgba(0,0,0,.13);*/
            /*-webkit-box-shadow: 0 2px 2px 0 rgba(0,0,0,0.14),*/
            /*0 3px 1px -2px rgba(0,0,0,0.12),*/
            /*0 1px 5px 0 rgba(0,0,0,0.2);*/
            box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16), 0 2px 10px 0 rgba(0,0,0,0.12);
        }
        .login{
            height: inherit;
            padding: 2% 0 0;
            margin: auto;
        }
        .login h1 img{
            position: relative;
            display: block;
            width: 150px;
            margin: auto;
        }
        #login-form{
            width: 16rem;
            height: 18rem;
            padding: 10px 26px 10px;
        }
        #signup-form{
            width: 16rem;
            height: 21rem;
            padding: 10px 26px 30px;
        }
        #login-form p label{
            display: block;
            width: 100%;
            font-size: 16px;
            text-align: left;
            margin: 0;
        }
        .input label input{
            font-size: 1rem;
            width: 100%;
            height: 1.8rem;
            /*padding: 4px;*/
            margin-top: 0.1rem;
            /*vertical-align: middle;*/
            background: rgba(250, 249, 246, 0.8);
            border-radius: 4px;
            border: 2px solid rgba(221, 221, 221, 0.76);
            box-shadow: inset 0 2px 4px rgba(221, 221, 221, 0.76);
        }
        .input label input:hover{
            border: 2px solid rgba(221, 135, 92, 0.51);
            box-shadow: inset 0 2px 4px rgba(0,0,0,.07);
        }
        .input{
            color: rgba(0, 0, 0, 0.51);
        }
        .listen{
            text-align: left;
            font-size: 13px;
            color: rgba(0, 0, 0, 0.7);
        }
        .check{
            position: absolute;
            /*text-align: left;*/
        }
        .check label{
            /*text-align: left;*/
        }
        #rememberme{
            width: auto;
            height: auto;
            margin: 0;
            /*text-align: center;*/
        }
        .submit{
            margin: 0;
            padding: 0;
        }
        .enter-button{
            /*position: static;*/
            width: auto;
            height: auto;
            float: right;
            margin-top: 30px;
            font-size: 15px;
            font-weight: bold;
            text-align: center;
            padding: 9px 12px;
            color: #f5f4f1;
            background: rgba(0, 100, 145, 0.5);
            background: -webkit-gradient(
                    linear, left top, left bottom,
                    from(rgba(0, 100, 145, 0.5)),
                    color-stop(0.50, rgba(0, 100, 145, 0.5)),
                    to(rgba(0, 100, 145, 0.5)));
            transition: .3s;
            border: none;
            border-radius: 30px;
            box-shadow: 0 2px 3px rgba(0,0,0,.13);
            -webkit-box-shadow: 0 2px 3px rgba(0,0,0,.13);
            -moz-box-shadow: 0 2px 3px rgba(0,0,0,.13);
            -o-box-shadow: 0 2px 3px rgba(0,0,0,.13);
        }
        .enter-button:hover{
            margin-top: 28px;
            background: -webkit-gradient(
                    linear, left top, left bottom,
                    from(rgba(121, 173, 175, 0.8)),
                    color-stop(0.50, rgba(136, 162, 175, 0.8)),
                    to(rgba(137, 149, 175, 0.8)));
        }
        .enter-button:active{
            background: -webkit-gradient(
                    linear, left top, left bottom,
                    from(rgba(122, 175, 161, 0.8)),
                    color-stop(0.50, rgba(133, 175, 169, 0.8)),
                    to(rgba(130, 173, 175, 0.8)));
        }
        .bottom-text{
            width: 18rem;
            display: block;
            position: relative;
            margin: auto;
            padding: 10px 0 10px 0;
            height: auto;
        }
        .bottom-text a{
            color: rgb(0, 100, 145);
            line-height: 20px;
        }
        .left{
            text-align: left;
        }
        .right{
            text-align: right;
        }
    </style>
</head>
<body>
<div class="login">
    <h1>
        <img src="res/qing-cloud.png"/>
    </h1>
    <div id="login_panel">
        <form id="login-form" class="card-white form-card" action="login" method="post" autocomplete="on"  >
            <p class="input">
                <label>
                    用户名(ID)<br/>
                    <input type="text" id="userName_login" name="userName" required />
                </label>
            </p>
            <p class="input">
                <label>
                    密码<br/>
                    <input type="password" name="pass" required>
                </label>
            </p>
            <p class="listen">
                Login form protected.
            </p>
            <p class="check">
                <label>
                    <input name="rememberme" type="checkbox"  value="forever">
                    同意xxx协议
                </label>
            </p>
            <p class="submit">
                <label>
                    <input type="submit" id="login-button" class="enter-button" value="登入" name="enter">
                </label>
            </p>
        </form>
        <div class="bottom-text right">
            <a id="switch-signup" href="#">Sign up ></a>
        </div>

    </div>
    <div id="sign_panel">
        <form id="signup-form" class="card-white form-card" action="signup" method="post" autocomplete="on"  >
            <p class="input">
                <label>
                    用户名(ID)<br/>
                    <input type="text" id="userName_signup" name="userName" required />
                </label>
            </p>
            <p class="input">
                <label>
                    密码<br/>
                    <input type="password" name="pass" required>
                </label>
            </p>
            <p class="input">
                <label>
                    确认密码<br/>
                    <input type="password" name="passAg" required>
                </label>
            </p>
            <p class="listen">
                Login form protected.
            </p>
            <p class="check">
                <label>
                    <input name="rememberme" type="checkbox"  value="forever">
                    同意xxx协议
                </label>
            </p>
            <p class="submit">
                <label>
                    <input type="submit"  id="signup-button" class="enter-button" value="确认注册" name="enter">
                </label>
            </p>
        </form>
        <div class="bottom-text left">
            <a id="switch-login" href="#">< Login </a>
        </div>
    </div>
</div>
</body>
</html>