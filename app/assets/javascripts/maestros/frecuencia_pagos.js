 function update_estatus(idfrecuenciapago, estatus){
    var request = $.ajax({
                            url: '/frecuencia_pagos/update_estatus',
                            method: "POST",
                            data: { idfrecuenciapago: idfrecuenciapago, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
    };

  function eliminar(idfrecuenciapago){
    var request = $.ajax({
                            url: '/frecuencia_pagos/eliminar',
                            method: "POST",
                            data: { idfrecuenciapago: idfrecuenciapago},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  }


  function validar(frecuenciapago, idfrecuenciapago){

      $(frecuenciapago).validate({
                                    doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                                    errorElement: 'span', //default input error message container
                                    errorClass: 'msj-error', // default input error message class
                                    rules: {
                                      "frecuencia_pago[nombre]":{
                                          remote: {
                                              url: "/validar_frecuencia_pago_update?idfrecuenciapago="+ idfrecuenciapago ,
                                              type: "post"
                                            },
                                          required:true,
                                          
                                      },
                                      "frecuencia_pago[meses]":"required",
                                    },
                                    messages:{
                                      "frecuencia_pago[nombre]":{
                                        required:"Indica el nombre de la frecuencia de pago.",
                                        remote:"Ya existe una frecuencia de pago con este nombre."
                                      },
                                      "frecuencia_pago[meses]":  {
                                          required: "Debe indicar la cantidad de meses.",
                                        },           
                                    },

                                     errorPlacement: function (error, element) { // render error placement for each input type
                                                     error.insertAfter(element); // for other inputs, just perform default behavior
                                                  },
                                  });

  };

  function update(frecuenciapago, idfrecuenciapago, nombre, meses){

    if ($(frecuenciapago).valid()) {
          var nombreval = $(nombre).val();
          var mesesval = $(meses).val();
          var request = $.ajax({
                                url: '/frecuencia_pagos/update',
                                method: "POST",
                                data: { idfrecuenciapago: idfrecuenciapago, 
                                        nombre: nombreval, 
                                        meses: mesesval },
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

function cancelar(modal, idfrecuenciapago, nombre, meses){
  $(modal).closeModal();
   var request = $.ajax({
                          url: '/frecuencia_pagos/consultar_frecuencia_pago',
                          method: "POST",
                          data: { idfrecuenciapago: idfrecuenciapago},
                          dataType: "JSON",
                          success: function( data ) {

                                    var nombreval = data.nombre ;
                                    var mesesval = data.meses;            
                                    $(nombre).val(nombreval);
                                    $(meses).val(mesesval);
                                    $('.input-field > label').attr("class", 'active');

                                    $(nombre).removeClass('msj-error');
                                    $(meses).removeClass('msj-error');
                                    $(nombre).removeClass('valid');                  
                                    $(meses).removeClass('valid');
                                    $( "span.msj-error" ).remove();

                                   }
                         });   
      };  