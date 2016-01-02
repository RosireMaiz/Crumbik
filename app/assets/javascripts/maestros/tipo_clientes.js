function update_estatus(id_tipo, estatus){
    var request = $.ajax({
                            url: '/tipo_clientes/update_estatus',
                            method: "POST",
                            data: { id_tipo_cliente: id_tipo, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
    };

  function eliminar(id_tipo_cliente){
    var request = $.ajax({
                            url: '/tipo_clientes/eliminar',
                            method: "POST",
                            data: { id_tipo_cliente: id_tipo_cliente},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  }


  function validar(tipo_cliente, id_tipo_cliente){

      $(tipo_cliente).validate({
                                    doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                                    errorElement: 'span', //default input error message container
                                    errorClass: 'msj-error', // default input error message class
                                    rules: {
                                      "tipo_cliente[nombre]":{
                                          remote: {
                                              url: "/validar_tipo_cliente_update?id_tipo_cliente="+ id_tipo_cliente ,
                                              type: "post"
                                            },
                                          required:true,
                                          
                                      },

                                      "tipo_cliente[descripcion]":{
                                         
                                          required:true,
                                      },
  
                                    },
                                    messages:{
                                      "tipo_cliente[nombre]":{
                                        required:"Indica el nombre.",
                                        remote:"Ya existe el mismo tipo."
                                      },
                                       "tipo_cliente[descripcion]":{
                                         
                                          required:"Indica la descripción.",
                                          
                                      },
                                               
                                    },

                                     errorPlacement: function (error, element) { // render error placement for each input type
                                                     error.insertAfter(element); // for other inputs, just perform default behavior
                                                  },
                                  });

  };

  function update(tipo_cliente, id_tipo_cliente, nombre, descripcion){

    if ($(tipo_cliente).valid()) {
          var nombreval = $(nombre).val();
          var descripcionval = $(descripcion).val();
          var request = $.ajax({
                                url: '/tipo_clientes/update',
                                method: "POST",
                                data: { id_tipo_cliente: id_tipo_cliente, 
                                        nombre: nombreval,
                                        descripcion: descripcionval
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

function cancelar(modal, id_tipo_cliente, nombre, descripcion){
  $(modal).closeModal();
   var request = $.ajax({
                          url: '/tipo_clientes/consultar_tipo_cliente',
                          method: "POST",
                          data: { id_tipo_cliente: id_tipo_cliente},
                          dataType: "JSON",
                          success: function( data ) {

                                    var nombreval = data.nombre ;

                                    var descripcionval = data.descripcion ;
                                               
                                    $(nombre).val(nombreval);

                                    $(descripcion).val(descripcionval);
                                   
                                    $('.input-field > label').attr("class", 'active');

                                    $(nombre).removeClass('msj-error');
                                    
                                    $(nombre).removeClass('valid');  

                                    $(descripcion).removeClass('msj-error');
                                    
                                    $(descripcion).removeClass('valid');                
                                   
                                    $( "span.msj-error" ).remove();

                                   }
                         });   
      };  