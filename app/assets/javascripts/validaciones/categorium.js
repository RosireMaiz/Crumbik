jQuery(function ($) {
	$(document).ready(function(){
		var idcategoria = $('#form').data('edit'); 
		var formCategoria = $('#add_categoria');
		var errorCategoria= $('.alert-danger', formCategoria);
		var successCategoria= $('.alert-success', formCategoria);
		formCategoria.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not foc+us the last invalid input
								rules: {
									"categorium[nombre]":{
										required:true,									    
									},
									
									"categorium[descripcion]":{
										required:true,
									},
								},

								messages:{
									"categorium[nombre]":{
										required:"Indique el nombre de la Categoria.",
									},
									
									"categorium[descripcion]":{
										required:"Indique la descripción de la Categoria.",
									},
								},

								 errorPlacement: function (error, element) { // render error placement for each input type
					                     		if (element.attr("name") == "cliente[sexo]") { // for uniform checkboxes, insert the after the given container
				                            		error.insertAfter("#div_cliente_sexo");
					                    		} else {
					                            	error.insertAfter(element); // for other inputs, just perform default behavior
					                        	}           
					                    },

					             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
					                        successCategoria.hide();
					                        errorCategoria.show();
					                        $('html,body').animate({ 
					                            scrollTop: $(".steps").offset().top-350
					                        }, 'slow');
					                    },

					         	 highlight: function (element) { // hightlight error inputs
					                        $(element)
					                            .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
					                    },

					         	 unhighlight: function (element) { // revert the change done by hightlight
					                        $(element)
					                            .closest('.form-group').removeClass('has-error'); // set error class to the control group
					                    },

					             success: function (label) {
					                            label.addClass('valid') // mark the current input as valid and display OK icon
					                            .closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
					                    }
							});
	
		var formEditCategoria = $('#edit_categoria');
		var errorEditCategoria = $('.alert-danger', formEditCategoria);
		var successEditCategoria = $('.alert-success', formEditCategoria);
		formEditCategoria.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"categorium[nombre]":{
										required:true,									    
									},
									
									"categorium[descripcion]":{
										required:true,
									},
								},
								messages:{
									"categorium[nombre]":{
										required:"Indique el nombre de la Categoria.",
									},
									
									"categorium[descripcion]":{
										required:"Indique la descripción de la Categoria.",
									},
								},

					             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
					                        successEditCategoria.hide();
					                        errorEditCategoria.show();
					                        $('html,body').animate({ 
					                            scrollTop: $(".steps").offset().top-350
					                        }, 'slow');
					                    },

					         	 highlight: function (element) { // hightlight error inputs
					                        $(element)
					                            .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
					                    },

					         	 unhighlight: function (element) { // revert the change done by hightlight
					                        $(element)
					                            .closest('.form-group').removeClass('has-error'); // set error class to the control group
					                    },

					             success: function (label) {
					                            label.addClass('valid') // mark the current input as valid and display OK icon
					                            .closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
					                    }
							});

		  $('#add_categoria').submit(function(event){
       
      var fields = $("input[name='categorium[variable_psicografica_ids][]']").serializeArray();
        if (fields.length == 1) 
        { 
           $("#categoria_variable_ids-error").removeClass("hidden");
            event.preventDefault();
           return false;
        } 
        else 
        { 
            $("#categoria_variable_ids-error").addClass("hidden");
        }
      });

    $("input[name='categorium[variable_psicografica_ids][]']").on('change', function (){
        var fields = $("input[name='categorium[variable_psicografica_ids][]']").serializeArray();
        if (fields.length == 1) 
        { 
            $("#categoria_variable_ids-error").removeClass("hidden");
        } 
        else 
        { 
            $("#categoria_variable_ids-error").addClass("hidden");
        }
    });


	});
});	

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
                                      "categoria[nombre]":{
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
                                      "categoria[nombre]":{
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



