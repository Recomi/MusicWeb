<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %>
<%@ page import="bean.Music_complete" %><%--
Created by IntelliJ IDEA.
User: kermi
Date: 2018/12/10
Time: 20:57
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Music_complete complete = (Music_complete) request.getAttribute("music_complete");
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>Music</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="stylesheet" href="css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <script>
        // 初始化，隐藏部分控件
        (function () {
            jQuery(document).ready(function ($) {
                $(".fa-pause").hide();
                $(".fa-heart.fas").hide();
                $(".fa-heart.far").show();
                $("#vol_mute").hide();
                $("#ctrl_vol").show();
            });
        }());
    </script>
    <script>
        var time;
        var rot = 0;
        var is_rotating = false;
        function rotateCover() {
            if (is_rotating) {
                is_rotating = false;
                window.clearInterval(time); // 利用计时器控制开始、暂停、继续
            } else {
                time = window.setInterval(begin,0);
                is_rotating = true;
            }
            function begin(){
                document.getElementById("cover").style.transform="rotatez("+rot+"deg)";
                rot+=0.04;
            }
        }
        var is_playing = false;
        function play() {
            rotateCover();
            var music = document.getElementById("music");
            jQuery(document).ready(function ($) {
                if (is_playing) {
                    $(".fa-play").show();
                    $(".fa-pause").hide();
                    music.pause();
                    is_playing = false;
                } else {
                    $(".fa-play").hide();
                    $(".fa-pause").show();
                    music.play();
                    is_playing = true;
                }
            });
        }
        function next_music() {
            //
        }
        function previous_music() {
            //
        }
        //进度条
        jQuery(document).ready(function ($) {
            var music = document.getElementById("music");
            var schedule = $("#schedule");
            var schedule_ball = $("#schedule-ball");
            var is_move = false;  //用于判断是否正在移动滑球
            var x = schedule.offset().left; //完整进度条的x坐标位置
            var x_ball = 0;       //当前的进度
            var sche_leng = schedule.width(); //完整进度条的像素长度
            //设置更新进度的定时任务，每100毫秒执行一次
            var time_ball = window.setInterval(refreshBall,1000);
            //
            $("#schedule-container").mousedown(function (e) {
                window.clearInterval(time_ball);
                is_move = true;
                x_ball = e.clientX - x;
                schedule_ball.css(
                    "transform","translateX("  + x_ball + "px)"
                );
                // 刷新进度条显示
                $("#schedule-already").css("width", x_ball / sche_leng * 100 + "%");
                $(document).mousemove(function (e_) {
                    if (is_move) {
                        var x_ = e_.clientX;
                        x_ball = x_ - x ;
                        if (x_ball < 0)
                            x_ball = 0;
                        if (x_ball > sche_leng)
                            x_ball = sche_leng;
                        $("#schedule-ball").css(
                            "transform","translateX("  + x_ball + "px)"
                        );
                        // 刷新进度条显示
                        $("#schedule-already").css("width", x_ball / sche_leng * 100 + "%");
                        var percentage = x_ball / sche_leng;
                        refreshText(percentage);
                    }
                });
                $(document).mouseup(function () {
                    if (is_move) {
                        var percentage = x_ball / sche_leng;
                        refreshSchedule(percentage);
                        time_ball = window.setInterval(refreshBall,1000);
                    }
                    is_move = false;
                });
            });

            //刷新歌曲的真实进度
            function refreshSchedule(percentage) {
                var music = document.getElementById("music");
                var duration = music.duration;
                music.currentTime = duration * percentage;
                $("#currentTime").text(
                    Math.floor(music.currentTime / 60) + ":" +
                    Math.floor(music.currentTime % 60)
                );
            }

            //刷新滑球位置
            function refreshBall() {
                var music = document.getElementById("music");
                var duration = music.duration;
                var percentage = music.currentTime / duration;
                x_ball = Math.round(sche_leng * percentage);
                if (!is_move)
                    $("#schedule-ball").css(
                        "transform","translateX("  + x_ball + "px)"
                    );
                if (x_ball >= sche_leng)
                    play();//会导致循环播放
                // 刷新进度条显示
                $("#schedule-already").css(
                    "width", percentage * 100 + "%"
                );
                // $("#x_ball").text(x_ball);
                refreshText(percentage)
            }

            //刷新文字（数字）进度
            function refreshText(percentage) {
                $("#currentTime").text(
                    Math.floor(percentage * music.duration / 60) + ":" +
                    Math.floor(percentage * music.duration % 60)
                );
                $("#duration").text(
                    Math.floor(music.duration / 60)  + ":" +
                    Math.floor(music.duration % 60)
                );
            }
        });
    </script>
    <script>
        var is_move_vol = false;  //用于判断是否正在拖动音量控制
        //音量控制条
        jQuery(document).ready(function ($) {
            var container = $("#vol-container");
            var music = document.getElementById("music");
            var vol_full = $("#vol-full");
            var vol_current = $("#vol-current");
            var vol_full_leng = vol_full.height(); //完整进度条的像素长度
            var y = vol_full.offset().top + vol_full_leng; //完整进度条的Y坐标位置
            var y_cur_vol = 0;       //当前的音量长度
            var percentage = 0;       //当前音量的百分比
            //
            container.mousedown(function (e) {
                is_move_vol = true;
                y_cur_vol = y - e.clientY;
                vol_current.css(
                    "height",y_cur_vol + "px"
                );
                $(document).mousemove(function (e_) {
                    if (is_move_vol) {
                        y_cur_vol = y - e_.clientY;
                        if (y_cur_vol < 0)
                            y_cur_vol = 0;
                        if (y_cur_vol > vol_full_leng)
                            y_cur_vol = vol_full_leng;
                        vol_current.css(
                            "height",y_cur_vol + "px"
                        );
                        percentage = (y_cur_vol / vol_full_leng )* 100;
                        refreshVolume(percentage / 100);
                    }
                });
                $(document).mouseup(function (e__) {
                    is_move_vol = false;
                    e.stopPropagation();
                    e__.stopPropagation();
                });
            });

            //刷新歌曲音量
            function refreshVolume(percentage) {
                if (is_move_vol)
                    music.volume = percentage;
            }
        });
        jQuery(document).ready(function ($) {
            var music = document.getElementById("music");
            // $("#ctrl_vol").click(function (e) {
            //     $("#ctrl_vol").hide();
            //     $("#vol_mute").show();
            //     music.muted = true;
            // });
            // $("#vol_mute").click(function (e) {
            //     $("#vol_mute").hide();
            //     $("#ctrl_vol").show();
            //     music.muted = false;
            //
            // });
        });
    </script>
    <script>
        //歌曲列表
        music_ids = {
            27843535:'Never Say Never',
            416892104:'黑暗森林',
            435278010:'world.execute (me) ;',
            446512251:'永久の宴',
            534065323:'Sincerely'
        };
        // for (var id in music_ids) {
        //     alert(id+":"+music_ids[id]);
        // }
    </script>
    <script>
        jQuery(document).ready(function ($) {
            var lyric_text = $("#lyric-str").text();
                // ,async:false}).responseText;
            var lyrics = lyric_text.split('\n');
            var lyricsArray = [];
            $.each(lyrics, function (i, item) {    // 遍历medises，并且将时间和文字拆分开，并push进自己定义的数组，形成一个对象数组
                var t = item.substring(item.indexOf("[") + 1, item.indexOf("]"));
                lyricsArray.push({
                    t: (t.split(":")[0] * 60 + parseFloat(t.split(":")[1])).toFixed(2),
                    c: item.substring(item.indexOf("]") + 1, item.length)
                });
            });
            var ul = $("#lyric-ul");
            // 遍历medisArray，并且生成li标签，将数组内的文字放入li标签
            $.each(lyricsArray, function (i, item) {
                var li = $("<li style='list-style: none;margin: auto;width: 100%;'>");
                li.html(item.c);
                ul.append(li);
            });
            //
            var fraction = 0.5;
            var topNum = 0;
            function lineHeight(lineno){
                var ul = $("#lyric-ul");
                var $ul = document.getElementById('lyric-ul');
                // 令正在唱的那一行高亮显示
                if (lineno > 0) {
                    $(ul.find("li").get(topNum + lineno - 1)).removeClass("lineheight");
                }
                var nowline = ul.find("li").get(topNum + lineno);
                $(nowline).addClass("lineheight");

                // 实现文字滚动
                var _scrollTop;
                $ul.scrollTop = 0;
                if ($ul.clientHeight * fraction > nowline.offsetTop) {
                    _scrollTop = 0;
                } else if (nowline.offsetTop > ($ul.scrollHeight - $ul.clientHeight * (1 - fraction))) {
                    _scrollTop = $ul.scrollHeight - $ul.clientHeight;
                } else {
                    _scrollTop = nowline.offsetTop - $ul.clientHeight * fraction;
                }

                //以下声明歌词高亮行固定的基准线位置成为 “A”
                if ((nowline.offsetTop - $ul.scrollTop) >= $ul.clientHeight * fraction) {
                    //如果高亮显示的歌词在A下面，那就将滚动条向下滚动，滚动距离为 当前高亮行距离顶部的距离-滚动条已经卷起的高度-A到可视窗口的距离
                    $ul.scrollTop += Math.ceil(nowline.offsetTop - $ul.scrollTop - $ul.clientHeight * fraction);

                } else if ((nowline.offsetTop - $ul.scrollTop) < $ul.clientHeight * fraction && _scrollTop !== 0) {
                    //如果高亮显示的歌词在A上面，那就将滚动条向上滚动，滚动距离为 A到可视窗口的距离-当前高亮行距离顶部的距离-滚动条已经卷起的高度
                    $ul.scrollTop -= Math.ceil($ul.clientHeight * fraction - (nowline.offsetTop - $ul.scrollTop));

                } else if (_scrollTop === 0) {
                    $ul.scrollTop = 0;
                } else {
                    $ul.scrollTop += $(ul.find('li').get(0)).height();
                }
            }
            //
            var music = document.getElementById("music");
            var lineNo = 10;
            music.ontimeupdate = function () {
                if (lineNo === lyricsArray.length - 1 && music.currentTime.toFixed(2) >= parseFloat(lyricsArray[lineNo].t)) {
                    lineHeight(lineNo);
                }
                if (parseFloat(lyricsArray[lineNo].t) <= music.currentTime.toFixed(2) &&
                    music.currentTime.toFixed(2) <= parseFloat(lyricsArray[lineNo + 1].t)) {
                    lineHeight(lineNo);
                    lineNo++;
                }
            };
            window.setInterval(music.ontimeupdate,10);
        });
    </script>
    <style type="text/css">
        body .page{
            margin: 0;
            padding: 0;
        }
        .lineheight{
            border-radius: 50px;
            background-color: #6aafa9;
            height: 20px;
            color: whitesmoke;
        }
        .page{
            width: 100%;
            margin: auto;
            height: auto;
            position: relative;
            display: flex;
        }
        .unselectable{
            user-select: none;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
        }
        .player{
            width: 300px;
            min-width: 300px;
            position: relative;
            margin: 60px 40px;
        }
        .lyric-container{
            margin: auto;
            width: 100%;
            max-width: 600px;
        }
        #lyric-content{
            text-align: center;
            font-size: 14px;
            transition: .3s;
        }
        #lyric-ul{
            height: 400px;
            overflow: auto;
            display: flex;
            flex-wrap: wrap;
        }
        #flag_ctrl{
            position: relative;
            float: right;
        }
        .cover-container{
            position: relative;
            text-align: center;
            margin: 40px 0;
        }
        #cover{
            margin: auto;
            border-radius: 200px;
            width: 200px;
            height: 200px;
            box-shadow: 0 0 10px 0 #5b5b5b;
        }
        #cover:hover{
            box-shadow: 0 0 20px 0 #5b5b5b;
        }
        .schedule-num{
            text-align: center;
            width: 100%;
            height: 10px;
        }
        #currentTime{
            float: left;
            height: 10px;
        }
        #duration{
            float: right;
            height: 10px;
        }
        #schedule-container{
            margin-top: 20px;
            position: relative;
        }
        #schedule{
            width: 100%;
            height: 5px;
            margin-top: 5px;
            position: absolute;
            border-radius: 10px;
            background-color: #cdcdcd;
        }
        #schedule-already{
            width: 0;
            height: 5px;
            margin-top: 5px;
            position: absolute;
            border-radius: 10px;
            background-color: #6aafa9;
        }
        #schedule-ball{
            left: -7px;
            width: 15px;
            height: 15px;
            position: relative;
            background-color: #eefbff;
            border-radius: 10px;
            box-shadow: 0 1px 5px 0 #5b5b5b;
        }
        .controls{
            text-align: center;
            position: absolute;
            width: 100%;
        }
        .operate-button{
            z-index: 10;
            position: relative;
            margin: 0 15px;
            font-size: 18px;
            color: #5b5b5b;
            transition: .2s;
        }
        .operate-button:hover{
            color: #6aafa9;
        }
        #vol-container{
            position: absolute;
            height: 100px;
            top: -100px;
            width: 30px;
            left: -5px;
            margin: 0;
            visibility: hidden;
            opacity: 0;
            transition: .3s;
        }
        #ctrl_vol:hover #vol-container{
            visibility: visible;
            opacity: 1;
        }
        #vol-full{
            left: 7px;
            position: absolute;
            z-index: 1;
            bottom: 5px;
            width: 15px;
            height: 80px;
            border-radius: 40px;
            box-shadow:inset 0 0 3px 0 rgba(155, 155, 155, 1);
            background-color: rgba(248, 255, 254, 0.11);
            overflow: hidden;
        }
        #vol-current{
            position: absolute;
            z-index: 1;
            bottom: 0;
            width: 15px;
            height: 40px;
            overflow: hidden;
            box-shadow:inset 0 0 3px 0 rgba(155, 155, 155, 1);
            background-color: rgba(154, 195, 188, 0.81);
        }
        .fa-heart.fas{
            color: red;
        }
        .ctrl-button{
            font-size: 28px;
            margin: 5px 24px;
            transition: .2s;
        }
        .ctrl-button:hover{
            /*box-shadow: inset 0px 0px 5px 0px #00c1d6;*/
            color: #6aafa9;
        }
        @media (max-width: 600px) {
            .page{
                flex-flow: column;
            }
        }
    </style>
    <link rel="stylesheet" href="css/下雪粒子特效.css">
