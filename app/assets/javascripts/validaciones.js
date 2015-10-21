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

var form = $('#add_usuario');
                var error = $('.alert-danger', form);
                var success = $('.alert-success', form);
	form.validate({
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
				"usuario[rols][]":{
					required: true,
                	minlength: 1
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
                        },
                "usuario[rols][]":  {
                	
                     required: "Debes Seleccionar un Rol",
                }
                
			},


			 errorPlacement: function (error, element) { // render error placement for each input type
                        if (element.attr("name") == "usuario[rols][]") { // for uniform checkboxes, insert the after the given container
                            error.insertAfter("#rol_list");
                        } else {
                            error.insertAfter(element); // for other inputs, just perform default behavior
                        }
                    },

             invalidHandler: function (event, validator) { //display error alert on form submit   
                        success.hide();
                        error.show();
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
                        if (label.attr("for") == "gender" || label.attr("for") == "payment[]") { // for checkboxes and radio buttons, no need to show OK icon
                            label
                                .closest('.form-group').removeClass('has-error').addClass('has-success');
                            label.remove(); // remove error label here
                        } else { // display success icon for other inputs
                            label
                                .addClass('valid') // mark the current input as valid and display OK icon
                            .closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
                        }
                    }
		});



var form = $('#add_rol');
                var error = $('.alert-danger', form);
                var success = $('.alert-success', form);
	form.validate({
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
                     
                            error.insertAfter(element); // for other inputs, just perform default behavior
                        
                    },

             invalidHandler: function (event, validator) { //display error alert on form submit   
                        success.hide();
                        error.show();
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
                        if (label.attr("for") == "gender" || label.attr("for") == "payment[]") { // for checkboxes and radio buttons, no need to show OK icon
                            label
                                .closest('.form-group').removeClass('has-error').addClass('has-success');
                            label.remove(); // remove error label here
                        } else { // display success icon for other inputs
                            label
                                .addClass('valid') // mark the current input as valid and display OK icon
                            .closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
                        }
                    }
		});


var form = $('#add_servicio');
                var error = $('.alert-danger', form);
                var success = $('.alert-success', form);
	form.validate({
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
                     
                            error.insertAfter(element); // for other inputs, just perform default behavior
                        
                    },

             invalidHandler: function (event, validator) { //display error alert on form submit   
                        success.hide();
                        error.show();
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
                        if (label.attr("for") == "gender" || label.attr("for") == "payment[]") { // for checkboxes and radio buttons, no need to show OK icon
                            label
                                .closest('.form-group').removeClass('has-error').addClass('has-success');
                            label.remove(); // remove error label here
                        } else { // display success icon for other inputs
                            label
                                .addClass('valid') // mark the current input as valid and display OK icon
                            .closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
                        }
                    }
		});

	});

	       
    // var options = {
    //     onLoad: function () {
    //         $('#messages').text('Start typing password');
    //     },
    //     onKeyUp: function (evt) {
    //         $(evt.target).pwstrength("outputErrorList");
    //     }
    // };
    // $(':password').pwstrength(options);

/*
        jQuery(document).ready(function () {
            "use strict";
            var $password = $(':password').pwstrength(),
                common_words = ["password", "god", "123456"];

            $password.pwstrength("addRule", "notEmail", function (options, word, score) {
                return word.match(/^([\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+\.)*[\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+@((((([a-z0-9]{1}[a-z0-9\-]{0,62}[a-z0-9]{1})|[a-z])\.)+[a-z]{2,6})|(\d{1,3}\.){3}\d{1,3}(\:\d{1,5})?)$/i) && score;
            }, -100, true);

            $password.pwstrength("addRule", "commonWords", function (options, word, score) {
                var result = false;
                $.each(common_words, function (i, item) {
                    var re = new RegExp(item, "gi");
                    if (word.match(re)) {
                        result = score;
                    }
                });
                return result;
            }, -500, true);
        });
        
        */




/*jslint vars: false, browser: true, nomen: true, regexp: true */
/*global jQuery */

/*
* jQuery Password Strength plugin for Twitter Bootstrap
*
* Copyright (c) 2008-2013 Tane Piper
* Copyright (c) 2013 Alejandro Blanco
* Dual licensed under the MIT and GPL licenses.
*
*/

// (function ($) {
//     "use strict";

