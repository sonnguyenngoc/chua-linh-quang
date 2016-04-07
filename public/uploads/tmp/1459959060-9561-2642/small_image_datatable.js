function updateCheckAll(input) {
    if(input.is(":checked")) {
        input.parents(".table").find(".list_checkbox").prop('checked', true)
    } else {
        input.parents(".table").find(".list_checkbox").prop('checked', false)
    }
    $.uniform.update()
}

$(function() {


    // Table setup
    // ------------------------------

    //// Setting datatable defaults
    //$.extend( $.fn.dataTable.defaults, {
    //    autoWidth: false,
    //    columnDefs: [{ 
    //        orderable: false,
    //        targets: [ 4 ]
    //    }],
    //    dom: '<"datatable-header"fl><"datatable-scroll-wrap"t><"datatable-footer"ip>',
    //    language: {
    //        search: '<span>Search:</span> _INPUT_',
    //        lengthMenu: '<span>Show:</span> _MENU_ <a title="Refresh Table" class="refresh-datatable" href="#refresh"><i class="icon-reload-alt"></i></a>',
    //        paginate: { 'first': 'First', 'last': 'Last', 'next': '&rarr;', 'previous': '&larr;' }
    //    },
    //    drawCallback: function () {
    //        $(this).find('tbody tr').slice(-3).find('.dropdown, .btn-group').addClass('dropup');
    //    },
    //    preDrawCallback: function() {
    //        $(this).find('tbody tr').slice(-3).find('.dropdown, .btn-group').removeClass('dropup');
    //    }
    //});


    // Basic initialization
    $('.datatable-header-basic').each(function() {
        var item = $(this)
        var orders = []
        var sort_col = 0
        var sort_order = "asc"
        $(this).find("th").each(function(index) {
          if(!$(this).hasClass("sortable")) {
            orders.push(index)
          }
          if($(this).hasClass("default-sort")) {
            sort_col = index
          }
          if($(this).hasClass("desc")) {
            sort_order = "desc"
          }
        })
        
        //auto filter
        item.find("select").change(function() {
            item.dataTable().fnFilter();
        });
        item.find("input").keyup(function() {
            item.dataTable().fnFilter();
        });
        
        // Check all event
        $(this).find("input.check_all").change(function() {
            updateCheckAll($(this))
        })        
        
        var table_basic = $(this).DataTable({
            fixedHeader: true,
            autoWidth: false,
            "order": [[ sort_col, sort_order ]],
            "columnDefs": [ { "targets": orders, "orderable": false } ],
            dom: '<"datatable-header"fl><"datatable-scroll-wrap"t><"datatable-footer"ip>',
            language: {
                search: '<span>Search:</span> _INPUT_',
                lengthMenu: '<span>Show:</span> _MENU_  <a title="Refresh Table" class="refresh-datatable" href="#refresh"><i class="icon-reload-alt"></i></a>',
                paginate: { 'first': 'First', 'last': 'Last', 'next': '&rarr;', 'previous': '&larr;' }
            },
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": item.attr("data-url"),
                "data": function ( d ) {
                    item.parents(".datatable-form").serializeArray().forEach(function(entry) {
                        if(entry.value!="") {
                            d[entry.name] = entry.value
                        }
                    });
                    
                }
            },
            "initComplete": function(settings, json) {
                $(this).find('tbody tr').slice(-3).find('.dropdown, .btn-group').addClass('dropup');
                
                // Add actions to datatable
                var las = $(this).parents(".table_list").find(".list_actions")
                $(this).parents(".table_list").find(".datatable-header").prepend(las.clone());
                $(this).parents(".table_list").find(".datatable-header .list_actions select").select2({dropdownAutoWidth: 'true', minimumResultsForSearch: 10});
                las.remove()
             },
            drawCallback: function () {
                // remove check all checked
                $(this).find("input.check_all").prop('checked', false)
                $.uniform.update()
                $(this).find("input.check_all").trigger("change")
                
                $(this).find('[data-popup=tooltip]').tooltip()
            },
            preDrawCallback: function() {
                $(this).find('tbody tr').slice(-3).find('.dropdown, .btn-group').removeClass('dropup');
            }
        });
    });
    
    // list_actions
    $(document).on('click', '.list_actions .actions li a', function(e) {
        e.preventDefault()
        
        var ids = $(this).parents("form").find("input[name='ids[]']:checked").map(function() {
            return $(this).val()
        }).get().join(",")
        var url = $(this).attr("href")
        var table = $("table")
        
        if (ids == "") {
            alert("Please select at least one item!");
        } else {
            $.ajax({
                url : url+"?ids="+ids,
                type: "GET",
                success:function(data, textStatus, jqXHR)
                {
                    modernAlert(data)
                    if(table.length) {
                        table.dataTable().fnDraw(true);
                    } else {
                        location.reload(); 
                    }
                }
            })
        }
    });
    
    
    // AJAX sourced data    
    $('.datatable-ajax').each (function(num) {
        var item = $(this)
        var box = $(this).parents(".datatable_box")
        var filters = box.find(".datatable_filter")
        var orders = []
        var num = 0
        var item_id = ""
        $(this).find("th").each(function() {
          if(!$(this).hasClass("sortable")) {
            orders.push(num)
          }
          num++
        })
        if (typeof(item.attr("item-id")) != "undefined") {
            item_id = item.attr("item-id")
        }
        //xhr[num] = item.on('preXhr.dt', function ( e, settings, data ) {
        //        if(xhr[num].dataTableSettings[0].jqXHR != null) {
        //            xhr[num].dataTableSettings[0].jqXHR.abort()
        //        }
        //    } ).dataTable({
        
        item.dataTable({
            "order": [],
            "columnDefs": [ { "targets": orders, "orderable": false } ],
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": item.attr("url"),
                "data": function ( d ) {
                    d.filters = filters.serialize()
                }
            },
            "language": {
                "url": URL+"assets/js/datatable_vietnamese.json"
            },
            "initComplete": function(settings, json) {
                // External table additions
                // ------------------------------
            
                // Add placeholder to the datatable filter option
                $('.dataTables_filter input[type=search]').attr('placeholder','Gõ từ khóa để tìm kiếm...');
            
            
                // Enable Select2 select for the length option
                $('.dataTables_length select').select2({
                    minimumResultsForSearch: "-1"
                });
            }            
        });
    })

    // External table additions
    // ------------------------------

    // Add placeholder to the datatable filter option
    $('.dataTables_filter input[type=search]').attr('placeholder','Type keyword to search...');

    // Enable Select2 select for the length option
    $('.dataTables_length select').select2({
        minimumResultsForSearch: Infinity,
        width: 'auto'
    });
    
    
    // Refresh datatable
    $(document).on('click', '.refresh-datatable', function() {
        var box = $(this).parents('.dataTables_wrapper');
        box.find("table input").val("");
        box.find("table select").val("").change();
        box.find("table").dataTable().fnFilter();
    });
});