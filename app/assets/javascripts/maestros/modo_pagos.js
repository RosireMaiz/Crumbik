function update_estatus(idmodopago, estatus){
    var request = $.ajax({
                            url: '/modo_pagos/update_estatus',
                            method: "POST",
                            data: { idmodopago: idmodopago, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
    };

  function eliminar(idmodopago){
    var request = $.ajax({
                            url: '/modo_pagos/eliminar',
                            method: "POST",
                            data: { idmodopago: idmodopago},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  }


  function validar(modopago, idmodopago){

      $(modopago).validate({
                                    doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                                    errorElement: 'span', //default input error message container
                                    errorClass: 'msj-error', // default input error message class
                                    rules: {
                                      "modo_pago[nombre]":{
                                          remote: {
                                              url: "/validar_modo_pago_update?idmodopago="+ idmodopago ,
                                              type: "post"
                                            },
                                          required:true,
                                          
                                      },
                                      
                                    },
                                    messages:{
                                      "modo_pago[nombre]":{
                                        required:"Indica el nombre de la modo de pago.",
                                        remote:"Ya existe una modo de pago con este nombre."
                                      },
                                               
                                    },

                                     errorPlacement: function (error, element) { // render error placement for each input type
                                                     error.insertAfter(element); // for other inputs, just perform default behavior
                                                  },
                                  });

  };

  function update(modopago, idmodopago, nombre){

    if ($(modopago).valid()) {
          var nombreval = $(nombre).val();
          var request = $.ajax({
                                url: '/modo_pagos/update',
                                method: "POST",
                                data: { idmodopago: idmodopago, 
                                        nombre: nombreval
                                      },
                                dataType: "JSON",
                                success: function( data ) {
                                    location.reload(); 
                                }

                              });   
            request.fail(function( jqXHR, textStatus ) {
                                                        alert( "Request failed: " + textStatus );
                                                       });
    }

  };

function cancelar(modal, idmodopago, nombre){
  $(modal).closeModal();
   var request = $.ajax({
                          url: '/modo_pagos/consultar_modo_pago',
                          method: "POST",
                          data: { idmodopago: idmodopago},
                          dataType: "JSON",
                          success: function( data ) {

                                    var nombreval = data.nombre ;
                                               
                                    $(nombre).val(nombreval);
                                   
                                    $('.input-field > label').attr("class", 'active');

                                    $(nombre).removeClass('msj-error');
                                    
                                    $(nombre).removeClass('valid');                  
                                   
                                    $( "span.msj-error" ).remove();

                                   }
                         });   
      };  