//     var options = {
//             errors: [],
//             // Options
//             minChar: 8,
//             errorMessages: {
//                 password_to_short: "The Password is too short",
//                 same_as_username: "Your password cannot be the same as your username"
//             },
//             scores: [17, 26, 40, 50],
//             verdicts: ["Weak", "Normal", "Medium", "Strong", "Very Strong"],
//             showVerdicts: true,
//             raisePower: 1.4,
//             usernameField: "#username",
//             onLoad: undefined,
//             onKeyUp: undefined,
//             viewports: {
//                 progress: undefined,
//                 verdict: undefined,
//                 errors: undefined
//             },
//             // Rules stuff
//             ruleScores: {
//                 wordNotEmail: -100,
//                 wordLength: -100,
//                 wordSimilarToUsername: -100,
//                 wordLowercase: 1,
//                 wordUppercase: 3,
//                 wordOneNumber: 3,
//                 wordThreeNumbers: 5,
//                 wordOneSpecialChar: 3,
//                 wordTwoSpecialChar: 5,
//                 wordUpperLowerCombo: 2,
//                 wordLetterNumberCombo: 2,
//                 wordLetterNumberCharCombo: 2
//             },
//             rules: {
//                 wordNotEmail: true,
//                 wordLength: true,
//                 wordSimilarToUsername: true,
//                 wordLowercase: true,
//                 wordUppercase: true,
//                 wordOneNumber: true,
//                 wordThreeNumbers: true,
//                 wordOneSpecialChar: true,
//                 wordTwoSpecialChar: true,
//                 wordUpperLowerCombo: true,
//                 wordLetterNumberCombo: true,
//                 wordLetterNumberCharCombo: true
//             },
//             validationRules: {
//                 wordNotEmail: function (options, word, score) {
//                     return word.match(/^([\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+\.)*[\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+@((((([a-z0-9]{1}[a-z0-9\-]{0,62}[a-z0-9]{1})|[a-z])\.)+[a-z]{2,6})|(\d{1,3}\.){3}\d{1,3}(\:\d{1,5})?)$/i) && score;
//                 },
//                 wordLength: function (options, word, score) {
//                     var wordlen = word.length,
//                         lenScore = Math.pow(wordlen, options.raisePower);
//                     if (wordlen < options.minChar) {
//                         lenScore = (lenScore + score);
//                         options.errors.push(options.errorMessages.password_to_short);
//                     }
//                     return lenScore;
//                 },
//                 wordSimilarToUsername: function (options, word, score) {
//                     var username = $(options.usernameField).val();
//                     if (username && word.toLowerCase().match(username.toLowerCase())) {
//                         options.errors.push(options.errorMessages.same_as_username);
//                         return score;
//                     }
//                     return true;
//                 },
//                 wordLowercase: function (options, word, score) {
//                     return word.match(/[a-z]/) && score;
//                 },
//                 wordUppercase: function (options, word, score) {
//                     return word.match(/[A-Z]/) && score;
//                 },
//                 wordOneNumber : function (options, word, score) {
//                     return word.match(/\d+/) && score;
//                 },
//                 wordThreeNumbers : function (options, word, score) {
//                     return word.match(/(.*[0-9].*[0-9].*[0-9])/) && score;
//                 },
//                 wordOneSpecialChar : function (options, word, score) {
//                     return word.match(/.[!,@,#,$,%,\^,&,*,?,_,~]/) && score;
//                 },
//                 wordTwoSpecialChar : function (options, word, score) {
//                     return word.match(/(.*[!,@,#,$,%,\^,&,*,?,_,~].*[!,@,#,$,%,\^,&,*,?,_,~])/) && score;
//                 },
//                 wordUpperLowerCombo : function (options, word, score) {
//                     return word.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/) && score;
//                 },
//                 wordLetterNumberCombo : function (options, word, score) {
//                     return word.match(/([a-zA-Z])/) && word.match(/([0-9])/) && score;
//                 },
//                 wordLetterNumberCharCombo : function (options, word, score) {
//                     return word.match(/([a-zA-Z0-9].*[!,@,#,$,%,\^,&,*,?,_,~])|([!,@,#,$,%,\^,&,*,?,_,~].*[a-zA-Z0-9])/) && score;
//                 }
//             }
//         },

//         setProgressBar = function ($el, score) {
//             var options = $el.data("pwstrength"),
//                 progressbar = options.progressbar,
//                 $verdict;

//             if (options.showVerdicts) {
//                 if (options.viewports.verdict) {
//                     $verdict = $(options.viewports.verdict).find(".password-verdict");
//                 } else {
//                     $verdict = $el.parent().find(".password-verdict");
//                     if ($verdict.length === 0) {
//                         $verdict = $('<span class="password-verdict"></span>');
//                         $verdict.insertAfter($el);
//                     }
//                 }
//             }

//             if (score < options.scores[0]) {
//                 progressbar.addClass("progress-danger").removeClass("progress-warning").removeClass("progress-success");
//                 progressbar.find(".bar").css("width", "5%");
//                 if (options.showVerdicts) {
//                     $verdict.text(options.verdicts[0]);
//                 }
//             } else if (score >= options.scores[0] && score < options.scores[1]) {
//                 progressbar.addClass("progress-danger").removeClass("progress-warning").removeClass("progress-success");
//                 progressbar.find(".bar").css("width", "25%");
//                 if (options.showVerdicts) {
//                     $verdict.text(options.verdicts[1]);
//                 }
//             } else if (score >= options.scores[1] && score < options.scores[2]) {
//                 progressbar.addClass("progress-warning").removeClass("progress-danger").removeClass("progress-success");
//                 progressbar.find(".bar").css("width", "50%");
//                 if (options.showVerdicts) {
//                     $verdict.text(options.verdicts[2]);
//                 }
//             } else if (score >= options.scores[2] && score < options.scores[3]) {
//                 progressbar.addClass("progress-warning").removeClass("progress-danger").removeClass("progress-success");
//                 progressbar.find(".bar").css("width", "75%");
//                 if (options.showVerdicts) {
//                     $verdict.text(options.verdicts[3]);
//                 }
//             } else if (score >= options.scores[3]) {
//                 progressbar.addClass("progress-success").removeClass("progress-warning").removeClass("progress-danger");
//                 progressbar.find(".bar").css("width", "100%");
//                 if (options.showVerdicts) {
//                     $verdict.text(options.verdicts[4]);
//                 }
//             }
//         },

