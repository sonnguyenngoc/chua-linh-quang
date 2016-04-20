$(document).ready(function () {
    
    // events when changing anything in filter box
    $(".filter-box select").change(function() {
        $(this).parents("form").submit();
    });
    $(".filter-box input.date-select").change(function() {
        $(this).parents("form").submit();
    });
    $(".filter-box .keyword_search_button").click(function() {
        $(this).parents("form").submit();
    });
    
    // select2
    $(".select").select2();
});