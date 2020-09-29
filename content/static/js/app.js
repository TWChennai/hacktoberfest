function smoothScroll() {
    $('a[href*="#"]:not([data-smooth="false"])').click(function () {
        'use strict';

        $('html, body').animate({
            scrollTop: $($(this).attr('href')).offset().top
        }, 500);

        return true;
    });
}


function sendToGa(category, action, label) {
    ga('send', 'event', category, action, label);
}

function clickTracking() {
    const edition = $('#edition-name').text();
    let clickText;
    $( "a" ).click(function() {
        clickText = $(this).attr('data-event-label') || $(this).text();
        sendToGa(edition, $(this).attr('href'), clickText);
    });
}

$(document).ready(function() {
    smoothScroll();
    clickTracking();
});
