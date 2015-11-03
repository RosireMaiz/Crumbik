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

  function validar(redsocial, idredsocial){

    $(redsocial).validate({
              ignore: "",
                  doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                  errorElement: 'span', //default input error message container
                  errorClass: 'msj-error', // default input error message class
                  focusInvalid: false, // do not focus the last invalid input
            rules: {
                  "red_social[nombre]":{
                    required:true,
                      remote: {
                          url: "/validar_red_social_update?idredsocial="+ idredsocial ,
                          type: "post"
                        },
                  },
                  "red_social[icono]":"required",
                },

            messages:{
                "red_social[nombre]":{
                  
                  required:"Indica el nombre.",
                  remote:"Ya existe una red social con este nombre.",
                
                },
                "red_social[icono]":{
                  
                  required:"Seleccione el icono de la red social.",
                
                },  
              },

          errorPlacement: function (error, element) { // render error placement for each input type
                                if (element.attr("name") == "red_social[icono]") { // for uniform checkboxes, insert the after the given container
                                    error.insertAfter(diverror);
                                } else {
                                    error.insertAfter(element); // for other inputs, just perform default behavior
                                }
                            },
        });
  };

  function update(redsocial, idredsocial, nombre, icono, diverror){

    var valid = $(redsocial).valid();
    if (valid) {
          var nombreval = $(nombre).val();
          var iconoval = $(icono).val();
          var request = $.ajax({
                                url: '/redes_sociales/update',
                                method: "POST",
                                data: { idredsocial: idredsocial, 
                                        nombre: nombreval, 
                                        icono: iconoval },
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

  function cancelar(modal, idredsocial, nombre, icono, buttonicon){
    $(modal).closeModal();
    var request = $.ajax({
                           url: '/redes_sociales/consultar_red_social',
                           method: "POST",
                           data: { idredsocial: idredsocial},
                           dataType: "JSON",
                           success: function( data ) {

                                    var nombreval = data.nombre ;
                                    var iconoval = data.icono;            
                                    $(nombre).val(nombreval);
                                    $(icono).val(iconoval);
                                    $(buttonicon).attr("class", iconoval)
                                    $('.input-field > label').attr("class", 'active');

                                    $(nombre).removeClass('msj-error');
                                    $(icono).removeClass('msj-error');
                                    $(nombre).removeClass('valid');                  
                                    $(icono).removeClass('valid');
                                    $( "span.msj-error" ).remove();


                                    }
                            });   
  };  


  function cambio(icono, input_icono, icono_error){

        var iconoval = $(icono).attr('class');      
        if (iconoval == "fa fa-") {
            $(input_icono).val("");
            $(icono_error).show();
		} else {
            $(input_icono).val(iconoval);
            $(icono_error).hide();
		};
	};