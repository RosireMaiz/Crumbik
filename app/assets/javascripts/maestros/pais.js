  function update_estatus(idpais, estatus){
    var request = $.ajax({
                            url: '/paises/update_estatus',
                            method: "POST",
                            data: { idpais: idpais, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  }

  function eliminar(idpais){
    var request = $.ajax({
                            url: '/paises/eliminar',
                            method: "POST",
                            data: { idpais: idpais},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  }

  function validar(pais, idpais){

      $(pais).validate({
                          doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                          errorElement: 'span', //default input error message container
                          errorClass: 'msj-error', // default input error message class
                          focusInvalid: false, // do not focus the last invalid input
                          rules: {
                            "pais[nombre]":{
                              required:true,
                                remote: {
                                    url: "/validar_pais_update?idpais="+ idpais ,
                                    type: "post"
                                  },
                            },
                            "pais[iso]":"required",
                          },
                          messages:{
                            "pais[nombre]":{
                              required:"Indica el nombre del país.",
                              remote:"Ya existe un país con este nombre."
                            },
                            "pais[iso]":  {
                                         required: "Debe indicar el iso del país.",
                                    },           
                          },

                           errorPlacement: function (error, element) { // render error placement for each input type
                                           error.insertAfter(element); // for other inputs, just perform default behavior
                                        },
                      });
  }

  function update(pais, idpais, nombre, iso){
    if ($(pais).valid()) {
          var nombreval = $(nombre).val();
          var isoval = $(iso).val();
          var request = $.ajax({
                                url: '/paises/update',
                                method: "POST",
                                data: { idpais: idpais, 
                                        nombre: nombreval, 
                                        iso: isoval },
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

  function cancelar(modal, idpais, nombre, iso){
    $(modal).closeModal();
    var request = $.ajax({
                          url: '/paises/consultar_pais',
                          method: "POST",
                          data: { idpais: idpais},
                                  dataType: "JSON",
                                  success: function( data ) {

                                            var nombreval = data.nombre ;
                                            var isoval = data.iso;            
                                            $(nombre).val(nombreval);
                                            $(iso).val(isoval);
                                            $('.input-field > label').attr("class", 'active');

                                            $(nombre).removeClass('msj-error');
                                            $(iso).removeClass('msj-error');
                                            $(nombre).removeClass('valid');                  
                                            $(iso).removeClass('valid');
                                            $( "span.msj-error" ).remove();

                                          }
                          });   
  };  