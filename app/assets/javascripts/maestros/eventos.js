$('#btnGuardar').on('click', function(){
    validar("#formNew");
    if ($("#formNew").valid()) {
      var request = $.ajax({
                  url: '/eventos/crear_evento',
                      method: "POST",
                      data: {titulo: $('#titulo_evento').val(),
                          descripcion: $('#descripcion').val(),
                          inicio: $('#inicio').val(),
                          fin: $('#fin').val(),
                        },
                      dataType: "JSON"
                  });   
                  request.done(function( data ) {
                    location.reload(); 
                  });
                     
                  request.fail(function( jqXHR, textStatus ) {
                      alert( "Request failed: " + textStatus );
                    }); 
    }
});

function validar(evento){
      $(evento).validate({
                        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                        errorElement: 'span', //default input error message container
                        errorClass: 'msj-error', // default input error message class
                        rules: {
                                "evento[titulo_evento]":{
                                    required:true,
                                  },
                                "evento[descripcion]":{
                                    required:true,
                                  },
                                "evento[inicio]":{
                                    required:true,
                                  },
                                "evento[fin]":{
                                    required:true,
                                  },
                                },

                                messages:{
                                          "evento[titulo_evento]":{
                                              required:"Indique el titulo.",
                                            },
                                          "evento[descripcion]":{
                                              required:"Indique la descripción.",
                                            },
                                          "evento[inicio]":{
                                              required:"Indique la fecha de inicio del evento.",
                                            },
                                          "evento[fin]":{
                                              required:"Indique la fecha de culminación del evento.",
                                            },      
                                          },

                                     errorPlacement: function (error, element) { // render error placement for each input type
                                                     error.insertAfter(element); // for other inputs, just perform default behavior
                                                  },
                                  });
  };

  function cancelar(modal, idevento, titulo, descripcion, inicio, fin){
  $(modal).closeModal();
    var request = $.ajax({
                          url: '/eventos/cancelar',
                          method: "POST",
                          data: { idevento: idevento},
                          dataType: "JSON",
                          success: function( data ) {

                                    var tituloval = data.title ;
                                    var descripcionval = data.description ;
                                    var inicioval = data.inicio ;
                                    var finval = data.fin ;

                                    $(titulo).val(tituloval);
                                    $(descripcion).val(descripcionval);
                                    $(inicio).val(inicioval); 
                                    $(fin).val(finval);                                  
                                    $('.input-field > label').attr("class", 'active');

                                    $(titulo).removeClass('msj-error');
                                    $(titulo).removeClass('valid');  

                                    $(descripcion).removeClass('msj-error');
                                    $(descripcion).removeClass('valid');

                                    $(inicio).removeClass('msj-error');
                                    $(inicio).removeClass('valid');

                                    $(fin).removeClass('msj-error');
                                    $(fin).removeClass('valid');

                                    $( "span.msj-error" ).remove();
                                   }
                         });   
      };

function eliminar(idevento){
    var request = $.ajax({
                            url: '/eventos/eliminar',
                            method: "POST",
                            data: { idevento: idevento},
                            dataType: "JSON"
                          });
        request.done(function( data ) {
                                        location.reload(); 
                                      });       
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  };

  function update(evento, idevento, titulo, descripcion, inicio, fin){
    validar(evento);
    if ($(evento).valid()) {
          var tituloval = $(titulo).val();
          var descripcionval = $(descripcion).val();
          var inicioval = $(inicio).val();
          var finval = $(fin).val();
          var request = $.ajax({
                                url: '/eventos/update',
                                method: "POST",
                                data: { idevento: idevento,
                                        titulo: tituloval,
                                        descripcion: descripcionval,
                                        inicio: inicioval,
                                        fin: finval
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

function limpiar(){
  $('#titulo_evento').val("");
  $('#descripcion').val("");
  $('#inicio').val("");
  $('#fin').val("");
    $('.input-field > label').attr("class", 'active');

  $('#titulo_evento').removeClass('msj-error');
  $('#titulo_evento').removeClass('valid');  

  $('#descripcion').removeClass('msj-error');
  $('#descripcion').removeClass('valid');

  $('#inicio').removeClass('msj-error');
  $('#inicio').removeClass('valid');

  $('#fin').removeClass('msj-error');
  $('#fin').removeClass('valid');

  $( "span.msj-error" ).remove();
};