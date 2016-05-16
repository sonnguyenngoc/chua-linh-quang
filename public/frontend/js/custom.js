function update_layout() {
    if ($(window).width() > 767) {
        undo_arrange_mobile_layout();
    } else {
        arrange_mobile_layout();
    }
}
function arrange_mobile_layout() {
    //Home page
    $(".home_top_categories").insertAfter( $('.home_main') );
    $(".home_infoblocks").insertAfter( $('.home_main') );
    
    // Other page
    $("main").insertBefore( $('aside') );
}
function undo_arrange_mobile_layout() {
    // Home page
    $(".home_infoblocks").insertBefore( $('.home_main') );
    $(".home_top_categories").insertBefore( $('.home_main_slider') );
    
    // Other page
    $("aside").insertBefore( $('main') );
}

$(document).ready(function () {
    
    // events when changing anything in filter box
    $(".v_centered .sort_select select").change(function() {
        $(this).parents("form").submit();
    });
    
    // events when changing anything in filter box
    $(".v_centered .show_select select").change(function() {
        $(this).parents("form").submit();
    });
    
    // update website layout
    update_layout();
});

$( window ).resize(function () {    
    update_layout();
});