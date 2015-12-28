  function update_estatus(rol, estatus){
     var request = $.ajax({
                            url: '/roles/update_estatus',
                            method: "POST",
                            data: { idRol: rol, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  };

  function eliminar(idrol){
    var request = $.ajax({
                            url: '/roles/eliminar',
                            method: "POST",
                            data: { idrol: idrol},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  };

  function validar(rol, idrol){

        $(rol).validate({
                          doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                          errorElement: 'span', //default input error message container
                          errorClass: 'msj-error', // default input error message class
                          focusInvalid: false, // do not focus the last invalid input
                          rules: {
                            "rol[nombre]":{
                              required:true,
                                remote: {
                                    url: "/validar_rol_update?idrol="+ idrol ,
                                    type: "post"
                                  },
                            },
                          },
                          messages:{
                            "rol[nombre]":{
                              required:"Indica el nombre",
                              remote:"Ya existe un rol con este nombre."
                            },
                          },

                         errorPlacement: function (error, element) { // render error placement for each input type
                                         error.insertAfter(element); // for other inputs, just perform default behavior
                                        },
                        });
  };

  function update(rol, idrol, nombre, acceso){

    if ($(rol).valid()) {
       var nombreval = $(nombre).val();
       var accesoval = $(acceso).prop("checked");
       var request = $.ajax({
                              url: '/roles/update',
                              method: "POST",
                              data: { idRol: idrol, nombre: nombreval, acceso: accesoval},
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

  function cancelar(modal,idrol, nombre, acceso){
    $(modal).closeModal();
    var request = $.ajax({
                          url: '/roles/consultar_rol',
                          method: "POST",
                          data: { idrol: idrol},
                                  dataType: "JSON",
                                  success: function( data ) {

                                    var nombreval = data.nombre ;  

                                    var accesoval = data.acceso_administrable          
                                    $(nombre).val(nombreval);

                                    $(acceso).val(nombreval);
                                    
                                    $('.input-field > label').attr("class", 'active');

                                    $(nombre).removeClass('msj-error');
                                    
                                    $(nombre).removeClass('valid');                  
                                    
                                    $(acceso).removeClass('msj-error');
                                    
                                    $(acceso).removeClass('valid');                  
                                    
                                    $( "span.msj-error" ).remove();

                                 }
                              });   
  };  