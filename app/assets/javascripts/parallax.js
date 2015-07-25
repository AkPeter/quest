/**
 * Created by petr on 23.07.15.
 */

$(window).bind('scroll',function(e){
    parallaxScroll();
});

function parallaxScroll(){
    var scrolled = $(window).scrollTop();
    $('#bg-img').css('top',(0-(scrolled*.45))+'px');
}
