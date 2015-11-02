    function update_estatus(servicio, estatus){
     var request = $.ajax({
                            url: '/servicios/update_estatus',
                            method: "POST",
                            data: { idServicio: servicio, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
    }

    function update(servicio, idservicio, nombre, descripcion){

      $(servicio).validate({
              doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                    errorElement: 'span', //default input error message container
                    errorClass: 'msj-error', // default input error message class
                    focusInvalid: false, // do not focus the last invalid input
      rules: {
        "servicio[nombre]":{
          required:true,
            remote: {
                url: "/validar_servicio_update?idservicio="+ idservicio ,
                type: "post"
              }
        },
        "servicio[descripcion]":"required",
      },
      messages:{
        "servicio[nombre]":{
          required:"Indica el nombre",
          remote:"Ya existe un servicio con este nombre."
        },
        "servicio[descripcion]":  {
                     required: "Debe indicar la descripción.",
                },           
      },

       errorPlacement: function (error, element) { // render error placement for each input type
                       error.insertAfter(element); // for other inputs, just perform default behavior
                    },
    });

    if ($(servicio).valid()) {
          var nombreval = $(nombre).val();
          var descripcionval = $(descripcion).val();
          var request = $.ajax({
                                url: '/servicios/update',
                                method: "POST",
                                data: { idServicio: idservicio, 
                                        nombre: nombreval, 
                                        descripcion: descripcionval },
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

      function cancelar(modal,idservicio, nombre, descripcion){
          $(modal).closeModal();
          var request = $.ajax({
                                url: '/servicios/consultar_servicio',
                                method: "POST",
                                data: { idServicio: idservicio},
                                dataType: "JSON",
                                success: function( data ) {

                                    var nombreval = data.nombre ;
                                    var descripcionval = data.descripcion;            
                                    $(nombre).val(nombreval);
                                    $(descripcion).val(descripcionval);
                                    $('.input-field > label').attr("class", 'active');

                                    $(nombre).removeClass('msj-error');
                                    $(descripcion).removeClass('msj-error');
                                    $(nombre).removeClass('valid');                  
                                    $(descripcion).removeClass('valid');
                                    $( "span.msj-error" ).remove();


                                          }
                              });   
      };  