 $.validator.addMethod("valueNotEquals", function(value, element, arg){
  return arg != value;
 }, "Debes escoger una opción.");

//Codigo para agregar meses
Date.isLeapYear = function (year) { 
    return (((year % 4 === 0) && (year % 100 !== 0)) || (year % 400 === 0)); 
};

Date.getDaysInMonth = function (year, month) {
    return [31, (Date.isLeapYear(year) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];
};

Date.prototype.isLeapYear = function () { 
    return Date.isLeapYear(this.getFullYear()); 
};

Date.prototype.getDaysInMonth = function () { 
    return Date.getDaysInMonth(this.getFullYear(), this.getMonth());
};

Date.prototype.addMonths = function (value) {
    var n = this.getDate();
    this.setDate(1);
    this.setMonth(this.getMonth() + value);
    this.setDate(Math.min(n, this.getDaysInMonth()));
    return this;
};

$(document).ready(function(){
    $('#form .alert-danger').hide();
    $('#form .alert-success').hide();
    $('#form_wizard_1 .alert-danger').hide();
    $('#form_wizard_1 .alert-success').hide();
    $('#form_wizard_1').find('.button-previous').hide();
    $('#form_wizard_1 .button-submit').hide();
    $('#form_wizard_1 .confirmacion').hide();
    $("#campos-paypal").hide();
    $("#campos-tarjeta-credito").show();
    $("#form-payment").hide();
    $("#form-tarjeta").show();
    $("#usuario_organizacion_attributes_contratos_attributes_0_pagos_attributes_0_modo_pago_id").attr('value',1);

    $("#contratos_pagos_attributes_0_modo_pago_id").attr('value',1);

    var idtipo = $("#usuario_organizacion_attributes_tipo_organizacion_id").val();
    var href_tipo_organizacion = "#detalle_tipo_organizacion_" + idtipo;
    $('#basic_addo_tipo_organizacion').attr("href", href_tipo_organizacion);

    var idplan = $("#usuario_organizacion_attributes_contratos_attributes_0_plan_id").val();
    if(idplan != null){
      var href_plan = "#detalle_plan_" + idplan;
      $('#basic_addo_plan').attr("href", href_plan);
      var request = $.ajax({
                                  url: '/planes/consultar_plan',
                                  method: "POST",
                                  data: { idplan: idplan },
                                          dataType: "JSON",
                                  success: function( data ) {

                                            var mes = data.meses;
                                            var monto = data.monto; 
                                            var f = new Date().addMonths(parseInt(mes));
                                            var date = f.getFullYear()+"-"+("0"+f.getMonth()+1).slice(-2)
                                                 +"-" + ("0"+f.getDate()).slice(-2);
                                            $("#usuario_organizacion_attributes_contratos_attributes_0_fecha_vencimiento").attr('value',date);
                                            $("#usuario_organizacion_attributes_contratos_attributes_0_fecha_vencimiento").val(date);
                                            
                                            $("#usuario_organizacion_attributes_contratos_attributes_0_pagos_attributes_0_monto").attr('value',monto);
                                            $("#usuario_organizacion_attributes_contratos_attributes_0_pagos_attributes_0_monto").val(monto);
                                            $("#msj-frecuencia").html("El plan se renovará el "+("0"+f.getDate()).slice(-2)+"/"+("0"+(f.getMonth()+1)).slice(-2) +"/"+f.getFullYear());
                                            $("#monto_plan").html(monto);
                                            $("#monto_display").html(monto);
                                            $('#fecha_display').html(("0"+f.getDate()).slice(-2)+"/"+("0"+(f.getMonth()+1)).slice(-2) +"/"+f.getFullYear());
                                          }
                            }); 
    }
      
    var idplanpago = $("#contrato_plan_id").val();
    if(idplanpago != null){
      var href_plan = "#detalle_plan_" + idplanpago;
      $('#basic_addo_plan').attr("href", href_plan);
      var request = $.ajax({
                                  url: '/planes/consultar_plan',
                                  method: "POST",
                                  data: { idplan: idplanpago },
                                          dataType: "JSON",
                                  success: function( data ) {

                                            var mes = data.meses;
                                            var monto = data.monto; 
                                            var f = new Date().addMonths(parseInt(mes));
                                            var date = f.getFullYear()+"-"+("0"+f.getMonth()+1).slice(-2)
                                                 +"-" + ("0"+f.getDate()).slice(-2);
                                            $("#contrato_fecha_vencimiento").attr('value',date);
                                            $("#contrato_fecha_vencimiento").val(date);
                                            
                                            $("#contrato_pagos_attributes_0_monto").attr('value',monto);
                                            $("#contrato_pagos_attributes_0_monto").val(monto);
                                            $("#msj-frecuencia").html("El plan se renovará el "+("0"+f.getDate()).slice(-2)+"/"+("0"+(f.getMonth()+1)).slice(-2) +"/"+f.getFullYear());
                                            $("#monto_plan").html(monto);
                                            $("#monto_display").html(monto);
                                            $('#fecha_display').html(("0"+f.getDate()).slice(-2)+"/"+("0"+(f.getMonth()+1)).slice(-2) +"/"+f.getFullYear());
                                          }
                            }); 
    }

     $('#usuario_password').pwstrength({
         common: {
             minChar:8,
             usernameField:"#usuario_email",
             viewports: {
                 progress: ".pwstrength_viewport_progress"
             }
         },
         ui: {
             showVerdictsInsideProgressBar: false,
             showStatus:false,
             verdicts: ["Seguridad: Débil", "Seguridad: Normal", "Seguridad: Medio",
                 "Seguridad: Fuerte", "Seguridad: Muy fuerte"]
         },
         rules:{
             scores:{
              wordNotEmail: -80,
               wordLength: -8,
               wordSimilarToUsername: -30,
               wordSequences: -20,
               wordTwoCharacterClasses: 2,
              wordRepetitions: -50,
               wordLowercase: 1,
               wordUppercase: 3,
               wordOneNumber: 8,
               wordThreeNumbers: 15,
               wordOneSpecialChar: 5,
              wordTwoSpecialChar: 10,
               wordUpperLowerCombo: 8,
               wordLetterNumberCombo: 2,
               wordLetterNumberCharCombo: 2
             }
         }
     });
 
    $("#agregar-red-social a").click(function(){
    	var source = this;
    	if($("#lista-redes-sociales").hasClass("vacia"))
    		$("#lista-redes-sociales").removeClass("vacia").addClass("llena");
    	var class_a = $(source).attr("class"),
    		class_i = $(source).children().first().attr("class"),
             id_a = $(source).attr("id");
    	 $("#lista-redes-sociales").append("<li><div class='input-group'><span class='input-group-addon  red-social-add "+
                    class_a+"'><i class='"+class_i+"'></i></span>"+
                    "<input id='usuario_perfil_attributes_"+id_a+"' name='usuario[perfil_attributes]["+id_a+"]' type='text' class='form-control'></div></li>");
    });

    $("#agregar-red-social-usuario a").click(function(){
       var source = this;
        if($("#lista-redes-sociales").hasClass("vacia"))
            $("#lista-redes-sociales").removeClass("vacia").addClass("llena");
        var class_a = $(source).attr("class"),
            class_i = $(source).children().first().attr("class"),
            style_a = $(source).attr("style"),
             id_a = $(source).attr("id");
         $("#lista-redes-sociales").append("<li><div class='input-group'><span class='input-group-addon  red-social-add "+
                    class_a+"' style = \" "+
                    style_a+" \"'><i class='"+class_i+"'></i></span>"+
                    "<input id='usuario_red_social_attributes_nuevo_"+id_a+"' name='usuario[red_social_attributes][nueva]["+id_a+"]' type='text' class='form-control'></div></li>");
    });



    //Mostrar el mensaje de cuando se vence el contrato actual
    $(".tab-pane").on("change","#usuario_organizacion_attributes_contratos_attributes_0_plan_id",
        function(){
          // alert("elegiste otro plan" + $(this).val());
            var id_plan = $(this).val();
            var href = "#detalle_plan_" + id_plan;
            $('#basic_addo_plan').attr("href", href);

            var request = $.ajax({
                                  url: '/planes/consultar_plan',
                                  method: "POST",
                                  data: { idplan: id_plan },
                                          dataType: "JSON",
                                  success: function( data ) {
                                            var monto = data.monto;
                                            var meses = data.meses;
                                            var f = new Date().addMonths(parseInt(meses));
                                             var date = f.getFullYear()+"-"+("0"+(f.getMonth()+1)).slice(-2)
                                                 +"-" + ("0"+f.getDate()).slice(-2);
                                            $("#usuario_organizacion_attributes_contratos_attributes_0_fecha_vencimiento").attr('value',date);
                                            $("#usuario_organizacion_attributes_contratos_attributes_0_fecha_vencimiento").val(date);
                                            $("#usuario_organizacion_attributes_contratos_attributes_0_pago_atributes_0_monto").attr('value',monto);
                                            $("#msj-frecuencia").html("El plan se renovará el "+("0"+f.getDate()).slice(-2)+"/"+("0"+(f.getMonth()+1)).slice(-2) +"/"+f.getFullYear());
                                            $("#monto_plan").html(monto);
                                            $("#monto_display").html(monto);
                                            $('#fecha_display').html(("0"+f.getDate()).slice(-2)+"/"+("0"+(f.getMonth()+1)).slice(-2) +"/"+f.getFullYear());
                                          }
                            });   
             
    });

     $(".tab-pane").on("change","#contrato_plan_id",
        function(){
          // alert("elegiste otro plan" + $(this).val());
            var id_plan = $(this).val();
            var href = "#detalle_plan_" + id_plan;
            $('#basic_addo_plan').attr("href", href);

            var request = $.ajax({
                                  url: '/planes/consultar_plan',
                                  method: "POST",
                                  data: { idplan: id_plan },
                                          dataType: "JSON",
                                  success: function( data ) {
                                            var monto = data.monto;
                                            var meses = data.meses;
                                            var f = new Date().addMonths(parseInt(meses));
                                             var date = f.getFullYear()+"-"+("0"+(f.getMonth()+1)).slice(-2)
                                                 +"-" + ("0"+f.getDate()).slice(-2);
                                            $("#contrato_fecha_vencimiento").attr('value',date);
                                            $("#contrato_fecha_vencimiento").val(date);
                                            $("#contrato_pago_atributes_0_monto").attr('value',monto);
                                            $("#msj-frecuencia").html("El plan se renovará el "+("0"+f.getDate()).slice(-2)+"/"+("0"+(f.getMonth()+1)).slice(-2) +"/"+f.getFullYear());
                                            $("#monto_plan").html(monto);
                                            $("#monto_display").html(monto);
                                            $('#fecha_display').html(("0"+f.getDate()).slice(-2)+"/"+("0"+(f.getMonth()+1)).slice(-2) +"/"+f.getFullYear());
                                          }
                            });   
             
    });

    //Modificar el href del detalle de tipo de organizacion

        //Mostrar el mensaje de cuando se vence el contrato actual
    $(".tab-pane").on("change","#usuario_organizacion_attributes_tipo_organizacion_id",
        function(){

            var id_tipo = $(this).val();
            var href = "#detalle_tipo_organizacion_" + id_tipo;
            $('#basic_addo_tipo_organizacion').attr("href", href);

    });


    //Mostrar campos para pagar con la tarjeta de crédito o paypal
    $("#usar_tarjeta, #usar_paypal").click(function(){
        if($(this).attr("id") == "usar_tarjeta"){
            $("#campos-paypal").hide();
            $("#form-payment").hide();
            $("#campos-tarjeta-credito").show();
            $("#form-tarjeta").show();
            $("#usuario_organizacion_attributes_contratos_attributes_0_pagos_attributes_0_modo_pago_id").attr('value',1);
        }else{
            $("#campos-tarjeta-credito").hide();
            $("#form-tarjeta").hide();
            $("#form-payment").show();
            $("#campos-paypal").show();
            $("#usuario_organizacion_attributes_contratos_attributes_0_pagos_atrributes_0_modo_pago_id").attr('value',2);
        }
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
                        //cuenta
                        "usuario[perfil_attributes][nombres]":"required",
                        "usuario[perfil_attributes][apellidos]":"required",
                        "usuario[username]":{
                            required:true,              
                        },
                        "usuario[email]": {
                            required: true,
                            email: true,
                            remote: {
                                url: "/validar_email",
                                type: "post"
                            }
                        },
                        "usuario[password]":{
                            required:true,
                            minlength:8,
                            maxlength:30
                        },
                        "usuario[password_confirmation]":{
                            required:true,
                            minlength:8,
                            maxlength:30,
                            equalTo: "#usuario_password"
                        },
                        //organizacion
                        "usuario[organizacion_attributes][nombre]": "required",
                        "usuario[organizacion_attributes][subdominio]": {
                            required: true,
                            remote:{
                                url: "/validar_subdominio",
                                type:"post"
                            }
                        },
                        //pagos
                        "tarjeta[nombre]": {
                            required: true
                        },
                        "tarjeta[numero]": {
                          required: true,
                          creditcard: true
                        },
                        "tarjeta[cvc]": {
                            digits: true,
                            required: true,
                            minlength: 3,
                            maxlength: 4
                        },
                        "tarjeta[fecha_expiracion]": {
                            required: true
                        
                        }// ,
                        // 'payment[]': {
                        //     required: true,
                        //     minlength: 1
                        // }
                    },

                    messages: { // custom messages for radio buttons and checkboxes
                        //cuenta
                        "usuario[perfil_attributes][nombres]": "Debes indicar tu nombre",
                        "usuario[perfil_attributes][apellidos]": "Debes indicar tu apellido",
                        "usuario[username]":{
                            required:"Indica tu username",
                        },
                        "usuario[email]": {
                            required: "Debes indicar tu email.",
                            email: "Este no parece ser un correo válido.",
                            remote:"Ya existe un usuario registrado con este email."
                        },
                        "usuario[password]": {
                            minlength: "La contraseña debe tener un mínimo de 8 caracteres.",
                            required: "Debes indicar una contraseña",
                            remote:"Ya existe una cuenta asociada a este correo"
                        },
                        "usuario[password_confirmation]": {
                            minlength: "La contraseña debe tener un mínimo de 8 caracteres.",
                            required: "Debes indicar de nuevo tu contraseña.",
                            equalTo: "Las contraseñas no coinciden."
                        },
                        //organizacion
                        "usuario[organizacion_attributes][nombre]": {
                            required: "Debes indicar el nombre de la organización."
                        },
                        "usuario[organizacion_attributes][subdominio]": {
                            required: "indica el subdominio de la organización.",
                            remote: "Este subdominio ya está en uso."
                        },
                        //payment
                        "tarjeta[nombre]": {
                            required: "Indica el nombre del dueño de la tarjeta."
                        },
                        "tarjeta[numero]": {
                            minlength: "El número de la tarjeta de crédito debe ser de 16.",
                            maxlength: "El número de la tarjeta de crédito debe ser de 16.",
                            required: "Debes indicar el número de la tarjeta de crédito.",
                            creditcard: "Debe ingresar el número de tarjeta de crédito válida. "
                        },
                        "tarjeta[cvc]": {
                            digits: "Solo se permiten números.",
                            required: "Debes indicar el CVC de la tarjeta.",
                            minlength: "El CVC tiene un mínimo de 3 caracteres.",
                            maxlength: "El CVC tiene un máximo de 4 caracteres."
                        },
                        "tarjeta[fecha_expiracion]": {
                            required: "Debes indicar la fecha de expiración de la tarjeta."
                        }
                        // 'payment[]': {
                        //     required: "Por favor selecciona al menos una opción",
                        //     minlength: jQuery.validator.format("Por favor seleccione una opción")
                        // }
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
                    } else {
                        $('#form_wizard_1').find('.button-previous').show();
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
                    var data = $(form).serializeArray();

                    var action = $(form).attr("action");
                    console.log(data);
                    //procesar pago
                    data[12]["tarjeta[nombre]"] = "";
                    data[14]["tarjeta[cvc]"] = "";
                    data[15]["tarjeta[fecha_expiracion]"]  = "";
                    var html = "<div><div class='progress'><div class='indeterminate'></div></div>"+
                                "</div><h5>Espera mientras creamos y configuramos tu cuenta.</h5>"
                    $("#notificacion").html(html);
                    $('#notificacion').openModal();

                    $.post(action, 
                        data,
                        function(response){
                            if(response["codigo"] == 200){
                                var html = "<div><i class='large mdi-action-done  "+
                                "light-blue-text darken-2'></i></div><h5>Tu cuenta y "+
                                "subdominio han sido creados</h5><p class='lead'>Gracias"+
                                " por elegirnos, serás redirigido a tu subdominio en unos segundos.</p>"
                                $("#notificacion").html(html);
                                $('#notificacion').openModal();
                                setTimeout(function(){
                                        window.location.href=response["url"]
                                    }, 8000);
                            }else{
                                var html = "<div><i class='large mdi-content-clear  "+
                                "red-text darken-2'></i></div><h5>Ha ocurrido un error al momento "+
                                "de procesar tu suscripción</h5><p class='lead'>"+
                                response["errores"]+"</p>"
                                $("#notificacion").html(html);
                                //$('#notificacion').openModal();
                            }
                            
                        },
                        "json"
                    );
                    return false;
                });

                   $(".confirmacion").click(function(evt){
                    evt.preventDefault();
                    success.show();
                    error.hide();
                    var data = $(form).serializeArray();

                    var action = $(form).attr("action");
                    console.log(data);
                    //procesar pago
                   //data[12]["tarjeta[nombre]"] = "";
                    //data[14]["tarjeta[cvc]"] = "";
   //                 data[15]["tarjeta[fecha_expiracion]"]  = "";
                    var html = "<div><div class='progress'><div class='indeterminate'></div></div>"+
                                "</div><h5>Espera mientras validamos tu pago.</h5>"
                    $("#notificacion").html(html);
                    $('#notificacion').openModal();

                    $.post(action, 
                        data,
                        function(response){
                            if(response["codigo"] == 200){
                                var html = "<div><i class='large mdi-action-done  "+
                                "light-blue-text darken-2'></i></div><h5>Tu pago "+
                                "se ha realizado exitosamente</h5><p class='lead'>Gracias"+
                                " por elegirnos.</p>"
                                $("#notificacion").html(html);
                                $('#notificacion').openModal();
                               setTimeout(function(){
                                        window.location.href=response["url"]
                                    }, 8000);
                            }else{
                                var html = "<div><i class='large mdi-content-clear  "+
                                "red-text darken-2'></i></div><h5>Ha ocurrido un error al momento "+
                                "de procesar tu suscripción</h5><p class='lead'>"+
                                response["errores"]+"</p>"
                                $("#notificacion").html(html);
                                //$('#notificacion').openModal();
                            }
                            
                        },
                        "json"
                    );
                    return false;
                });
                //apply validation on select2 dropdown value change, this only needed for chosen dropdown integration.
                // $('#country_list', form).change(function () {
                //     form.validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
                // });
            }

        };

    }();
    FormWizard.init();
});