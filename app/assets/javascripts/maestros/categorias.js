function update_estatus(idcategoria, estatus){
    var request = $.ajax({
                            url: '/categorias/update_estatus',
                            method: "POST",
                            data: { idcategoria: idcategoria, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
    };

  function eliminar(idcategoria){
    var request = $.ajax({
                            url: '/categorias/eliminar',
                            method: "POST",
                            data: { idcategoria: idcategoria},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  }


  function validar(categoria, idcategoria){

      $(categoria).validate({
                                    doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                                    errorElement: 'span', //default input error message container
                                    errorClass: 'msj-error', // default input error message class
                                    rules: {
                                      "categoria[categoria]":{
                                          remote: {
                                              url: "/validar_categoria_update?idcategoria="+ idcategoria ,
                                              type: "post"
                                            },
                                          required:true,
                                          
                                      },

                                      "categoria[descripcion]":{
                                         
                                          required:true,
                                      },
  
                                    },
                                    messages:{
                                      "categoria[categoria]":{
                                        required:"Indica la categoría.",
                                        remote:"Ya existe la misma categoría."
                                      },
                                       "categoria[descripcion]":{
                                         
                                          required:"Indica la descripción.",
                                          
                                      },
                                               
                                    },

                                     errorPlacement: function (error, element) { // render error placement for each input type
                                                     error.insertAfter(element); // for other inputs, just perform default behavior
                                                  },
                                  });

  };

  function update(categoria, idcategoria, nombre, descripcion){

    if ($(categoria).valid()) {
          var nombreval = $(nombre).val();
          var descripcionval = $(descripcion).val();
          var request = $.ajax({
                                url: '/categorias/update',
                                method: "POST",
                                data: { idcategoria: idcategoria, 
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

function cancelar(modal, idcategoria, nombre, descripcion){
  $(modal).closeModal();
   var request = $.ajax({
                          url: '/categorias/consultar_categoria',
                          method: "POST",
                          data: { idcategoria: idcategoria},
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