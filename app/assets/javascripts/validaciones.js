jQuery(function ($) {
	$(document).ready(function(){
		$("#new_usuario").validate({
			                   		doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
				                    errorElement: 'span', //default input error message container
				                    errorClass: 'msj-error', // default input error message class
				                    focusInvalid: false, // do not focus the last invalid input
									rules: {
										"usuario[email]":{
											email:true,
											required:true,
										    remote: {
										       	url: "/validar_email",
										       	type: "post"
							        		}
										},
										"usuario[username]":{
											required:true,			    
										},
										"usuario[password]":{
											required:true,
											minlength:8,
											maxlength:30
										},
										"usuario[password_confirmation]":{
											required:true,
											minlength:8,
											maxlength:30,
											equalTo: "#usuario_password"
										},
										terminos:"required"
									},
									messages:{
										"usuario[email]":{
											email:"Indica un correo electrónico válido",
											required:"Indica tu correo electrónico",
											remote:"Ya existe una cuenta asociada a este correo"
										},
										"usuario[username]":{
											required:"Indica tu username",
										},
										"usuario[password]":{
											required:"Indica una contraseña",
											minlength:"Tu contraseña debe tener mínimo 8 caracteres"
										},
										"usuario[password_confirmation]":"Las contraseñas no coinciden"
									}
								});

		$("#edit_usuario").validate({
			                   		doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
				                    errorElement: 'span', //default input error message container
				                    errorClass: 'msj-error', // default input error message class
				                    focusInvalid: false, // do not focus the last invalid input
									rules: {
										"usuario[perfil_attributes][nombres]":"required",
			                			"usuario[perfil_attributes][apellidos]":"required",
										"usuario[email]":{
											email:true,
											required:true,
										    remote: {
										       	url: "/validar_email_update",
										       	type: "post"
							        		}
										},
										"usuario[username]":{
											required:true,			    
										},

									},
									messages:{
										"usuario[perfil_attributes][nombres]": "Debes indicar el nombre",
			                			"usuario[perfil_attributes][apellidos]": "Debes indicar el apellido",
										"usuario[email]":{
											email:"Indica un correo electrónico válido",
											required:"Indica tu correo electrónico",
											remote:"Ya existe una cuenta asociada a este correo"
										},
										"usuario[username]":{
											required:"Indica tu username",
										},

									},

									 invalidHandler: function (event, validator) { //display error alert on formRol submit   
				                        
				                        $('html,body').animate({
				                            scrollTop: $("#edit_usuario").offset().top-350
				                        }, 'slow');
				                    },
								});


		$("#form-iniciar-sesion").validate({
			                    			 doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
							                 errorElement: 'span', //default input error message container
							                 errorClass: 'msj-error', // default input error message class
							                 focusInvalid: false, // do not focus the last invalid input
											 rules:{
												"usuario[email]":"required",
												"usuario[password]":"required"
											 },
											 groups:{
												cuenta: "usuario[email] usuario[password]"
										     },
											 messages:{
												"usuario[email]":{
													email:"Indica un correo electrónico válido",
													required:"Indica tu correo electrónico",
												},
												"usuario[password]":{
													required:"Indica una contraseña",
													minlength:"Tu contraseña debe tener mínimo 8 caracteres"
												},
												"usuario[password_confirmation]": {
								                            minlength: "La contraseña debe tener un mínimo de 8 caracteres.",
								                            required: "Debes indicar de nuevo tu contraseña.",
								                            equalTo: "Las contraseñas no coinciden."
								                },
											 }
										   });

		$("#form_foto").validate({
			                   		doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
				                    errorElement: 'span', //default input error message container
				                    errorClass: 'msj-error', // default input error message class
				                    focusInvalid: false, // do not focus the last invalid input
									rules: {
										"avatar_id":{
											
											required:true,
										    
										},
										
									},
									messages:{
										"avatar_id":{
										
											required:"Debe ingresar la foto del usuario",
										
										},
										
									},
									errorPlacement: function (error, element) { // render error placement for each input type
		                     
		                            	error.insertAfter("#avatar"); // for other inputs, just performRol default behavior
		                        
		                    		},
								});
		$("#form_imagen_plan").validate({
			                   		doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
				                    errorElement: 'span', //default input error message container
				                    errorClass: 'msj-error', // default input error message class
				                    focusInvalid: false, // do not focus the last invalid input
									rules: {
										"imagen_id":{
											
											required:true,
										},
										
									},
									messages:{
										"imagen_id":{
										
											required:"Debe ingresar la foto del plan",
										
										},
										
									},
									errorPlacement: function (error, element) { // render error placement for each input type
		                     
		                            	error.insertAfter("#imagen"); // for other inputs, just performRol default behavior
		                        
		                    		},
								});

	var formRol = $('#add_rol');
	var errorRol = $('.alert-danger', formRol);
	var successRol = $('.alert-success', formRol);
	formRol.validate({
			            doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
	                    errorElement: 'span', //default input error message container
	                    errorClass: 'msj-error', // default input error message class
	                    focusInvalid: false, // do not focus the last invalid input
						rules: {
							"rol[nombre]":{
								required:true,
							    remote: {
							       	url: "/validar_rol",
							       	type: "post"
				        		}
							},
						},
						messages:{
							"rol[nombre]":{
								required:"Indica el nombre",
								remote:"Ya existe un rol con este nombre."
							},
							
			                
						},


						 errorPlacement: function (error, element) { // render error placement for each input type
			                     
			                            error.insertAfter(element); // for other inputs, just performRol default behavior
			                        
			                    },

			             invalidHandler: function (event, validator) { //display error alert on formRol submit   
			                        successRol.hide();
			                        errorRol.show();
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

			                            label
			                                .addClass('valid') // mark the current input as valid and display OK icon
			                            .closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
			                    }
						});


	var formServicio = $('#add_servicio');
	var errorServicio = $('.alert-danger', formServicio);
	var successServicio = $('.alert-success', formServicio);
	formServicio.validate({
				            doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
		                    errorElement: 'span', //default input error message container
		                    errorClass: 'msj-error', // default input error message class
		                    focusInvalid: false, // do not focus the last invalid input
							rules: {
								"servicio[nombre]":{
									required:true,
								    remote: {
								       	url: "/validar_servicio",
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
				                     
				                            error.insertAfter(element); // for other inputs, just performServicio default behavior
				                        
				                    },

				             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
				                        successServicio.hide();
				                        errorServicio.show();
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

			
	$("#add_nodo").validate({
			 				ignore: "",
					        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
		                    errorElement: 'span', //default input error message container
		                    errorClass: 'msj-error', // default input error message class
		                    focusInvalid: false, // do not focus the last invalid input
							rules: {
									"nombre":{
										
										required:true,
										remote: {
									       	url: "/validar_opcion",
									       	type: "post"
						        		}
									    
									},
									"icono":{
										required:true,
									},
									"url":{
										required:true,			    
									}
								},
							messages:{
								"nombre":{
									
									required:"Indica el nombre.",
									remote:"Ya existe un nodo con este nombre."
								
								},
								"icono":{
									
									required:"Seleccione el icono del nodo.",
								
								},
								"url":{
									required:"Indica el url."
								}
							},

							 errorPlacement: function (error, element) { // render error placement for each input type
				                        if (element.attr("name") == "icono") { // for uniform checkboxes, insert the after the given container
				                            error.insertAfter("#div_icono");
				                        } else {
				                            error.insertAfter(element); // for other inputs, just perform default behavior
				                        }
				                    },
							});



	var formUsuario = $('#add_usuario_portal');
	var errorUsuario = $('.alert-danger', formUsuario);
	var successUsuario = $('.alert-success', formUsuario);
	formUsuario.validate({
				            doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
		                    errorElement: 'span', //default input error message container
		                    errorClass: 'msj-error', // default input error message class
		                    focusInvalid: false, // do not focus the last invalid input
							rules: {
								"usuario[perfil_attributes][nombres]":"required",
				                "usuario[perfil_attributes][apellidos]":"required",
								"usuario[email]":{
									email:true,
									required:true,
								    remote: {
								       	url: "/validar_email",
								       	type: "post"
					        		}
								},
								"usuario[username]":{
									required:true,			    
								},
								"usuario[password]":{
									required:true,
									minlength:8,
									maxlength:30
								},
								"usuario[password_confirmation]":{
									required:true,
									minlength:8,
									maxlength:30,
									equalTo: "#usuario_password"
								},
								

							},
							messages:{
								"usuario[perfil_attributes][nombres]": "Debes indicar el nombre",
				                "usuario[perfil_attributes][apellidos]": "Debes indicar el apellido",
								"usuario[email]":{
									email:"Indica un correo electrónico válido",
									required:"Indica el correo electrónico",
									remote:"Ya existe una cuenta asociada a este correo"
								},
								"usuario[username]":{
									required:"Indica el username",
								},
								"usuario[password]":{
									required:"Indica una contraseña",
									minlength:"La contraseña debe tener mínimo 8 caracteres"
								},
								 "usuario[password_confirmation]": {
				                            minlength: "La contraseña debe tener un mínimo de 8 caracteres.",
				                            required: "Debes indicar de nuevo la contraseña.",
				                            equalTo: "Las contraseñas no coinciden."
				                        },
				                        
								
				                
								},

							 errorPlacement: function (error, element) { // render error placement for each input type
				                     
				                        if (element.attr("name") == "usuario[rol_ids][]") { // for uniform checkboxes, insert the after the given container
				                            error.insertAfter("#rol_list");
				                        } else {
				                            error.insertAfter(element); // for other inputs, just perform default behavior
				                        }
				                    },

				             invalidHandler: function (event, validator) { //display error alert on formRol submit   
				                        successUsuario.hide();
				                        errorUsuario.show();
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
				                    
				                   },
							});


	var formRedSocial = $('#add_red_social');
	var errorRedSocial = $('.alert-danger', formRedSocial);
	var successRedSocial = $('.alert-success', formRedSocial);
	formRedSocial.validate({
							ignore: "",
					        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
		                    errorElement: 'span', //default input error message container
		                    errorClass: 'msj-error', // default input error message class
		                    focusInvalid: false, // do not focus the last invalid input
							rules: {
								"red_social[nombre]":{
									
									required:true,
									remote: {
								       	url: "/validar_red_social",
								       	type: "post"
					        		}
								    
								},
								"red_social[icono]":{
									required:true,
								},
							},
							messages:{
								"red_social[nombre]":{
									
									required:"Indica el nombre.",
									remote:"Ya existe una red social con este nombre."
								
								},
								"red_social[icono]":{
									
									required:"Seleccione el icono de la red social.",
								
								},	
							},

							 errorPlacement: function (error, element) { // render error placement for each input type
				                        if (element.attr("name") == "red_social[icono]") { // for uniform checkboxes, insert the after the given container
				                            error.insertAfter("#div_icono");
				                        } else {
				                            error.insertAfter(element); // for other inputs, just perform default behavior
				                        }
				                    },

				            invalidHandler: function (event, validator) { //display error alert on formServicio submit   
				                        successRedSocial.hide();
				                        errorRedSocial.show();
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

	var formPais = $('#add_pais');
	var errorPais = $('.alert-danger', formPais);
	var successPais = $('.alert-success', formPais);
	formPais.validate({
				        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
	                    errorElement: 'span', //default input error message container
	                    errorClass: 'msj-error', // default input error message class
	                    focusInvalid: false, // do not focus the last invalid input
						rules: {
							"pais[nombre]":{
								
								required:true,
								remote: {
							       	url: "/validar_pais",
							       	type: "post"
				        		}
							    
							},
							"pais[iso]":{
								required:true,
								maxlength:3,
							},
						},
						messages:{
							"pais[nombre]":{
								required:"Indica el nombre.",
								remote:"Ya existe un país con este nombre."
							},
							"pais[iso]":{
								required:"Indica el iso del país.",
								maxlength:"El iso tiene un maximo de 3 caracteres ",
							},	
						},

						 errorPlacement: function (error, element) { // render error placement for each input type
			                     
			                            error.insertAfter(element); // for other inputs, just performServicio default behavior
			                        
			                    },

			             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
			                        successPais.hide();
			                        errorPais.show();
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

	var formDispositivo = $('#add_dispositivo');
	var errorDispositivo = $('.alert-danger', formDispositivo);
	var successDispositivo = $('.alert-success', formDispositivo);
	formDispositivo.validate({
					            doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"dispositivo[nombre]":{
										required:true,
									    remote: {
									       	url: "/validar_dispositivo",
									       	type: "post"
						        		}
									},
								},
								messages:{
									"dispositivo[nombre]":{
										required:"Indica el nombre",
										remote:"Ya existe un dispositivo con este nombre."
									},
									
					                
								},


								 errorPlacement: function (error, element) { // render error placement for each input type
					                     
					                            error.insertAfter(element); // for other inputs, just performRol default behavior
					                        
					                    },

					             invalidHandler: function (event, validator) { //display error alert on formRol submit   
					                        successDispositivo.hide();
					                        errorDispositivo.show();
					                        $('html,body').animate({
					                            scrollTop: $(".steps").offset().top
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

					                            label
					                                .addClass('valid') // mark the current input as valid and display OK icon
					                            .closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
					                    }
							});

	var formFrecuenciaPago = $('#add_frecuencia_pago');
	var errorFrecuenciaPago = $('.alert-danger', formFrecuenciaPago);
	var successFrecuenciaPago = $('.alert-success', formFrecuenciaPago);
	formFrecuenciaPago.validate({
							        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
				                    errorElement: 'span', //default input error message container
				                    errorClass: 'msj-error', // default input error message class
				                    focusInvalid: false, // do not focus the last invalid input
									rules: {
										"frecuencia_pago[nombre]":{
											
											required:true,
											remote: {
										       	url: "/validar_frecuencia_pago",
										       	type: "post"
							        		}
										    
										},
										"frecuencia_pago[meses]":{
											required:true,
										},
									},
									messages:{
										"frecuencia_pago[nombre]":{
											required:"Indica el nombre.",
											remote:"Ya existe una frecuencia de pago con este nombre."
										},
										"frecuencia_pago[meses]":{
											required:"Indica la cantidad meses.",
										
										},	
									},

									 errorPlacement: function (error, element) { // render error placement for each input type
						                     
						                            error.insertAfter(element); // for other inputs, just performServicio default behavior
						                        
						                    },

						             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
						                        successFrecuenciaPago.hide();
						                        errorFrecuenciaPago.show();
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

	var formModoPago = $('#add_modo_pago');
	var errorModoPago = $('.alert-danger', formModoPago);
	var successModoPago = $('.alert-success', formModoPago);
	formModoPago.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"modo_pago[nombre]":{
										
										required:true,
										remote: {
									       	url: "/validar_modo_pago",
									       	type: "post"
						        		}
									    
									},
									
								},
								messages:{
									"modo_pago[nombre]":{
										required:"Indica el nombre.",
										remote:"Ya existe un modo de pago con este nombre."
									},
									
								},

								 errorPlacement: function (error, element) { // render error placement for each input type
					                     
					                            error.insertAfter(element); // for other inputs, just performServicio default behavior
					                        
					                    },

					             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
					                        successModoPago.hide();
					                        errorModoPago.show();
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

	var formPlan = $('#add_plan');
	var errorPlan = $('.alert-danger', formPlan);
	var successPlan = $('.alert-success', formPlan);
	formPlan.validate({
							    doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"plan[nombre]":{
										
										required:true,
										remote: {
									       	url: "/validar_plan",
									       	type: "post"
						        		}
									    
									},
									"plan[costo]":{
										
										required:true,
										min: 1,
									},
									"plan[descripcion]":{
										required:true,
									},
									
								},
								messages:{
									"plan[nombre]":{
										required:"Indica el nombre.",
										remote:"Ya existe un plan con este nombre."
									},
									"plan[costo]":{
										required:"Indica el costo del plan.",
										min: "Ingrese una cantidad mayor que 0",
									},
									"plan[descripcion]":{
										required:"Indica la descripción del plan.",
									},

								},

								 errorPlacement: function (error, element) { // render error placement for each input type
					                     
					                            error.insertAfter(element); // for other inputs, just performServicio default behavior
					                        
					                    },

					             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
					                        successPlan.hide();
					                        errorPlan.show();
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


	var formProducto = $('#add_producto');
	var errorProducto = $('.alert-danger', formProducto);
	var successProducto = $('.alert-success', formProducto);
	formProducto.validate({
							    doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"producto[nombre]":{
										
										required:true,
										
									},
									"producto[precio]":{
										required:true,
										min: 1,
									},
									"producto[descripcion]":{
										required:true,
										maxlength:255,
										minlength:60,
									},
									
								},
								messages:{
									"producto[nombre]":{
										required:"Indica el nombre.",
										
									},
									"producto[precio]":{
										required:"Indica el precio.",
										min: "Ingrese una cantidad mayor que 0",
									},
									"producto[descripcion]":{
										required:"Indica la descripción.",
										maxlength:"Se acepta un máximo de 255 caracteres ",
										minlength:"Se acepta un mínimo de 60 caracteres ",
									},

								},

								 errorPlacement: function (error, element) { // render error placement for each input type
					                     
					                            error.insertAfter(element); // for other inputs, just perform default behavior
					                        
					                    },

					             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
					                        successProducto.hide();
					                        errorProducto.show();
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




	var formTipoOrganizacion = $('#add_tipo_organizacion');
	var errorTipoOrganizacion = $('.alert-danger', formTipoOrganizacion);
	var successTipoOrganizacion = $('.alert-success', formTipoOrganizacion);
	formTipoOrganizacion.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"tipo_organizacion[nombre]":{
										
										required:true,
										remote: {
									       	url: "/validar_tipo_organizacion",
									       	type: "post"
						        		}
									    
									},
									
									"tipo_organizacion[descripcion]":{
										required:true,
									},
									
								},
								messages:{
									"tipo_organizacion[nombre]":{
										required:"Indica el nombre.",
										remote:"Ya existe un tipo de organización con este nombre."
									},
									
									"tipo_organizacion[descripcion]":{
										required:"Indica la descripción del tipo de organización.",
									},

								},

								 errorPlacement: function (error, element) { // render error placement for each input type
					                     
					                            error.insertAfter(element); // for other inputs, just performServicio default behavior
					                        
					                    },

					             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
					                        successTipoOrganizacion.hide();
					                        errorTipoOrganizacion.show();
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

	var formSugerencia = $('#add_sugerencia');
	var errorSugerencia = $('.alert-danger', formSugerencia);
	var successSugerencia = $('.alert-success', formSugerencia);
	formSugerencia.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"sugerencium[titulo]":{
										
										required:true,
									    
									},
									
									"sugerencium[contenido]":{
										required:true,
									},
									
								},
								messages:{
									"sugerencium[titulo]":{
										required:"Indica el titulo.",
										
									},
									
									"sugerencium[contenido]":{
										required:"Indica el contenido de la sugerencia.",
									},

								},

								 errorPlacement: function (error, element) { // render error placement for each input type
					                     
					                            error.insertAfter(element); // for other inputs, just performServicio default behavior
					                        
					                    },

					             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
					                        successSugerencia.hide();
					                        errorSugerencia.show();
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