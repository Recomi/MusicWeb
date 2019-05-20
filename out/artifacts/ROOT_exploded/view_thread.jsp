<%@ page import="java.util.Date" %>
<%@ page import="java.lang.String" %>
<%@ page import="servlet.Index" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.Article" %><%--
  Created by IntelliJ IDEA.
  User: kermi
  Date: 2018/9/5
  Time: 09:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%
  Date createTime = new Date(session.getCreationTime());
%>
<!DOCTYPE html>
<html lang="zh-CN">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<head>
  <meta charset="UTF-8">
  <title>Recomi-Fun in Find</title>
  <link href="css/MyWeb/main.css" rel="stylesheet" type="text/css"/>
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
  <script type="text/javascript">
      window.onload=function(){
          change();
      };
      //当浏览器窗口大小改变时，设置显示内容的高度  
      window.onresize=function(){
          change();
      };
      function change() {
          var side = document.getElementById('side');
          var top_items = document.getElementById('top-items');
          var screen_width = window.screen.width;
          // var screen_height = window.screen.height;
          var body_width = document.body.clientWidth;
          // var body_height = document.body.clientHeight;
          if (body_width < screen_width / 1.8) {
              side.style.display = "none";
              top_items.style.display = "none";
          } else {
              side.style.display = "block";
              top_items.style.display = "block";
          }
      }
  </script>
  <script type="text/javascript">
      jQuery(document).ready(function($) {
          $("#menu-box").hide();
          $("#menu-icon").click(function() {
              $("#menu-box").animate({
                  width: 'toggle',
                  height: 'toggle'
              },150);
          });
          $(".site-main").click(function() {
              $("#menu-box").hide(150);
          });
      });
      function hide(id) {
          var obj = document.getElementById(id).style;
          obj.visibility="hidden";
          // obj.opacity="0";
      }
      function slide_display(id) {
          var obj = document.getElementById(id).style;
          obj.visibility="visible";
          // obj.opacity="1";
      }
      function slide_over_headicon(id) {
          var obj = document.getElementById(id).style;
          obj.transform = "translateY(10px)";
          obj.width = "60px";
          obj.height = "60px";
      }
      function slide_hide_headicon(id) {
          var obj = document.getElementById(id).style;
          obj.transform = "";
          obj.width = "40px";
          obj.height = "40px";
      }
  </script>
</head>
<body>
<section id="main-container">
  <div class="openNav"></div>
  <div class="page">
    <header class="card-white site-top">
      <div id="top-nav">
        <div id="top-items">
          <ul>
            <a class="nav-a top-nav-a" href="Frist.html">首頁</a>
            <a class="nav-a top-nav-a" href="Second.html">Web1</a>
            <a class="nav-a top-nav-a" href="CanvasTest1.html">Web2</a>
            <a class="nav-a top-nav-a" href="Frist.html">Web3</a>
            <a class="nav-a top-nav-a" href="Frist.html">Web4</a>
            <a class="nav-a top-nav-a" href="Frist.html">Web5</a>
            <a class="nav-a top-nav-a" href="Frist.html">Web6</a>
          </ul>
        </div>
        <div class="nav-item">
          <div id="menu-icon" class="icon-button">
            <div class="menu-icon-line card-white"></div>
            <div class="menu-icon-line card-white"></div>
            <div class="menu-icon-line card-white"></div>
          </div>
        </div>
        <div id="headicon" onmouseleave="hide('bubble-login');slide_hide_headicon('top-headicon-img')" >
          <div id="headicon-item" onmouseover="slide_display('bubble-login');slide_over_headicon('top-headicon-img')">
            <img id="top-headicon-img" class="headicon-img" src="res/昙花.png"/>
          </div>
          <div class="card-white bubble-nav-account" id="bubble-login">
            <div class="login-text">快来加入我们吧！</div>
            <a class="card-white login-button" href="Login.jsp">登陆</a>
            <a class="card-white login-button" href="#">注册</a>
            <%--<p>userName:<%= session.getAttribute("user")%></p>--%>
            <%--<jsp:useBean id="user" class="bean.User" scope="page"/>--%>
            <p>userName:<%= session.getAttribute("userName")%></p>
            <%--<p>userName:<jsp:getProperty name="user" property="userName" /></p>--%>
          </div>
        </div>
        <div id="search" class="nav-item">
          <form name="search_form" action="Search">
            <input type="text" class="input nav-search-input" placeholder="Search">
          </form>
        </div>
        <aside id="menu-box" class="card-white">
          <ul>
            <a href="Login.html" class="menu-item nav-hover">AAAA</a>
            <a href="Login.html" class="menu-item nav-hover">BBBB</a>
            <a href="Login.html" class="menu-item nav-hover">CCCC</a>
            <a href="Login.html" class="menu-item nav-hover">DDDD</a>
            <a href="Login.html" class="menu-item nav-hover">EEEE</a>
          </ul>
        </aside>
      </div>
    </header>
    <main class="site-main">
      <div id="side" class="card-white">
        <div class="side-nav" >
          <ul>
            <li ><img src="res/qing-cloud.png"/></li>
              <%
                  ArrayList<String> titles = (ArrayList<String>) request.getSession().getAttribute("titles");
                  System.out.println(titles);
                  for (String string :titles) {
//                    String string = (String) object;
              %>
                 <a href="#" class="nav-a side-a"><%= string%></a>
              <% }   %>
          </ul>
        </div>
      </div>
      <div class="content-container card-white">
        <div class="content">
          <% Article article = (Article) request.getSession().getAttribute("article");%>
          <% String string =  article.getContent(); %>
          <article>
            <%= string%>
          </article>
        </div>
      </div>
    </main>
    <footer>
      <div id="footer-block">
        <img class="end-img" src="https://raw.githubusercontent.com/BNDong/Cnblogs-Theme-SimpleMemory/master/img/footer.png"/>
        <div class="fooder-end">
          <div class="fooder-text">Copyright ©2018 recomi<br/>
            【事实并非理所当然❤️世界总是欲盖弥彰】
          </div>
        </div>
      </div>
    </footer>
  </div>
</section>
</body>
</html>