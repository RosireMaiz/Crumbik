  var colorNota = "white";
    $('#btnGuardar').on('click', function(){
      var request = $.ajax({
                  url: '/notas/crear_nota',
                      method: "POST",
                      data: {titulo: $('#tituloNota').val(),
                          contenido: $('#contenido').val(),
                          color: colorNota,
                        },
                      dataType: "JSON"
                  });   
                  request.done(function( data ) {
                    location.reload(); 
                  });
                     
                  request.fail(function( jqXHR, textStatus ) {
                      alert( "Request failed: " + textStatus );
                    }); 
      });

    function change_color(color_param){
      colorNota = color_param;
      $("#modalNew").css("background-color", colorNota);
    };

    function change_color_edit(color_param, idmodal){
      colorNota = color_param;
      $(idmodal).css("background-color", colorNota);
    };

function update(nota, idnota, titulo, contenido){

    if ($(nota).valid()) {
          var tituloval = $(titulo).val();
          var contenidoval = $(contenido).val();
          var colorval = colorNota;
          var request = $.ajax({
                                url: '/notas/update',
                                method: "POST",
                                data: { idnota: idnota,
                                        titulo: tituloval,
                                        contenido: contenidoval,
                                        color: colorval
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

function cancelar(modal, idnota, titulo, contenido, color){
  $(modal).closeModal();
   var request = $.ajax({
                          url: '/notas/consultar_notas',
                          method: "POST",
                          data: { idnota: idnota},
                          dataType: "JSON",
                          success: function( data ) {
 
                                    var tituloval = data.titulo ;
                                    var contenidoval = data.contenido ;
                                    var colorval = data.color ;
                                               
                                    $(titulo).val(tituloval);
                                    $(contenido).val(contenidoval);
                                    $(color).val(colorval);
                                   
                                    $('.input-field > label').attr("class", 'active');

                                    $(titulo).removeClass('msj-error');
                                    $(titulo).removeClass('valid');  

                                    $(contenido).removeClass('msj-error');
                                    $(contenido).removeClass('valid');

                                    $(color).removeClass('msj-error');
                                    $(color).removeClass('valid');               
                                   
                                    $( "span.msj-error" ).remove();

                                   }
                         });   
      };

  function eliminar(idnota){
    var request = $.ajax({
                            url: '/notas/eliminar',
                            method: "POST",
                            data: { idnota: idnota},
                            dataType: "JSON"
                          });
        request.done(function( data ) {
                                        location.reload(); 
                                      });       
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  };