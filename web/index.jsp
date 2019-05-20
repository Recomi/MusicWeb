<%@ page import="java.io.IOException" %><%--
  Created by IntelliJ IDEA.
  User: kermi
  Date: 2018/12/19
  Time: 17:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>轻云音乐</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <script type="text/javascript" src="js/index.js"></script>
    <link rel="stylesheet" href="css/foot.css" />
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <style type="text/css">
        .loop{
            display: flex;
            flex-flow: row;
        }
        #demo{
            flex: 4;
        }
        #account{
            flex: 1;
            position: relative;
            background-color: rgba(205, 205, 205, 0.6);
        }
        .rank-title-text{
            font-size: 1.5em;
            font-family: "Microsoft Sans Serif",monospace;
        }
        #rank-container a{
            color: whitesmoke;
        }
        .rank-artists{
            width: 100%;
            display: block;
        }
        .rank-div{
            padding: 1.5rem;
        }
        @media (max-width: 750px) {
            #account{
                display: none;
            }
            #rank-container{
                flex-flow: column;
            }
            .rank-div{
                width: 100%;
                display: flex;
                flex-flow: row;
                padding: 1rem 0;!important;
            }
            .rank-info{
                flex: 2;
            }
            .rank-info li{
                margin: auto;
                display: block;
            }
            .rank-songs{
                flex: 5;
            }
            .rank-artists{
                width: auto;
                display: unset;
            }
        }
        @media (max-width: 1000px) {
        }
        @media (min-width: 1200px) {
        }
    </style>
    <script>
        function show_slidebar() {
            jQuery(document).ready(function ($) {
                $("body").css(
                    "overflow","hidden",
                    // "overflow","visible",
                    "overflow-y","scroll"
                );
                $("#slidebar").css(
                    "left","0"
                );
                $("#slidebar-black").css(
                    "visibility","visible"
                ).animate({
                    opacity:1
                },200);
            });
        }
        function disable_slidebar() {
            jQuery(document).ready(function ($) {
                $("body").css(
                    "overflow-y","auto"
                );
                $("#slidebar").css(
                    "left","-100%"
                );
                $("#slidebar-black").css(
                    "visibility","hidden"
                ).animate({
                    opacity:0
                },200);
            });
        }
    </script>
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
</head>
<body>
<div id="slidebar" class="card-shadow">
    <nav class="navbar navbar-expand-md bg-light navbar-light" style="height: 56px">
        <a class="navbar-brand" href="#">轻云音乐</a>
        <svg onclick="disable_slidebar()" style="justify-content: flex-end;cursor: pointer" width="32px" height="32px" viewBox="-160 10 660 460" fill="#757575"><path fill="currentColor" d="M207.6 256l107.72-107.72c6.23-6.23 6.23-16.34 0-22.58l-25.03-25.03c-6.23-6.23-16.34-6.23-22.58 0L160 208.4 52.28 100.68c-6.23-6.23-16.34-6.23-22.58 0L4.68 125.7c-6.23 6.23-6.23 16.34 0 22.58L112.4 256 4.68 363.72c-6.23 6.23-6.23 16.34 0 22.58l25.03 25.03c6.23 6.23 16.34 6.23 22.58 0L160 303.6l107.72 107.72c6.23 6.23 16.34 6.23 22.58 0l25.03-25.03c6.23-6.23 6.23-16.34 0-22.58L207.6 256z" class=""></path></svg>
        <!--<svg onclick="disable_slidebar()" class="" style="justify-content: flex-end" width="36px" height="36px" viewBox="0 0 36 36" fill="#757575"><path d="M23.12 11.12L21 9l-9 9 9 9 2.12-2.12L16.24 18z"></path></svg>-->
    </nav>
    <div class="slide-content">
        <img class="user-icon slide-user-icon" src="img/user-none.jpg"/>
        <%
            String user_name = null;
            try {
                user_name = (String) request.getSession().getAttribute("userName");
            }catch (Exception e) {}
            if (user_name != null)
                writUser(out,user_name);
            else
                writUser(out,"");
        %>
        <%!
             void writUser(JspWriter out,String user_name) {
                 String str = "";
                 if (user_name.equals(""))
                     str = "<div class=\"user-name slide-user-name\">" + "未登录" + "</div>" +
                             "<a href=\"Login.jsp\" class=\"btn user-login slide-user-login\">登录/注册</a>";
                 else
                     str = "<div class=\"user-name slide-user-name\">" + user_name + "</div>" +
                             "<a href=\"Logout\" class=\"btn user-login slide-user-login\">退出登录</a>";
                 try {
                     out.write(str);
                 } catch (IOException e) {
                     e.printStackTrace();
                 }
             }
        %>

        <ul class="navbar-nav slide-ul">
            <li class="nav-item">
                <a class="nav-link" href="index.jsp">首页</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">我的音乐</a>
            </li>
            <!--<li class="nav-item">-->
            <!--<a class="nav-link" href="#">排行榜</a>-->
            <!--</li>-->
            <li class="nav-item">
                <a class="nav-link" href="app.html">客户端</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="https://github.com/recomi/MusicWeb">开源地址</a>
            </li>
        </ul>
    </div>
