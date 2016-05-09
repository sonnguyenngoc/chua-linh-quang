$(document).ready(function () {
    
    // events when changing anything in filter box
    $(".v_centered .sort_select select").change(function() {
        $(this).parents("form").submit();
    });
});