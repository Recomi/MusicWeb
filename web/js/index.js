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