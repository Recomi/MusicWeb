<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%--
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
            <form id="form_id" action="/ViewThread" method="get">
              <li ><img src="res/qing-cloud.png"/></li>
              <input id="get_id" type="hidden" name="id" value="">
              <input id="select_page" type="hidden" name="page" value="">
                <%
                  ArrayList<String> titles = (ArrayList<String>) request.getSession().getAttribute("titles");
                  ArrayList<Integer> ids = (ArrayList<Integer>) request.getSession().getAttribute("ids");
                  int count = (int)request.getSession().getAttribute("count");
                  int pages = (int) Math.ceil( (double)count/5 );
                  System.out.println("count:" + count);
                  System.out.println("pages:" + pages);
                  int currentPage = 1;
                  int list_first = 0;
                  int list_end = 0;
                  try{
                      currentPage = Integer.parseInt(request.getParameter("page"));
                      if (currentPage > pages)
                          currentPage = pages;
                      if (currentPage < 1)
                          currentPage = 1;
                  }catch (NumberFormatException ignored){ }
                  System.out.println("currentPage:" + currentPage);
                  ////////////////////////////
                  list_first = (currentPage - 1) * 5;
                  if (currentPage == pages)
                      list_end = list_first + count % 5;
                  else
                    list_end = list_first + 5;
                  List<String> display_titles = titles.subList(list_first,list_end);
                  System.out.println(display_titles);
                  // 循环，显示标题列表
                  for (int i = list_first; i < list_end ; i++) {
                %>
                  <a onclick="viewThread( <%= ids.get(i)%> )" class="nav-a side-a"><%= titles.get(i)%></a>
                <% }    %>
              <div class="buttons">
                <a class="side-a button-pages" onclick="upPage()">上页</a>
                <%
                  if (currentPage <= 3 && currentPage > 0) {
                    for (int i = 1; i <= 5 ;i++) { %>
                      <a class="side-a button-pages" onclick="change_page( <%=i%> )"><%= i%></a>
                <% }%>
                  <%}else if (currentPage > 3 && currentPage <= pages - 2) {
                    for (int i = currentPage - 3 +1; i <= currentPage + 2 ;i++) { %>
                      <a class="side-a button-pages" onclick="change_page( <%=i%> )"><%= i%></a>
                <% }%>
                  <%}else {
                    for (int i = pages - 4; i <= pages ;i++) { %>
                      <a class="side-a button-pages" onclick="change_page( <%=i%> )"><%= i%></a>
                    <% }
                  }
                    %>
                <a class="side-a button-pages" onclick="nextPage()">下页</a>
              </div>
                <script>
                    function viewThread(id) {
                        document.getElementById("get_id").value = id;
                        var form = document.getElementById("form_id");
                        form.submit();
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
            </form>
          </ul>
        </div>
      </div>
      <div class="content-container card-white">
        <div class="content">
          <article>

            数学建模竞赛对专业的限制较小，任何专业的学生都可以参与这项活动，而不需要有什么专业背景。如果非要说背景，当然理工科的会有一定优势，但是文科学生也可以在这项比赛中发挥他们的长处，比如在论文写作方面。
            <br>
            在数学建模竞赛中，参赛队伍被要求在三到四天时间内解决一个实际问题，在这个过程中，可以使用任何工具、软件，可以随意跑动而没有固定的比赛场所，可以查阅任何资料、文献，但是不能与本队伍之外的其他任何有生命的物体就赛题进行交流（可以上网搜索，但是不能通过网络向别人求助）。最终参赛队必须提交一篇科技论文，以展示他们对问题的理解和做出的解决方案。而队伍成绩评定的依据，也全部来自他们提交的这篇论文。

            数学建模竞赛要解决的问题，往往没有固定的解决方式和答案。赛题的描述通常极具发散性，甚至不提供任何数据。对问题不同的理解，会产生不同的思路和模型；即便两支队伍对问题有相同的理解，他们的建模以及求解的方法，甚至最后的结果都可能完全不同。让我们看看过去五年的中国大学生数学建模竞赛(CUMCM)赛题：
            <br>
            (2014,A题) 嫦娥三号软着陆轨道设计与控制策略
            (2014,B题) 创意平板折叠桌
            (2013,A题) 车道被占用对城市道路通行能力的影响
            (2013,B题) 碎纸片的拼接复原
            (2012,A题) 葡萄酒的评价
            (2012,B题) 太阳能小屋的设计
            (2011,A题) 城市表层土壤重金属污染分析
            (2011,B题) 交巡警服务平台的设置与调度
            (2010,A题) 储油罐的变位识别与罐容表标定
            (2010,B题) 2010年上海世博会影响力的定量评估
            ......
            <br>
            以及过去四年的美国大学生数学建模竞赛(MCM)赛题：
            <br>
            (2015,A) 根除埃博拉病毒
            (2015,B) 寻找MH370
            (2015,C) 组织机构中的人力资源管理
            (2014,A) 除非超车，否则靠右行驶！
            (2014,B) 大学传奇教练
            (2014,C) 用网络衡量影响力
            (2013,A) 终极布朗尼烤盘
            (2013,B) 水，水，到处都是水
            (2013,C) 地球健康的网络建模
            (2012,A) 一棵树的叶子有多重
            (2012,B) 沿着大长河露营
            (2012,C) 犯罪预测
            ......
            <br>
            你从中看到了和数学的联系了吗？数学建模的赛题背景可能涉及任何一个领域，科技、医学、经济、交通、体育、环境、工程、社会......有兴趣的话，不妨去网上搜索一下，看看题目内容，感受一下。如此的开放性、趣味性和挑战性大概是吸引成千上万的学生投入这个活动的一大原因吧。
            <br>
            数模的团队
            在一个数学建模团队中，有三名队员。一般来说，他们每人负责一个方面——建模、编程、写作，但是并不严格，很多情况下是有交叉的，比如，通常是三个人一块进行建模。团队里每个人都发挥着重要的作用，有人给出整个团队的工作方向、解决分歧、统筹规划；有人是Problem Solver，扮演着程序员的角色；有人则像艺术家，将复杂的数学公式书写得清晰美丽，将看似毫无规律的数学结果“翻译”成平实的语言。
            <br>
            与有些竞赛团队（如ACM）不同，一个优秀的数学建模团队中不一定是三个数学高手，甚至三个都不是高手，但队员之间一定是相互理解、配合默契、愿意付出的。有的团队虽然三个人，但实际上只有一个人在做事，那即便这个人很强，既懂数学又会编程，也“并没有什么用”，因为没有交流、没有合作，一个人在如此短的时间内去完成所有的工作，是非常不容易的，对精力、体力都是巨大的考验。而且，他也无法去体会团队合作的乐趣了，所以孤军奋战是极不可取的。在我的观念中，有这么一个“搭配不等式”：
            <br>
            三个打了鸡血的菜鸟 > 孤军奋战的老鸟 > 猪队友
            <br>
            男女搭配，干活不累。在很多团队中，负责写作的是女生，因为写作是一个细活，需要细心、耐心，以及良好的沟通能力。但是这并不意味着仅仅会写作就行了，如果没有良好的数学基础，那将会困难重重——写作的队员如果无法将其他队员所提出的建模方法用严谨的数学语言、清晰的文字描述表达出来，那么无论他们想出了多么神奇的解决方案，都将功亏一篑。所以，负责写作的队员往往是团队的核心，也是最辛苦的。也因此，如果写作的队员是女生，那她在队里会受到优厚的待遇——其他队员的关切和爱护。而且，有女生在场，通常也会使得团队氛围更融洽，女生善于体察其他队员的思维、情绪，让交流能够更有效地进行。另外，如果这位女队员又比较漂亮的话......嗯，有个词叫“内部消化”，你懂的。君不见在小时候看的《奥特曼》系列中，那些扮演着保护地球的精英队员中总少不了一个漂亮的女队员......
            <br>
            参加数学建模活动的好处
            第一次听到“数学建模”这个词时，觉得很遥远、高大上、触不可及，看本文的你或许也觉得这是个很深奥的东西。但是今天在这里，我想告诉你：数学建模并不是一个多么深奥玄妙的东西。所谓数学建模，也就是用数学的方法去解决生产、生活中的实际问题，很多学科，比如物理学、经济学等等，都建立在数学的基础上，我们大学所学的专业课中的许多数学推导和公式，都可以说是一个个鲜活的建模案例。而数学建模竞赛中的问题，有些又是经过了简化以使得对于大学生们而言不至于太难，有些则需要学生自己去简化，最后所用的方法可能是很简单的，只要言之有理、逻辑清晰。
            <br>
            数学建模竞赛能让你意识到应用数学的魅力。我们在中学时代对数学的使用可能都是为了做数学题，为了考试取得好成绩，都是别人设计好的问题。但是在实际的生活中，很多问题可并不像那样能算出漂亮的结果（比如，没有小数点），而是一个系统工程，需要工程师们开动脑筋、利用各种工具（计算机、科学软件等）去解决问题，没有完美的答案，只有有效、可行的方案，而且会不断优化、改进。数学建模竞赛就是模拟了这个过程，虽然这个过程相比实际情况还有很大的差距，但是它能让你真正用起数学知识，意识到学数学可不仅仅是为了考试，去体会到用数学去解决实际问题的乐趣、体会到团队合作的力量。
            <br>
            数学建模竞赛给你创造快速学习、现学现用的机会。面对题目，你常常会感受到“书到用时方恨少”，但是与考试不同的是，你可以查阅任何书籍资料，快速学习所需要的知识。不再是大量的记忆、而是发散、搜索和创新。同时，你也能对其他专业领域的知识有所涉猎，并常常能感受到科学的相通性。比如，优化、运筹是数学建模竞赛中的一大问题类型，我自认为在这些方面有些能力，我看过运筹学、了解过风险建模，曾经熟悉并会运用数十种优化问题的求解方法。虽然这些方法现在我早已淡忘，但是相信依然可以短时间内重拾起来。参加数学建模竞赛的经历让我看到许许多多的专业都基于相同的数学理论，也让我对经济学、优化等方面产生了兴趣，所以，我有自信，如果去学习经济学，是可以顺利学下去而不会有很多障碍的。
            <br>
            参加数学建模竞赛还有很多其他好处，如获奖后的加分（有利于保研、出国），认识一群学霸，收获友谊甚至爱情，还有装13的资本，等等。
            <br>
            数学建模竞赛的局限性
            我在本科期间参加过许多次数学建模竞赛（不下7次吧，有的取得了不错的成绩，有的取得了很差的成绩，有的则放弃了），也慢慢认识到其局限性，这也是其后来再难吸引我的原因之一。
            <br>
            僵化的竞赛制度。国内的数学建模竞赛本身出发点是好的，这项竞赛在教育部推广的几大科技竞赛中也是规模最大（甚至是世界上规模最大的）。但是随着它的规模原来越大、参赛人数越来越多，其制度却越来越僵化。在评卷方面，国内的赛题往往对求解方法和结果有比较大的限定，如果结果做得不理想，就基本不可能获得好成绩了。而且，对论文的格式要求比较死，无论什么情况，一定要有“模型”、有“算法”、有“结果”，阅卷老师一眼看不到这些，估计这论文就悲剧了。而实际上，数学建模的过程不一定要有公式，有的队伍就喜欢在论文里堆砌复杂的数学公式，显得高大上些，以此来博人眼球，但其实呢？是一堆废话。解决问题甚至不一定要有数学模型，算法乃至程序也可以是“模型”，因为很多情况下，数学表达是有局限性的，它似乎总喜欢将简单的问题搞复杂。不知道你有没有这种感觉，有时候明明一个很简单的问题，若用数学符号去表达出来，就变得让人看不懂了。有人说数学语言是一个被设计得非常糟糕的语言，是有道理的。相比之下，程序语言常常是更好的模型，起初计算机程序语言被设计出来，就是为了对世界进行建模，以解决问题的。再比如程序设计的面向过程、面向对象、函数式编程思想，等等，都是对问题的建模方式。但是，数学建模竞赛的阅卷非常不重视程序，很多阅卷老师又不懂编程，导致了阅卷只重形式和结果的现状。更糟糕的是，程序、结果可以伪造，而阅卷时很难分辨它们到底是真实的还是伪造的，你以为阅卷老师会一行一行地去读你的代码吗？实际的情况可能是这样的：老师拿到一篇通过初审（摘要审）的论文，看到一个不错的结果，再看前面有没有把模型和算法写出来，哦，都写出来了，再看看全文的结构美不美观，嗯，不错，给个一等奖或者二等奖的分数......然后就看下一篇了。
            <br>
            面面俱到，则面面俱寡。数学建模竞赛的一大好处是可以让你接触到其他许多专业领域的问题，快速学习、现学现用，但我认为这也是一个缺点，参加数模竞赛甚至不需要赛前有多少准备。不会像ACM-ICPC，夜以继日的训练才有可能在比赛中斩获金银牌，ACM奖牌的获得者通常能够成长为顶尖的程序员，他们都有着深厚的算法功底、强大的编程能力和解决问题的能力；也不会像电子设计、机器人比赛，队员们须要对硬件电路知识有长期的积累。换句话说，数学建模不具备专业性，不容易形成技能的积累。所以，数学建模竞赛的门槛很低。不少队员也都是集中精力搞了一年就退了。我觉得它很适合本科生参加，广泛涉猎，也能比较系统地学习一些建模知识。研究生的话，更多的在于兴趣吧。
            <br>
            一次参赛，终生受益。这是数学建模竞赛的口号。参加数学建模活动的优点还是远远多于缺点的。如果你还是本科低年级，又一直在犹豫，亦或畏惧各类竞赛，我建议你不妨试试数学建模，说不定就一路成长起来了。如果你要读研了，但是又遗憾本科阶段没有参加过竞赛，那我也建议你可以试试数学建模，你会收获曾经没有过的体验、乐趣、友谊，说不定，还有爱情呢。
            <br>
            作者：虾米小华
            链接：https://www.jianshu.com/p/9fda994a487b
            來源：简书
            简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。

          </article></div>
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