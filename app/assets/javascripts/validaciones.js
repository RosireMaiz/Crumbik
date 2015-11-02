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
                            scrollTop: $(".steps").offset().top-80
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
                            scrollTop: $(".steps").offset().top-80
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



var formUsuario = $('#add_usuario');
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
				}
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
                        }
                
			},

			 errorPlacement: function (error, element) { // render error placement for each input type
                     
                        if (element.attr("name") == "usuario[rols][]") { // for uniform checkboxes, insert the after the given container
                            error.insertAfter("#rol_list");
                        } else {
                            error.insertAfter(element); // for other inputs, just perform default behavior
                        }
                    },

             invalidHandler: function (event, validator) { //display error alert on formRol submit   
                        successUsuario.hide();
                        errorUsuario.show();
                        $('html,body').animate({
                            scrollTop: $(".steps").offset().top-80
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
                            scrollTop: $(".steps").offset().top-80
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
				},
			},
			messages:{
				"pais[nombre]":{
					required:"Indica el nombre.",
					remote:"Ya existe un país con este nombre."
				},
				"pais[iso]":{
					required:"Indica el iso del país.",
				
				},	
			},

			 errorPlacement: function (error, element) { // render error placement for each input type
                     
                            error.insertAfter(element); // for other inputs, just performServicio default behavior
                        
                    },

             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
                        successPais.hide();
                        errorPais.show();
                        $('html,body').animate({
                            scrollTop: $(".steps").offset().top-80
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