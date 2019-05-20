<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %><%--
  Created by IntelliJ IDEA.
  User: kermi
  Date: 2018/12/5
  Time: 00:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pages</title>
    <link rel="stylesheet" href="bootstrap/bootstrap.min-3.3.7.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="bootstrap/bootstrap.min-3.3.7.js"></script>
</head>
<body>
<main>
    <div style="position: relative">
        <div style="width: 550px;margin: auto">
            <%--<form action="index" method="get">--%>
                <%
                    System.out.println(request.getAttribute("test"));
                    ArrayList<String> titles = (ArrayList<String>) request.getSession().getAttribute("titles");
                    ArrayList<Integer> ids = (ArrayList<Integer>) request.getSession().getAttribute("ids");
                    System.out.println(titles);
                    int count = (int)request.getSession().getAttribute("count");
                    int pages = (int) Math.ceil( (double)count/5 );
                    System.out.println("count:" + count);
                    System.out.println("pages:" + pages);
                    int currentPage = 1;
                    int showPage = 5;
                    int list_first = 0;
                    int list_end = 0;
                    request.getSession().setAttribute("currentPage",currentPage);
                    try{
                        currentPage = Integer.parseInt(request.getParameter("page"));
                        if (currentPage > pages)
                            currentPage = pages;
                        if (currentPage < 1)
                            currentPage = 1;
                    }catch (NumberFormatException e){
                        e.printStackTrace();
                    }
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
                    for (int i = list_first; i < list_end ; i++) {%>
                        <a class="list-group-item" onclick="viewThread( <%= ids.get(i)%> )"><%= titles.get(i)%></a>
                <% }    %>
                <br/><br/>
                <ul class="pagination pagination-lg" style="display:block;margin: auto">
                    <li><a onclick="firstPage()">首页</a>
                    <%
                        if (currentPage == 1)
                            out.write("<li class=\"disabled\"><a onclick=\"upPage()\">&laquo;</a>");
                        else
                            out.write("<li><a onclick=\"upPage()\">&laquo;</a>");
                    %>
                    <%
                      if (pages < showPage){
                          for (int i = 1; i <= pages ;i++)
                            showPagesNum(out,i,currentPage);
                      }else {
                          if (currentPage <= Math.ceil((double) showPage/2) && currentPage > 0) {
                            for (int i = 1; i <= showPage ;i++)
                                showPagesNum(out,i,currentPage);
                          }else if (currentPage > Math.ceil((double) showPage/2) && currentPage <= pages - Math.floor((double) showPage/2)) {
                            for (int i = currentPage - (int)Math.floor((double) showPage/2); i <= currentPage + Math.floor((double) showPage/2) ;i++)
                                showPagesNum(out,i,currentPage);
                          }else {
                            for (int i = pages - showPage + 1; i <= pages ;i++)
                                showPagesNum(out,i,currentPage);
                          }
                      }
                    %>
                    <%!
                        private void showPagesNum(JspWriter out,int i,int currentPage) throws IOException {
                            if (i == currentPage)
                                out.print("<li class=\"active\"><a onclick=\"change_page( " + i + " )\">" + i + "</a></li>");
                            else
                                out.print("<li><a class=\"\" onclick=\"change_page( " + i + " )\">" + i + "</a></li>");
                        }
                    %>
                    <%
                        if (currentPage == pages)
                            out.write("<li class=\"disabled\"><a onclick=\"nextPage()\">&raquo;</a>");
                        else
                            out.write("<li><a onclick=\"nextPage()\">&raquo;</a>");
                    %>
                    <li><a onclick="endPage()">尾页<%= "/" + pages + "页"%></a>
                    <%--<li><a  href="#">Previous</a></li>--%>
                    <%--<li><a href="#">1</a></li>--%>
                    <%--<li class="active"><a href="#">2</a></li>--%>
                    <%--<li><a href="#">3</a></li>--%>
                    <%--<li><a href="#">4</a></li>--%>
                    <%--<li><a href="#">5</a></li>--%>
                    <%--<li><a href="#">Next</a></li>--%>
                </ul>
            <%--</form>--%>
        </div>
        <%--<div style="width:auto;margin: auto">--%>
        <%--</div>--%>
    </div>

    <script>
        function viewThread(id) {
            document.getElementById("get_id").value = id;
            var form = document.getElementById("form_id");
            form.submit();
        }
        function firstPage() {
            change_page(1);
        }
        function endPage() {
            change_page(<%= pages%>);
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
</main>
</body>
</html>