function update_estatus(idtipoorganizacion, estatus){
    var request = $.ajax({
                            url: '/tipo_organizacions/update_estatus',
                            method: "POST",
                            data: { id_tipo_organizacion: idtipoorganizacion, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
    };

  function eliminar(idtipoorganizacion){
    var request = $.ajax({
                            url: '/tipo_organizacions/eliminar',
                            method: "POST",
                            data: { id_tipo_organizacion: idtipoorganizacion},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  }


  function validar(tipoorganizacion, idtipoorganizacion){

      $(tipoorganizacion).validate({
                                    doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                                    errorElement: 'span', //default input error message container
                                    errorClass: 'msj-error', // default input error message class
                                    rules: {
                                      "tipo_organizacion[nombre]":{
                                          remote: {
                                              url: "/validar_tipo_organizacion_update?id_tipo_organizacion="+ idtipoorganizacion ,
                                              type: "post"
                                            },
                                          required:true,
                                          
                                      },
                                      "tipo_organizacion[descripcion]":{
                                           required:true,
                                      },
                                      
                                    },
                                    messages:{
                                      "tipo_organizacion[nombre]":{
                                        required:"Indica el nombre de la tipo de organización.",
                                        remote:"Ya existe una tipo de organización con este nombre."
                                      },
                                      "tipo_organizacion[descripcion]":{
                                        required:"Indica la descripción del tipo de organización.",
                                      },         
                                    },

                                     errorPlacement: function (error, element) { // render error placement for each input type
                                                     error.insertAfter(element); // for other inputs, just perform default behavior
                                                  },
                                  });

  };

  function update(tipoorganizacion, idtipoorganizacion, nombre, descripcion){

    if ($(tipoorganizacion).valid()) {
          var nombreval = $(nombre).val();
          var descripcionval = $(descripcion).val();
          var request = $.ajax({
                                url: '/tipo_organizacions/update',
                                method: "POST",
                                data: { id_tipo_organizacion: idtipoorganizacion, 
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

function cancelar(modal, idtipoorganizacion, nombre, descripcion){
  $(modal).closeModal();
   var request = $.ajax({
                          url: '/tipo_organizacions/consultar_tipo_organizacion',
                          method: "POST",
                          data: { id_tipo_organizacion: idtipoorganizacion},
                          dataType: "JSON",
                          success: function( data ) {

                                    var nombreval = data.nombre ;
                                    var descripcionval = data.descripcion;
                                               
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