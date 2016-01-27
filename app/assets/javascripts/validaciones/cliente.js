jQuery(function ($) {
	$(document).ready(function(){
		var idcliente = $('#form').data('edit'); 
		var formCliente = $('#add_cliente');
		var errorCliente= $('.alert-danger', formCliente);
		var successCliente= $('.alert-success', formCliente);
		formCliente.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"cliente[nombres]":{
										required:true,									    
									},
									
									"cliente[apellidos]":{
										required:true,
									},
									"cliente[email]":{
										email:true,
										required:true,
									    remote: {
									       	url: "/validar_email_cliente",
									       	type: "post"
						        		}
									},
									"cliente[telefono]":{
										required:true,
										
									},
									"cliente[telefono_movil]":{
										required:true,
										
									},
									"cliente[sexo]":{
										required:true,
									},
									"cliente[direccion]":{
										required:true,
										maxlength: 200,
						        		minlength: 50
										
									},
									
								},
								messages:{
									"cliente[nombres]":{
										required:"Indica los nombre.",
									},
									
									"cliente[apellidos]":{
										required:"Indica los apellidos.",
									},
									"cliente[email]":{
										email:"Indica un correo electrónico válido",
										required:"Indica el correo electrónico",
										remote:"Ya existe un cliente asociado a este correo"
									},
									"cliente[telefono]":{
										required:"Ingresa el teléfono.",
									},
									"cliente[telefono_movil]":{
										required:"Ingresa el teléfono móvil.",
										
									},
									"cliente[sexo]":{
										required:"Ingresa el sexo",
										
									},
									"cliente[direccion]":{
										required:"Ingresa la dirección",
										maxlength:"Se acepta un máximo de 200 caracteres ",
										minlength:"Se acepta un mínimo de 50 caracteres ",
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
					                        successCliente.hide();
					                        errorCliente.show();
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
	
		var formEditCliente = $('#edit_cliente');
		var errorEditCliente = $('.alert-danger', formEditCliente);
		var successEditCliente = $('.alert-success', formEditCliente);
		formEditCliente.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"cliente[nombres]":{
										required:true,									    
									},
									
									"cliente[apellidos]":{
										required:true,
									},
									"cliente[email]":{
										email:true,
										required:true,
									    remote: {
									       	url: "/validar_email_cliente?idcliente=" + idcliente,
									       	type: "post"
						        		}
									},
									"cliente[telefono]":{
										required:true,
										
									},
									"cliente[telefono_movil]":{
										required:true,
										
									},
									"cliente[sexo]":{
										required:true,
										
									},
									"cliente[direccion]":{
										required:true,
										maxlength: 200,
						        		minlength: 50
										
									},
									
								},
								messages:{
									"cliente[nombres]":{
										required:"Indica los nombre.",
									},
									
									"cliente[apellidos]":{
										required:"Indica los apellidos.",
									},
									"cliente[email]":{
										email:"Indica un correo electrónico válido",
										required:"Indica el correo electrónico",
										remote:"Ya existe un cliente asociado a este correo"
									},
									"cliente[telefono]":{
										required:"Ingresa el teléfono.",
									},
									"cliente[telefono_movil]":{
										required:"Ingresa el teléfono móvil.",
										
									},
									"cliente[sexo]":{
										required:"Ingresa el sexo",
										
									},
									"cliente[direccion]":{
										required:"Ingresa la dirección",
										maxlength:"Se acepta un máximo de 200 caracteres ",
										minlength:"Se acepta un mínimo de 50 caracteres ",
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
					                        successEditCliente.hide();
					                        errorEditCliente.show();
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

	});

});	