</div>
<div id="slidebar-black" onclick="disable_slidebar()"></div>

<nav class="navbar navbar-expand-md bg-light navbar-light">
    <div class="container">
        <div class="slidebar-toggler" onclick="show_slidebar()">
            <svg style="cursor: pointer" width="24px" height="24px" viewBox="0 0 48 48">
                <path d="M6 36h36v-4H6v4zm0-10h36v-4H6v4zm0-14v4h36v-4H6z"></path>
            </svg>
        </div>
        <a class="navbar-brand" href="#">轻云音乐</a>
        <div class="collapse navbar-collapse" id="collapsibleNavbar">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">我的音乐</a>
                </li>
                <!--<li class="nav-item">-->
                <!--<a class="nav-link" href="#">排行榜</a>-->
                <!--</li>-->
                <li class="nav-item">
                    <a class="nav-link" href="app.html">客户端</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="https://github.com/recomi/MusicWeb">开源地址</a>
                </li>
            </ul>
        </div>
        <div class="nav-search">
            <form action="search" method="get">
                <div class="input-group">
                    <input id="search-input" name="s_text" type="text" class="form-control bg-transparent" placeholder="搜索">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</nav>
<div class="container">
    <div class="d-flex flex-row nav-texts ">
        <div class="p-2 m-auto"><a class="text-black-50" href="#">推荐</a></div>
        <div class="p-2 m-auto"><a class="text-black-50" href="#">排行榜</a></div>
        <div class="p-2 m-auto"><a class="text-black-50" href="#">歌单</a></div>
        <div class="p-2 m-auto"><a class="text-black-50" href="#">主播电台</a></div>
        <div class="p-2 m-auto"><a class="text-black-50" href="#">歌手</a></div>
        <div class="p-2 m-auto"><a class="text-black-50" href="#">新歌上架</a></div>
    </div>
    <div class="loop">
        <div id="demo" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="img/img1.png">
                </div>
                <div class="carousel-item">
                    <img src="img/loop2.jpeg">
                </div>
                <div class="carousel-item">
                    <img src="img/loop4.jpeg">
                </div>
            </div>
            <a class="carousel-control-prev" href="#demo" data-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </a>
            <a class="carousel-control-next" href="#demo" data-slide="next">
                <span class="carousel-control-next-icon"></span>
            </a>
        </div>
        <div id="account">
            <img class="user-icon" src="img/user-none.jpg"/>
            <%
                if (user_name != null)
                    writUser_main(out,user_name);
                else
                    writUser_main(out,"");
            %>
            <%!
                void writUser_main(JspWriter out,String user_name) {
                    String str = "";
                    if (user_name.equals(""))
                        str = "<span class=\"user-name\">" + "未登录" + "</span>" +
                                "<a href=\"Login.jsp\" class=\"btn text-center user-login\">登录/注册</a>";
                    else
                        str = "<div class=\"user-name slide-user-name\">" + user_name + "</div>" +
                                "<a href=\"Logout\" class=\"btn text-center user-login\">退出登录</a>";
                    try {
                        out.write(str);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </div>

    <div class="d-flex justify-content-start mb-3 mt-3" id="rank-container">
        <div class="m-auto bg-shallow-blue rank-div">
            <div class="rank-info text-center">
                <li><span class="text-light rank-title-text">飙升榜</span></li>
                <li><a href="#">流行指数</a></li>
                <li><i>——</i></li>
            </div>
            <div class="rank-songs">
                <li><a href="#">1.短发(live) <span class="rank-artists">张靓颖</span></a></li>
                <li><a href="#">2.Faded (即刻电音版)<span class="rank-artists">Alan Walker</span></a></li>
                <li><a href="#">3.雪落下的声音 (Live)<span class="rank-artists">周深</span></a></li>
                <li><a href="#">4.Different <span class="rank-artists">WorldAlan Walker</span></a></li>
            </div>
        </div>

        <div class="m-auto bg-shallow-red rank-div">
            <div class="rank-info text-center">
                <li><span class="text-light rank-title-text">新歌榜</span></li>
                <li><a href="#">流行指数</a></li>
                <li><i>——</i></li>
            </div>
            <div class="rank-songs">
                <li><a href="#">1.短发(live) <span class="rank-artists">张靓颖</span></a></li>
                <li><a href="#">2.Faded (即刻电音版)<span class="rank-artists">Alan Walker</span></a></li>
                <li><a href="#">3.雪落下的声音 (Live)<span class="rank-artists">周深</span></a></li>
                <li><a href="#">4.Different <span class="rank-artists">WorldAlan Walker</span></a></li>
            </div>
        </div>

        <div class="m-auto bg-shallow-green rank-div">
            <div class="rank-info text-center">
                <li><span class="text-light rank-title-text">原创榜</span></li>
                <li><a href="#">流行指数</a></li>
                <li><i>——</i></li>
            </div>
            <div class="rank-songs">
                <li><a href="#">1.短发(live) <span class="rank-artists">张靓颖</span></a></li>
                <li><a href="#">2.Faded (即刻电音版)<span class="rank-artists">Alan Walker</span></a></li>
                <li><a href="#">3.雪落下的声音 (Live)<span class="rank-artists">周深</span></a></li>
                <li><a href="#">4.Different <span class="rank-artists">WorldAlan Walker</span></a></li>
            </div>
        </div>
        <div class="m-auto bg-shallow-yellow rank-div">
            <div class="rank-info text-center">
                <li><span class="text-light rank-title-text">热歌榜</span></li>
                <li><a href="#">流行指数</a></li>
                <li><i>——</i></li>
            </div>
            <div class="rank-songs">
                <li><a href="#">1.短发(live) <span class="rank-artists">张靓颖</span></a></li>
                <li><a href="#">2.Faded (即刻电音版)<span class="rank-artists">Alan Walker</span></a></li>
                <li><a href="#">3.雪落下的声音 (Live)<span class="rank-artists">周深</span></a></li>
                <li><a href="#">4.Different <span class="rank-artists">WorldAlan Walker</span></a></li>
            </div>
        </div>
    </div>
</div>

<footer id="footer">
    <div class="wrap">
        <div class="follow_on text-center">
            <dl class="friend_link">
                <dt>关于网站</dt>
                <dd>
                    <a>服务器：香港</a>
                    <a href="http://www.xinnet.com">域名提供商：新网</a>
                    <a href="https://www.cubecloud.net">服务器提供商：CubeCloud/魔方云</a>
                </dd>
            </dl>
        </div>
        <div class="">
            <p class="footer_menu text-center">
                <a href="#">关于轻云</a>|
                <a href="#">About</a>|
                <a href="http://www.xinnet.com/domain/cert.do?method=listCert&enDomainName=recomi.site">查看域名证书</a>|
                <a >无服务条款</a>|
            </p>
            <p class="copyrighten text-center">
                <span>Copyright © 2018 Kermi/Recomi.</span>
                <a href="#">All Rights Reserved.</a>
            </p>
            <p class="copyrighten text-center">
                <span>开发者：周翊坤   李锦明   张达   梁洪光   朱明泓   江钰颖</span>
            </p>
            <p class="copyrightzh text-center">
                <span>Kermi/Recomi</span> <a href="#">版权所有 翻版不究</a>
            </p>
        </div>
    </div>
</footer>
</body>
</html>