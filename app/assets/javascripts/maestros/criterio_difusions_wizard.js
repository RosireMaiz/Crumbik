$(document).ready(function(){
    $('#form .alert-danger').hide();
    $('#form .alert-success').hide();
    $('#form_wizard_1 .alert-danger').hide();
    $('#form_wizard_1 .alert-success').hide();
    $('#form_wizard_1').find('.button-previous').hide();
    $('#form_wizard_1 .button-submit').hide();
    $('#form_wizard_1 .confirmacion').hide();
    $("#form-subconsulta").hide();
    $("#form-consulta").show();
    $("#form-personalizada").hide();
    $("#sentencia_wizard").hide();
    $("#where_subconsulta").hide();
    $("#where_personalizada").hide();
    var tabla = $("#select_tabla").val();
    var column_referencia = $("#select_column").val();

    var column_parametro = $("#select_column_parameter").val();

    //Subconsulta
    var operador = $("#select_operador").val();
    var tabla_subconsulta = $("#select_tabla_subconsulta").val();
    var column_base = $("#select_column_base").val();
    var column_referencia_subconsulta = $("#select_column_subconsulta").val();
    var column_parametro_subconsulta = $("#select_column_parameter_subconsulta").val();

    $("#select_column_table").html(column_referencia);
    $("#from_table").html(tabla);

    $("#where_column_parametro").html(column_parametro);

    //Subconsulta
    $("#where_column_base").html(column_base);
    $("#operador_where").html(operador);
    $("#select_columna_subconsulta").html(column_referencia_subconsulta);
    $("#from_tabla_subconsulta").html(tabla_subconsulta);
    $("#where_column_parametro_subconsulta").html(column_parametro_subconsulta);


    //PErsonalizada
    var personalizada = $("#criterio_difusion_where").val();
    $("#where_column_parametro_personalizada").html(personalizada);

    $("#consulta-basica, #subconsulta, #personalizada").click(function(){
        if($(this).attr("id") == "consulta-basica"){
          $("#form-subconsulta").hide();
          $("#form-consulta").show();
          $("#where_subconsulta").hide();
          $("#where_consulta").show();
          $("#form-personalizada").hide();
          $("#where_personalizada").hide();
        }else if($(this).attr("id") == "subconsulta"){
          $("#form-consulta").hide();
          $("#form-subconsulta").show();
          $("#where_subconsulta").show();
          $("#where_consulta").hide();
          $("#form-personalizada").hide();
          $("#where_personalizada").hide();
        }else{
          $("#form-consulta").hide();
          $("#form-subconsulta").hide();
          $("#where_subconsulta").hide();
          $("#where_personalizada").show();
          $("#where_consulta").hide();
          $("#form-personalizada").show();
        }
    });

    $(".tab-pane").on("change","#select_tabla",
      function(){
        var name_table = $(this).val();
        var request = $.ajax({
                                url: '/update_columns',
                                method: "POST",
                                data: { table: name_table },
                                        dataType: "JSON",
                                success: function( data ) {
                                  var $selectDropdown =  $("#select_column").empty().html(' ');
                                  var $selectDropdownParameter =  $("#select_column_parameter").empty().html(' ');
                                  var $selectDropdownBase =  $("#select_column_base").empty().html(' ');
                                  for (var i = 0 ; i < data.length ; i++) {
                                      var value =data[i].name;
                                      $selectDropdown.append(
                                      $("<option></option>")
                                          .attr("value",value)
                                          .text(value)
                                      );
                                       $selectDropdownParameter.append(
                                      $("<option></option>")
                                          .attr("value",value)
                                          .text(value)
                                      );
                                        $selectDropdownBase.append(
                                      $("<option></option>")
                                          .attr("value",value)
                                          .text(value)
                                      );
                                    
                                  }
                                  $("#select_column").material_select();
                                  $("#select_column_parameter").material_select();
                                  $("#select_column_base").material_select();
                                  tabla = $("#select_tabla").val();
                                  column_referencia = $("#select_column").val();
                                  
                                  column_parametro = $("#select_column_parameter").val();
                                  column_base = $("#select_column_base").val();
                                  $("#select_column_table").html(column_referencia);
                                  $("#from_table").html(tabla);
                                  $("#where_column_parametro").html(column_parametro);
                                  $("#where_column_base").html(column_base);
                                }
                          });   
  });

  $(".tab-pane").on("change","#select_column",
      function(){
           column_referencia = $("#select_column").val();             
          $("#select_column_table").html(column_referencia);
  });
    
  $(".tab-pane").on("change","#select_column_parameter",
      function(){
        column_parametro = $("#select_column_parameter").val();
        $("#where_column_parametro").html(column_parametro);
  }); 

  $(".tab-pane").on("change","#select_column_base",
      function(){
        column_base = $("#select_column_base").val();
        $("#where_column_base").html(column_base);
  }); 
    $(".tab-pane").on("change","#criterio_difusion_where",
      function(){
        personalizada = $("#criterio_difusion_where").val();
        $("#where_column_parametro_personalizada").html(personalizada);
  }); 


    $(".tab-pane").on("change","#select_tabla_subconsulta",
      function(){
        var name_table = $(this).val();
        var request = $.ajax({
                                url: '/update_columns',
                                method: "POST",
                                data: { table: name_table },
                                        dataType: "JSON",
                                success: function( data ) {
                                  var $selectDropdownSubconsulta =  $("#select_column_subconsulta").empty().html(' ');
                                  var $selectDropdownParameterSubconsulta =  $("#select_column_parameter_subconsulta").empty().html(' ');
                                  
                                  for (var i = 0 ; i < data.length ; i++) {
                                      var value =data[i].name;
                                      $selectDropdownSubconsulta.append(
                                      $("<option></option>")
                                          .attr("value",value)
                                          .text(value)
                                      );
                                       $selectDropdownParameterSubconsulta.append(
                                      $("<option></option>")
                                          .attr("value",value)
                                          .text(value)
                                      );                                    
                                  }
                                  $("#select_column_subconsulta").material_select();
                                  $("#select_column_parameter_subconsulta").material_select();

                                  operador = $("#select_operador").val();
                                  tabla_subconsulta = $("#select_tabla_subconsulta").val();
                                  column_base = $("#select_column_base").val();
                                  column_referencia_subconsulta = $("#select_column_subconsulta").val();
                                  column_parametro_subconsulta = $("#select_column_parameter_subconsulta").val();

                                  $("#where_column_base").html(column_base);
                                  $("#operador_where").html(operador);
                                  $("#select_columna_subconsulta").html(column_referencia_subconsulta);
                                  $("#from_tabla_subconsulta").html(tabla_subconsulta);
                                  $("#where_column_parametro_subconsulta").html(column_parametro_subconsulta);
                                }
                          });   
           
  });


  $(".tab-pane").on("change","#select_operador",
      function(){
          operador = $("#select_operador").val();            
          $("#operador_where").html(operador);
  });

  $(".tab-pane").on("change","#select_column_subconsulta",
      function(){
          column_referencia_subconsulta = $("#select_column_subconsulta").val();            
          $("#select_columna_subconsulta").html(column_referencia_subconsulta);
  });

  $(".tab-pane").on("change","#select_column_parameter_subconsulta",
      function(){
          column_parametro_subconsulta = $("#select_column_parameter_subconsulta").val();
          $("#where_column_parametro_subconsulta").html(column_parametro_subconsulta);  
  });

    var FormWizard = function () {
        return {
            //main function to initiate the module
            init: function () {
                if (!jQuery().bootstrapWizard) {
                    return;
                }

                var form = $('#submit_form');
                var error = $('.alert-danger', form);
                var success = $('.alert-success', form);
                // success.hide();
                // error.hide();
                form.validate({
                    doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                    errorElement: 'span', //default input error message container
                    errorClass: 'msj-error', // default input error message class
                    focusInvalid: false, // do not focus the last invalid input
                   rules: {
                    "criterio_difusion[nombre]":{
                      required:true,
                        remote: {
                            url: "/validar_criterio_difusion",
                            type: "post"
                          }
                    },
                    "criterio_difusion[descripcion]":{
                      required:true,
                    },
                    "criterio_difusion[where]":{
                      required:true,
                    },
                  },
                  messages:{
                    "criterio_difusion[nombre]":{
                      required:"Indica el nombre",
                      remote:"Ya existe un Criterio de Difusión con este nombre."
                    },
                    "criterio_difusion[descripcion]":{
                      required:"Indica la descripción",  
                    },
                    "criterio_difusion[where]":{
                      required:"Indica el criterio personalizado.",
                    },
                  },

                    errorPlacement: function (error, element) { // render error placement for each input type
                        if (element.attr("name") == "gender") { // for uniform radio buttons, insert the after the given container
                            error.insertAfter("#form_gender_error");
                        } else if (element.attr("name") == "payment[]") { // for uniform checkboxes, insert the after the given container
                            error.insertAfter("#form_payment_error");
                        } else {
                            error.insertAfter(element); // for other inputs, just perform default behavior
                        }
                    },

                    invalidHandler: function (event, validator) { //display error alert on form submit   
                        success.hide();
                        error.show();
                        $('html,body').animate({
                            scrollTop: $(".steps").offset().top-60
                        }, 'slow');
                    },

                    highlight: function (element) { // hightlight error inputs
                        $(element)
                            .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
                    },

                    unhighlight: function (element) { // revert the change done by hightlight
                        $(element)
                            .closest('.form-group').removeClass('has-error'); // set error class to the control group
                    },

                    success: function (label) {
                        if (label.attr("for") == "gender" || label.attr("for") == "payment[]") { // for checkboxes and radio buttons, no need to show OK icon
                            label
                                .closest('.form-group').removeClass('has-error').addClass('has-success');
                            label.remove(); // remove error label here
                        } else { // display success icon for other inputs
                            label
                                .addClass('valid') // mark the current input as valid and display OK icon
                            .closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
                        }
                    }

                });

                var displayConfirm = function() {
                    $('#tab4 .form-control-static', form).each(function(){
                        var input = $('[name="'+$(this).attr("data-display")+'"]', form);
                        if (input.is(":radio")) {
                            input = $('[name="'+$(this).attr("data-display")+'"]:checked', form);
                        }
                        if (input.is(":text") || input.is("textarea")) {
                            if(input.attr("id") == "usuario_organizacion_attributes_subdominio")
                                $(this).html(input.val()+".crumbik.com");
                            else
                                $(this).html(input.val());
                        } else if (input.is("select")) {
                            $(this).html(input.find('option:selected').text());
                        } else if (input.is(":radio") && input.is(":checked")) {
                            $(this).html(input.attr("data-title"));
                        } else if ($(this).attr("data-display") == 'payment[]') {
                            var payment = [];
                            $('[name="payment[]"]:checked', form).each(function(){ 
                                payment.push($(this).attr('data-title'));
                            });
                            $(this).html(payment.join("<br>"));
                        }
                    });
                }

                var handleTitle = function(tab, navigation, index) {
                    var total = navigation.find('li').length;
                    var current = index + 1;
                    // set wizard title
                    $('.step-title', $('#form_wizard_1')).text('Paso ' + (index + 1) + ' de ' + total);
                    // set done steps
                    jQuery('li', $('#form_wizard_1')).removeClass("done");
                    var li_list = navigation.find('li');
                    for (var i = 0; i < index; i++) {
                        jQuery(li_list[i]).addClass("done");
                    }

                    if (current == 1) {
                        $('#form_wizard_1').find('.button-previous').hide();
                            $("#sentencia_wizard").hide();
                    } else {
                        $('#form_wizard_1').find('.button-previous').show();
                        $("#sentencia_wizard").show();
                    }

                    if (current >= total) {
                        $('#form_wizard_1').find('.button-next').hide();
                        $('#form_wizard_1').find('.button-submit').show();
                        $('#form_wizard_1').find('.confirmacion').show();
                        displayConfirm();
                    } else {
                        $('#form_wizard_1').find('.button-next').show();
                        $('#form_wizard_1').find('.button-submit').hide();
                        $('#form_wizard_1').find('.confirmacion').hide();
                    }
                    $('html,body').animate({
                        scrollTop: $(".steps").offset().top-60
                    }, 'slow');
                }
                // default form wizard
                $('#form_wizard_1').bootstrapWizard({
                    'nextSelector': '.button-next',
                    'previousSelector': '.button-previous',
                    onTabClick: function (tab, navigation, index, clickedIndex) {
                        return false;
                    },
                    onNext: function (tab, navigation, index) {
                        success.hide();
                        error.hide();

                        if (form.valid() == false) {
                            return false;
                        }

                        handleTitle(tab, navigation, index);
                    },
                    onPrevious: function (tab, navigation, index) {
                        success.hide();
                        error.hide();

                        handleTitle(tab, navigation, index);
                    },
                    onTabShow: function (tab, navigation, index) {
                        var total = navigation.find('li').length;
                        var current = index + 1;
                        var $percent = (current / total) * 100;
                        $('#form_wizard_1').find('#progress-bar-wizard').css({
                            width: $percent + '%'
                        });
                    }
                });

                $(".button-submit").click(function(evt){
                    evt.preventDefault();
                    success.show();
                    error.hide();
                    tipo_consulta = $("input:radio[name=tipo_consulta]:checked").val() +" #{operador_parametro} #{valor_parametro}";
                    if (tipo_consulta == 1) {
                        $("#criterio_difusion_campo_comparacion").val(column_parametro);
                         $("#criterio_difusion_tipo_consulta").val("basica");
                        
                    } else if (tipo_consulta == 2) {
                      var where_concat = column_base + " " + operador + " (SELECT " 
                      + column_referencia_subconsulta + " FROM " + tabla_subconsulta + " WHERE "
                      + column_parametro_subconsulta + " #{operador_parametro} #{valor_parametro} )"
                       $("#criterio_difusion_campo_comparacion").val(where_concat);
                         $("#criterio_difusion_tipo_consulta").val("subconsulta");
                    } else {
                      $("#criterio_difusion_campo_comparacion").val($("#criterio_difusion_where").val() + " #{operador_parametro} #{valor_parametro}");
                      $("#criterio_difusion_tipo_consulta").val("personalizada");
                    };
                    var data = $(form).serializeArray();

                    var action = $(form).attr("action");
                    
                                        
                    //procesar pago
                    var html = "<div><div class='progress'><div class='indeterminate'></div></div>"+
                                "</div><h5>Espera mientras creamos el Criterio de Difusión.</h5>"
                    $("#notificacion").html(html);
                    $('#notificacion').openModal();

                    $.post(action, 
                        data,
                        function(response){
                            if(response["codigo"] == 200){
                                var html = "<div><i class='large mdi-action-done  "+
                                "light-blue-text darken-2'></i></div><h5>Tu criterio "+
                                "han sido creado exitosamente</h5>"
                                $("#notificacion").html(html);
                                $('#notificacion').openModal();
                                setTimeout(function(){
                                        window.location.href = response["url"]
                                    }, 1000);
                            }else{
                                var html = "<div><i class='large mdi-content-clear  "+
                                "red-text darken-2'></i></div><h5>Ha ocurrido un error al momento "+
                                "de procesar tu suscripción</h5><p class='lead'>"+
                                response["errores"]+"</p>"
                                $("#notificacion").html(html);
                            }
                            
                        },
                        "json"
                    );
                    return false;
                });

            }

        };

    }();
    FormWizard.init();
});