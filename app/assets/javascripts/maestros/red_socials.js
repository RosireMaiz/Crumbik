  function update_estatus(idredsocial, estatus){
     var request = $.ajax({
                            url: '/redes_sociales/update_estatus',
                            method: "POST",
                            data: { idredsocial: idredsocial, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  };

  function eliminar(idredsocial){
    var request = $.ajax({
                            url: '/redes_sociales/eliminar',
                            method: "POST",
                            data: { idredsocial: idredsocial},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  };
