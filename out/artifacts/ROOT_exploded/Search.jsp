<%@ page import="GSON.NeteaseMusic.Search.Songs" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %><%--
  Created by IntelliJ IDEA.
  User: kermi
  Date: 2018/12/10
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="stylesheet" href="css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <link rel="stylesheet" href="css/foot.css" />
    <link rel="stylesheet" type="text/css" href="css/index.css">
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
    <style type="text/css">
        .result-success{
            width: 100%;
            color: #6a757c;
        }
        .a_name{
            color: #4f9d87;
        }
        .a_name:hover{
            color: #67c4a9;
            text-decoration: none;
        }
        .a_artists,.a_album{
            font-size: 13px;
            color: #8e9d93;
        }
        .a_artists:hover,.a_album:hover{
            color: #b4c4b9;
            text-decoration: none;
        }
        .ellipsis_div {
            width: 100%;
            font-weight: 400;
            overflow: hidden;
            white-space: nowrap;
        }
        .ellipsis_txt {
            float: left;
            max-width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .search_separator{
            display: none;
            font-size: 13px;
            white-space: nowrap;
            overflow: visible;
            position: relative;
        }
        .result{
            height: auto;
            display: flex;
            flex-direction: column;
            text-align: center;
            margin: 10% 0 0 0;
        }
        .icon-nofound{
            width: 8%;
            margin: auto;
            transition: .3s;
        }
        .text-nofound{
            width: 75%;
            margin: auto;
            font-size: 1.1em;
            text-align: center;
            color: #64788a;
        }
        .pagination{
            justify-content: center;/*分页居中*/
        }
        @media (min-width: 1200px) {
            .result{
                flex-direction: unset;
                flex-wrap: nowrap;
                width: 50%;
                margin: auto;
                height: 50%;
            }
            .icon-nofound{
                flex: 1;
            }
            .text-nofound{
                flex: 6;
                display: flex;
                flex-wrap: wrap;
                font-size: 1.2em;
            }
        }
        @media (max-width: 600px) {
            .container{
                padding: 0;
            }
            .ellipsis_name{
                width: 100%;
                max-width: 100%;
                flex: none;
            }
            .ellipsis_div_artists,.ellipsis_div_album{
                width: auto;
                max-width: 45%;
                flex: none;
            }
            .ellipsis_div_artists{
                padding-right: 1px;
            }
            .ellipsis_div_album{
                padding-left: 1px;
            }
            .search_separator{
                display: block;
            }
            .result-success{
                text-align: center;
            }
            .result{
                margin: 20% 0 0 0;
            }
            .icon-nofound {
                width: 15%;
            }
            .text-nofound{
                width: 95%;
            }
        }
    </style>
    <script type="text/javascript">
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
</head>
<canvas id="background" style="width: 100%;height: 100%;z-index: -1;pointer-events: none"></canvas>
<script src="js/粒子特效.js"></script>
<body style="z-index: 999">
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

        <a class="slidebar-toggler text-black-50" href="index.jsp">
            <i class="fas fa-home"></i>
        </a>
    </div>
</nav>
<div class="container">
    <form action="search" method="get">
        <div class="input-group mb-3">
            <input name="s_text" type="text" class="form-control" placeholder="搜索" value=
                    "<%= request.getParameter("s_text") == null ? "" : request.getParameter("s_text")%>"
            >
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </form>
    <div class="list-group bg-transparent">
        <%
            String s_text = request.getParameter("s_text");
            try {
                List<Songs> songsList = (List<Songs>) request.getAttribute("SongsList");
                int count_all = (Integer) request.getAttribute("count_all");
                writeCount(out,count_all);
                System.out.println(count_all);
                int count = songsList.size();
                for (int i = 0 ; i <= count - 1 ; i++) {
                    writeResult(out,songsList,i);
                }
            }catch (Exception e) {
                writeNoFound(out,s_text);
            }
        %>
    </div>
</div>
<%
    int max_pages = Integer.parseInt((String) request.getAttribute("max_pages"));
    int currentPage = Integer.parseInt(
            request.getParameter("page") == null ? "1" : request.getParameter("page")
    );
    int showPages = 9;
    writePagination(out,showPages,max_pages,currentPage);
%>
<%!
    void writeCount(JspWriter out,int count) {
        String str = "\n" +
                "    <div class=\"result-success\">\n" +
                "        共找到\n" +
                "            <span class=\"text-danger\">" + count + "</span>\n" +
                "        首歌曲\n" +
                "    </div>";
        try {
            out.write(str);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    void writeResult(JspWriter out,List<Songs> songsList,int position) throws IOException {
        String str = "\n" +
                "        <li class=\"list-group-item list-group-item-action bg-transparent\">\n" +
                "            <div class=\"row\">\n" +
                "                <div class=\"col-3 ellipsis_txt ellipsis_name\">\n" +
                "                    <a class=\"a_name\" href=\"" + "/player?id=" + songsList.get(position).id + " \">" + songsList.get(position).name + "</a>\n" +
                "                </div>\n" +
                "                <div class=\"col-3 ellipsis_div ellipsis_div_artists\">\n" +
                "                    <span class=\"ellipsis_txt\">\n" +
                "                        <a class=\"float-left ellipsis_txt a_artists\" href=\"#\">" + songsList.get(position).artists.get(0).name + "</a>\n" +
                "                    </span>\n" +
                "                </div>\n" +
                "                <span class=\"search_separator\">&nbsp-&nbsp</span>\n" +
                "                <div class=\"col-3 ellipsis_div ellipsis_div_album\">\n" +
                "                    <span class=\"ellipsis_txt\">\n" +
                "                        <a class=\"float-left ellipsis_txt a_album\" href=\"#\">" + songsList.get(position).album.name  + "</a>\n" +
                "                    </span>\n" +
                "                </div>\n" +
                "            </div>\n" +
                "        </li>";
        out.write(str);
    }
    void writeNoFound(JspWriter out,String s_text) {
        String str = "\n" +
                "<div class=\"result\">\n" +
                "    <img class=\"icon-nofound\" src=\"res/nofound.png\">\n" +
                "    <span class=\"text-nofound\">\n" +
                "        <div class=\"\">\n" +
                "            很抱歉，暂时没有找到与“\n" +
                "                <span class=\"text-info\">" + s_text + "</span>\n" +
                "            ”相关的结果\n" +
                "        </div>\n" +
                "        <div class=\"\">\n" +
                "            请检查输入的关键词是否有误或者过长\n" +
                "        </div>\n" +
                "    </span>\n" +
                "</div>";
        try {
            out.write(str);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    void writePagination(JspWriter out,int showPages,int max_pages,int currentPage) throws IOException {
        //输出 nav 和 ul 标签
        out.write("\n" +
                "    <nav class=\"text-center\">\n" +
                "        <ul class=\"pagination\">\n");
        //输出<上一页>按钮
        if (currentPage == 1)
            // 当前页码为1时，处理上一页按钮能否被响应
            out.write("<li class=\"page-item disabled\"><a class=\"page-link\" href=\"#\" onclick=\"upPage()\">&laquo;</a></li>\n");
        else
            out.write("<li class=\"page-item\"><a class=\"page-link\" href=\"#\" onclick=\"upPage()\">&laquo;</a></li>\n");
        //输出适量的页码数字
        if (max_pages < showPages){
            //当 <最大页码> 达不到 <显示页码数> 时，输出所有页码数字
            for (int i = 1; i <= max_pages ;i++)
                writePagesNum(out,i,currentPage);
        }else {
            /*  当 <当前页码> 在 <显示页码数> 的前半部分时*/
            if (currentPage <= Math.ceil((double) showPages/2) && currentPage > 0) {
                //显示中间的数字
                for (int num = 1; num <= showPages ;num++)
                    writePagesNum(out,num,currentPage);
                //显示末尾页(数字)和省略号
                out.write("<span>&nbsp;...&nbsp;</span>");
                writePagesNum(out,max_pages,currentPage);
                /*  当 <当前页码> 在 <显示页码数> 的正中间时*/
            }else if (currentPage > Math.ceil((double) showPages/2) && currentPage <= max_pages - Math.floor((double) showPages/2)) {
                //显示首页(1)和省略号
                writePagesNum(out,1,currentPage);
                out.write("<span>&nbsp;...&nbsp;</span>");
                //显示中间的数字
                for (int num = currentPage - (int)Math.floor((double) showPages/2); num <= currentPage + Math.floor((double) showPages/2) ;num++)
                    writePagesNum(out,num,currentPage);
                //显示末尾页(数字)和省略号
                out.write("<span>&nbsp;...&nbsp;</span>");
                writePagesNum(out,max_pages,currentPage);
            }else {   /*  <当前页码> 在 <显示页码数> 的后半部分时*/
                //显示首页(1)和省略号
                writePagesNum(out,1,currentPage);
                out.write("<span>&nbsp;...&nbsp;</span>");
                //显示中间的数字
                for (int num = max_pages - showPages + 1; num <= max_pages ;num++)
                    writePagesNum(out,num,currentPage);
            }
        }
        //输出<下一页>按钮
        if (currentPage == max_pages)
            // 当前页码为 <最大页码> 时，处理下一页按钮能否被响应
            out.write("<li class=\"page-item disabled\"><a class=\"page-link\" href=\"#\" onclick=\"nextPage()\">&raquo;</a></li>\n");
        else
            out.write("<li class=\"page-item\"><a class=\"page-link\" href=\"#\" onclick=\"nextPage()\">&raquo;</a></li>\n");
        //输出 ul 和 li 的闭合标签
        out.write("        </ul>\n" +
                "    </nav>");
    }
    private void writePagesNum(JspWriter out, int num, int currentPage) {
        try {
            if (num == currentPage)
                out.print("<li class=\"page-item active\"><a class=\"page-link\" onclick=\"change_page( " + num + " )\">" + num + "</a></li>");
            else
                out.print("<li class=\"page-item\"><a class=\"page-link\" onclick=\"change_page( " + num + " )\">" + num + "</a></li>");
        }catch (IOException e) {
            e.printStackTrace();
        }
    }
%>
<script>
    function firstPage() {
        change_page(1);
    }
    function endPage() {
        change_page(<%= max_pages%>);
    }
    function upPage() {
        change_page(<%= currentPage -1%>);
    }
    function nextPage() {
        change_page(<%= currentPage + 1%>);
    }
    function change_page(page) {
        window.location.href = changeURLArg(window.location.href,'page',page);
    }
    function changeURLArg(url,arg,arg_val){
        var pattern=arg+'=([^&]*)';
        var replaceText=arg+'='+arg_val;
        if(url.match(pattern)){
            var tmp='/('+ arg+'=)([^&]*)/gi';
            tmp=url.replace(eval(tmp),replaceText);
            return tmp;
        }else{
            if(url.match('[\?]')){
                return url+'&'+replaceText;
            }else{
                return url+'?'+replaceText;
            }
        }
    }
</script>
<footer style="position: relative" id="footer">
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
