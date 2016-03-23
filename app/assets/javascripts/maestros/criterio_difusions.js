jQuery(function ($) {
  $(document).ready(function(){
    var formCriterioDifusion= $('#add_criterio_difusion');
    var errorCriterioDifusion = $('.alert-danger', formCriterioDifusion);
    var successCriterioDifusion = $('.alert-success', formCriterioDifusion);
    formCriterioDifusion.validate({
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
                  },
                  messages:{
                    "criterio_difusion[nombre]":{
                      required:"Indica el nombre",
                      remote:"Ya existe un Criterio de Difusión con este nombre."
                    },
                  },

                   errorPlacement: function (error, element) { // render error placement for each input type
                                 
                                        error.insertAfter(element); // for other inputs, just performRol default behavior
                                    
                                },

                         invalidHandler: function (event, validator) { //display error alert on formRol submit   
                                    successCriterioDifusion.hide();
                                    errorCriterioDifusion.show();
                                    $('html,body').animate({
                                        scrollTop: $(".steps").offset().top
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

                                        label
                                            .addClass('valid') // mark the current input as valid and display OK icon
                                        .closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
                                }
                });

  });

}); 
  function eliminar(id_criterio_difusion){
    var request = $.ajax({
                            url: '/criterio_difusions/eliminar',
                            method: "POST",
                            data: { id_criterio_difusion: id_criterio_difusion},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  };

  function validar(criterio_difusion, id_criterio_difusion){
    $(criterio_difusion).validate({
                              doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                              errorElement: 'span', //default input error message container
                              errorClass: 'msj-error', // default input error message class
                              focusInvalid: false, // do not focus the last invalid input
                              rules: {
                                "criterio_difusion[nombre]":{
                                  required:true,
                                    remote: {
                                        url: "/validar_criterio_difusion_update?id_criterio_difusion="+ id_criterio_difusion ,
                                        type: "post"
                                      },
                                },
                                "criterio_difusion[tabla]":{
                                  required: true,
                                },
                                "criterio_difusion[descripcion]":{
                                  required: true,
                                },
                                "criterio_difusion[campo_comparacion]":{
                                  required: true,
                                },

                              },
                              messages:{
                                "criterio_difusion[nombre]":{
                                  required:"Indica el nombre",
                                  remote:"Ya existe un Criterio de Difusión con este nombre."
                                },
                                "criterio_difusion[tabla]":{
                                  required:"Indica la tabla",
                                },
                                "criterio_difusion[descripcion]":{
                                  required:"Indica la descripcion",
                                },
                                "criterio_difusion[campo_comparacion]":{
                                  required:"Indica el campo de comparación",
                                },
                              },

                               errorPlacement: function (error, element) { // render error placement for each input type
                                               error.insertAfter(element); // for other inputs, just perform default behavior
                                              },
                });
  };

  function update(criterio_difusion, id_criterio_difusion, nombre, descripcion, tabla, campo_comparacion){

    if ($(criterio_difusion).valid()) {
       var nombreval = $(nombre).val();
       var descripcionval = $(descripcion).val(); 
       var tablaval = $(tabla).val(); 
       var campocomparacionval = $(campo_comparacion).val();     
       var request = $.ajax({
                              url: '/criterio_difusions/update',
                              method: "POST",
                              data: { id_criterio_difusion: id_criterio_difusion, nombre: nombreval,
                                      descripcion: descripcionval, tabla: tablaval, 
                                      campo_comparacion: campocomparacionval},
                              dataType: "JSON"
                            });

          request.done(function( data ) {
                                           location.reload(); 
                                        });
                       
          request.fail(function( jqXHR, textStatus ) {
                                                      alert( "Request failed: " + textStatus );
                                                     });

      }
  };

  function cancelar(modal,id_criterio_difusion, nombre, descripcion, tabla, campo_comparacion){
    $(modal).closeModal();
    var request = $.ajax({
                            url: '/criterio_difusions/consultar_criterio_difusion',
                            method: "POST",
                            data: { id_criterio_difusion: id_criterio_difusion},
                            dataType: "JSON",
                            success: function( data ) {

                                      var nombreval = data.nombre ; 
                                      var descripcionval = data.descripcion ; 
                                      var tablaval = data.tabla ; 
                                      var campocomparacionval = data.campo_comparacion ;            
                                      $(nombre).val(nombreval);
                                      $(descripcion).val(descripcionval);
                                      $(tabla).val(tablaval);
                                      $(campo_comparacion).val(campocomparacionval);
                                      $('.input-field > label').attr("class", 'active');

                                      $(nombre).removeClass('msj-error');
                                      $(nombre).removeClass('valid');                  
                                      
                                      $(descripcion).removeClass('msj-error');
                                      $(descripcion).removeClass('valid');

                                      $(tabla).removeClass('msj-error');
                                      $(tabla).removeClass('valid');

                                      $(campo_comparacion).removeClass('msj-error');
                                      $(campo_comparacion).removeClass('valid');

                                      $( "span.msj-error" ).remove();

                                    }
                          });   
  };  

function update_estatus(id_criterio_difusion, estatus){
    var request = $.ajax({
                            url: '/criterio_difusions/update_estatus',
                            method: "POST",
                            data: { id_criterio_difusion: id_criterio_difusion, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
    };