//         calculateScore = function ($el) {
//             var self = this,
//                 word = $el.val(),
//                 totalScore = 0,
//                 options = $el.data("pwstrength");

//             $.each(options.rules, function (rule, active) {
//                 if (active === true) {
//                     var score = options.ruleScores[rule],
//                         result = options.validationRules[rule](options, word, score);
//                     if (result) {
//                         totalScore += result;
//                     }
//                 }
//             });
//             setProgressBar($el, totalScore);
//             return totalScore;
//         },

//         progressWidget = function () {
//             return '<div class="progress"><div class="bar"></div></div>';
//         },

//         methods = {
//             init: function (settings) {
//                 var self = this,
//                     allOptions = $.extend(options, settings);

//                 return this.each(function (idx, el) {
//                     var $el = $(el),
//                         progressbar,
//                         verdict;

//                     $el.data("pwstrength", allOptions);

//                     $el.on("keyup", function (event) {
//                         var options = $el.data("pwstrength");
//                         options.errors = [];
//                         calculateScore.call(self, $el);
//                         if ($.isFunction(options.onKeyUp)) {
//                             options.onKeyUp(event);
//                         }
//                     });

//                     progressbar = $(progressWidget());
//                     if (allOptions.viewports.progress) {
//                         $(allOptions.viewports.progress).append(progressbar);
//                     } else {
//                         progressbar.insertAfter($el);
//                     }
//                     progressbar.find(".bar").css("width", "0%");
//                     $el.data("pwstrength").progressbar = progressbar;

//                     if (allOptions.showVerdicts) {
//                         verdict = $('<span class="password-verdict">' + allOptions.verdicts[0] + '</span>');
//                         if (allOptions.viewports.verdict) {
//                             $(allOptions.viewports.verdict).append(verdict);
//                         } else {
//                             verdict.insertAfter($el);
//                         }
//                     }

//                     if ($.isFunction(allOptions.onLoad)) {
//                         allOptions.onLoad();
//                     }
//                 });
//             },

//             destroy: function () {
//                 this.each(function (idx, el) {
//                     var $el = $(el);
//                     $el.parent().find("span.password-verdict").remove();
//                     $el.parent().find("div.progress").remove();
//                     $el.parent().find("ul.error-list").remove();
//                     $el.removeData("pwstrength");
//                 });
//             },

//             forceUpdate: function () {
//                 var self = this;
//                 this.each(function (idx, el) {
//                     var $el = $(el),
//                         options = $el.data("pwstrength");
//                     options.errors = [];
//                     calculateScore.call(self, $el);
//                 });
//             },

//             outputErrorList: function () {
//                 this.each(function (idx, el) {
//                     var output = '<ul class="error-list">',
//                         $el = $(el),
//                         errors = $el.data("pwstrength").errors,
//                         viewports = $el.data("pwstrength").viewports,
//                         verdict;
//                     $el.parent().find("ul.error-list").remove();

//                     if (errors.length > 0) {
//                         $.each(errors, function (i, item) {
//                             output += '<li>' + item + '</li>';
//                         });
//                         output += '</ul>';
//                         if (viewports.errors) {
//                             $(viewports.errors).html(output);
//                         } else {
//                             output = $(output);
//                             verdict = $el.parent().find("span.password-verdict");
//                             if (verdict.length > 0) {
//                                 el = verdict;
//                             }
//                             output.insertAfter(el);
//                         }
//                     }
//                 });
//             },

//             addRule: function (name, method, score, active) {
//                 this.each(function (idx, el) {
//                     var options = $(el).data("pwstrength");
//                     options.rules[name] = active;
//                     options.ruleScores[name] = score;
//                     options.validationRules[name] = method;
//                 });
//             },

//             changeScore: function (rule, score) {
//                 this.each(function (idx, el) {
//                     $(el).data("pwstrength").ruleScores[rule] = score;
//                 });
//             },

//             ruleActive: function (rule, active) {
//                 this.each(function (idx, el) {
//                     $(el).data("pwstrength").rules[rule] = active;
//                 });
//             }
//         };

//     $.fn.pwstrength = function (method) {
//         var result;
//         if (methods[method]) {
//             result = methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
//         } else if (typeof method === "object" || !method) {
//             result = methods.init.apply(this, arguments);
//         } else {
//             $.error("Method " +  method + " does not exist on jQuery.pwstrength");
//         }
//         return result;
//     };
// }(jQuery));
});