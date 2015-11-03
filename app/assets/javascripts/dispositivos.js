   function eliminar(iddispositivo){
     var request = $.ajax({
                            url: '/dispositivos/eliminar',
                            method: "POST",
                            data: { iddispositivo: iddispositivo},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
    }

    function update(dispositivo, iddispositivo, nombre){

      $(dispositivo).validate({
              doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                    errorElement: 'span', //default input error message container
                    errorClass: 'msj-error', // default input error message class
                    focusInvalid: false, // do not focus the last invalid input
      rules: {
        "dispositivo[nombre]":{
          required:true,
            remote: {
                url: "/validar_dispositivo_update?iddispositivo="+ iddispositivo ,
                type: "post"
              }
        },
      },
      messages:{
        "dispositivo[nombre]":{
          required:"Indica el nombre",
          remote:"Ya existe un dispositivo con este nombre."
        },
      },

       errorPlacement: function (error, element) { // render error placement for each input type
                       error.insertAfter(element); // for other inputs, just perform default behavior
                      },
    });

    if ($(dispositivo).valid()) {
       var nombreval = $(nombre).val();
       var request = $.ajax({
                              url: '/dispositivos/update',
                              method: "POST",
                              data: { iddispositivo: iddispositivo, nombre: nombreval},
                              dataType: "JSON"
                            });

          request.done(function( data ) {
                                           location.reload(); 
                                        });
                       
          request.fail(function( jqXHR, textStatus ) {
                                                      alert( "Request failed: " + textStatus );
                                                     });

      }
    }

      function cancelar(modal,iddispositivo, nombre){
          $(modal).closeModal();
          var request = $.ajax({
                                url: '/dispositivos/consultar_dispositivo',
                                method: "POST",
                                data: { iddispositivo: iddispositivo},
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