</head>
<body>

<div class="snow snow1"></div>
<div class="snow snow2"></div>
<div class="snow snow3"></div>
<div class="snow snow4"></div>
<div class="snow snow5"></div>
<div class="snow snow6"></div>
<div class="snow snow7"></div>
<div class="snow snow8"></div>
<div class="snow snow9"></div>
<div class="snow snow10"></div>
<div class="snow snow11"></div>
<div class="snow snow12"></div>
<div class="snow snow13"></div>
<div class="snow snow14"></div>
<div class="snow snow15"></div>
<div class="snow snow16"></div>
<div class="snow snow17"></div>
<div class="snow snow18"></div>
<div class="snow snow19"></div>
<div class="snow snow20"></div>
<div class="snow snow21"></div>
<div class="snow snow22"></div>
<div class="snow snow23"></div>
<div class="snow snow24"></div>
<div class="snow snow25"></div>
<div class="snow snow26"></div>
<div class="snow snow27"></div>
<div class="snow snow28"></div>
<div class="snow snow29"></div>
<div class="snow snow30"></div>
<div class="snow snow31"></div>
<div class="snow snow32"></div>
<div class="snow snow33"></div>
<div class="snow snow34"></div>
<div class="snow snow35"></div>
<div class="snow snow36"></div>
<div class="snow snow37"></div>
<div class="snow snow38"></div>
<div class="snow snow39"></div>
<div class="snow snow40"></div>
<div class="snow snow41"></div>
<div class="snow snow42"></div>
<div class="snow snow43"></div>
<div class="snow snow44"></div>
<div class="snow snow45"></div>

    <%--<canvas id="background" style="width: 100%;height: 100%;"></canvas>--%>
    <%--<script src="js/粒子特效.js"></script>--%>
    <div id="lyric-str" style="display: none"><%= complete.getLyric()%></div>
    <main class="page">
        <div class="player">
            <div class="text-center" style="font-size: 1.4em"><%= complete.getName()%></div>
            <audio id="music" hidden>
                <source src=
                            "<%= complete.getLink()%>"
                        type="audio/mp3" codecs="mp3"/>
            </audio>
            <div class="cover-container unselectable">
                <img id="cover" src=
                        "<%= complete.getPicUrl()%>"/>
            </div>
            <div class="schedule-num unselectable">
                <i id="ctrl_vol" class="operate-button fas fa-volume-up">
                    <div id="vol-container">
                        <div id="vol-full">
                            <div id="vol-current"></div>
                        </div>
                    </div>
                </i>
                <i id="vol_mute" class="operate-button fas fa-volume-off" ></i>
                <i class="operate-button far fa-heart" onclick="if_like()"></i>
                <i class="operate-button fas fa-heart" onclick="if_like()"></i>
                <a href="<%= complete.getLink()%> " download="<%= complete.getName() + " - " + complete.getArtists() + ".mp3"%>">
                    <i class="operate-button fas fa-download"></i>
                </a>
                <i class="operate-button fas fa-list-ul"></i>
                <i class="operate-button fas fa-random"></i>
            </div>
            <div id="schedule-container">
                <div id="schedule"></div>
                <div id="schedule-already"></div>
                <div id="schedule-ball"></div>
            </div>
            <span id="currentTime">00:00</span>
            <span id="duration">00:00</span>
            <div class="controls unselectable">
                <i class="ctrl-button fas fa-step-backward"></i>
                <i class="ctrl-button fas fa-play" onclick="play()" ></i>
                <i class="ctrl-button fas fa-pause" onclick="play()"></i>
                <i class="ctrl-button fas fa-step-forward"></i>
            </div>
        </div>
        <div class="lyric-container">
            <div id="lyric-content" class="bd bd-open f-brk f-ib" data-song-id="416892104" data-third-copy="false">
                <ul id="lyric-ul"></ul>
            </div>
                <a id="flag_ctrl" onclick="expand_collapse()" class="s-fc7">展开<i class="fas fa-angle-down"></i></a>
                <script>
                    var is_expand = false;
                    flag_ctrl = document.getElementById('flag_ctrl');
                    // lyric_content = document.getElementById('lyric-content');
                    lyric_ul = document.getElementById('lyric-ul');
                    function expand_collapse() {
                        if (!is_expand){
                            flag_ctrl.innerHTML = "收起<i class=\"fas fa-angle-up\"></i>";
                            lyric_ul.style.overflow = "visible";
                        }else {
                            flag_ctrl.innerHTML = "展开<i class=\"fas fa-angle-down\"></i>";
                            lyric_ul.style.overflow = "auto";
                        }
                        is_expand = !is_expand;
                    }
                    var is_liked = false;
                    function if_like() {
                        jQuery(document).ready(function ($) {
                            if (is_liked) {
                                $(".fa-heart.far").show();
                                $(".fa-heart.fas").hide();
                            }else {
                                $(".fa-heart.far").hide();
                                $(".fa-heart.fas").show();
                            }
                            is_liked = ! is_liked;
                        });
                    }
                </script>
        </div>
    </main>
</body>
</html>