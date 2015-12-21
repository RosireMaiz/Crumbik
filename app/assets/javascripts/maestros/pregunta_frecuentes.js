function update_estatus(idpregunta, estatus){
    var request = $.ajax({
                            url: '/pregunta_frecuentes/update_estatus',
                            method: "POST",
                            data: { idpregunta: idpregunta, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
    };

  function eliminar(idpregunta){
    var request = $.ajax({
                            url: '/pregunta_frecuentes/eliminar',
                            method: "POST",
                            data: { idpregunta: idpregunta},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  }


  function validar(pregunta, idpregunta){

      $(pregunta).validate({
                                    doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                                    errorElement: 'span', //default input error message container
                                    errorClass: 'msj-error', // default input error message class
                                    rules: {
                                      "pregunta[pregunta]":{
                                          remote: {
                                              url: "/validar_pregunta_frecuente_update?idpregunta="+ idpregunta ,
                                              type: "post"
                                            },
                                          required:true,
                                          
                                      },
                                      
                                    },
                                    messages:{
                                      "pregunta_frecuente[pregunta]":{
                                        required:"Indica la pregunta.",
                                        remote:"Ya existe la misma pregunta."
                                      },
                                               
                                    },

                                     errorPlacement: function (error, element) { // render error placement for each input type
                                                     error.insertAfter(element); // for other inputs, just perform default behavior
                                                  },
                                  });

  };

  function update(pregunta_frecuente, idpregunta, pregunta){

    if ($(pregunta_frecuente).valid()) {
          var preguntaval = $(pregunta).val();
          var request = $.ajax({
                                url: '/pregunta_frecuentes/update',
                                method: "POST",
                                data: { idpregunta: idpregunta, 
                                        pregunta: preguntaval
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

function cancelar(modal, idpregunta, pregunta){
  $(modal).closeModal();
   var request = $.ajax({
                          url: '/pregunta_frecuentes/consultar_pregunta_frecuente',
                          method: "POST",
                          data: { idpregunta: idpregunta},
                          dataType: "JSON",
                          success: function( data ) {

                                    var preguntaval = data.pregunta ;
                                               
                                    $(pregunta).val(preguntaval);
                                   
                                    $('.input-field > label').attr("class", 'active');

                                    $(pregunta).removeClass('msj-error');
                                    
                                    $(pregunta).removeClass('valid');                  
                                   
                                    $( "span.msj-error" ).remove();

                                   }
                         });   
      };  