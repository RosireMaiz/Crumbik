  var colorNota = "white";
  $('#btnGuardar').on('click', function(){
    if ($("#formNew").valid()) {
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
    }
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

function cancelar(modal, idnota, titulo, contenido){
  $(modal).closeModal();
   var request = $.ajax({
                          url: '/notas/cancelar',
                          method: "POST",
                          data: { idnota: idnota},
                          dataType: "JSON",
                          success: function( data ) {
 
                                    var tituloval = data.titulo ;
                                    var contenidoval = data.contenido ;
                                    var colorval = data.color ;
                                               
                                    $(titulo).val(tituloval);
                                    $(contenido).val(contenidoval);                                   
                                    $('.input-field > label').attr("class", 'active');

                                    $(titulo).removeClass('msj-error');
                                    $(titulo).removeClass('valid');  

                                    $(contenido).removeClass('msj-error');
                                    $(contenido).removeClass('valid');
                                    $(modal).css("background-color", colorval);
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

  function validar(nota){

      $(nota).validate({
                        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                        errorElement: 'span', //default input error message container
                        errorClass: 'msj-error', // default input error message class
                        rules: {
                                "nota[titulo]":{
                                    required:true,
                                  },
                                "nota[contenido]":{
                                    required:true,
                                  },
                                },

                                messages:{
                                          "nota[titulo]":{
                                              required:"Indique el titulo.",
                                            },
                                          "nota[contenido]":{
                                              required:"Indique el contenido.",
                                            },      
                                          },

                                     errorPlacement: function (error, element) { // render error placement for each input type
                                                     error.insertAfter(element); // for other inputs, just perform default behavior
                                                  },
                                  });
  };

function limpiar(){
  $('#tituloNota').val("");
  $('#contenido').val("");
  colorNota = white;
  $("#modalNew").css("background-color", colorNota);
};
