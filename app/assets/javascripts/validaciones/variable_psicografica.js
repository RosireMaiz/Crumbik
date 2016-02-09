jQuery(function ($) {
	$(document).ready(function(){
		var idvariable = $('#form').data('edit'); 
		var formVariable = $('#add_variable_psicografica');
		var errorVariable= $('.alert-danger', formVariable);
		var successVariable= $('.alert-success', formVariable);
		formVariable.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not foc+us the last invalid input
								rules: {
									"variable_psicografica[nombre]":{
										required:true,									    
									},
									
									"variable_psicografica[descripcion]":{
										required:true,
									},
								},

								messages:{
									"variable_psicografica[nombre]":{
										required:"Indique el nombre de la Variable Psicografica.",
									},
									
									"variable_psicografica[descripcion]":{
										required:"Indique la descripción de la Variable Psicografica.",
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
					                        successVariable.hide();
					                        errorVariable.show();
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
	
		var formEditVariable = $('#edit_variable_psicografica');
		var errorEditVariable = $('.alert-danger', formEditVariable);
		var successEditVariable = $('.alert-success', formEditVariable);
		formEditVariable.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"variable_psicografica[nombre]":{
										required:true,									    
									},
									
									"variable_psicografica[descripcion]":{
										required:true,
									},
								},
								messages:{
									"variable_psicografica[nombre]":{
										required:"Indique el nombre de la Variable Psicografica.",
									},
									
									"variable_psicografica[descripcion]":{
										required:"Indique la descripción de la Variable Psicografica.",
									},
								},

					             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
					                        successEditVariable.hide();
					                        errorEditVariable.show();
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

  $('#add_variable_psicografica').submit(function(event){
       
      var fields = $("input[name='variable_psicografica[categorium_ids][]']").serializeArray();
        if (fields.length == 1) 
        { 
           $("#variable_psicografica_categorium_ids-error").removeClass("hidden");
            event.preventDefault();
           return false;
        } 
        else 
        { 
            $("#variable_psicografica_categorium_ids-error").addClass("hidden");
        }
      });

    $("input[name='variable_psicografica[categorium_ids][]']").on('change', function (){
        var fields = $("input[name='variable_psicografica[categorium_ids][]']").serializeArray();
        if (fields.length == 1) 
        { 
            $("#variable_psicografica_categorium_ids-error").removeClass("hidden");
        } 
        else 
        { 
            $("#variable_psicografica_categorium_ids-error").addClass("hidden");
        }
    });


	});
});	

function eliminar(idvariable){
	var request = $.ajax({
		url: 'eliminar',
        method: "POST",
        data: {id_variable_psicografica: idvariable},
        dataType: "JSON"
    });

	request.done(function( data ) {
    	location.reload(); 
    });
                     
   	request.fail(function( jqXHR, textStatus ) {
   		alert( "Request failed: " + textStatus );
    });
}

function update_estatus(idvariable, estatus){
    var request = $.ajax({
            url: 'update_estatus',
            method: "POST",
            data: { id_variable_psicografica: idvariable, estatus: estatus},
            dataType: "JSON"
        });

        request.done(function( data ) {
        	location.reload(); 
        });
                     
        request.fail(function( jqXHR, textStatus ) {
        	alert( "Request failed: " + textStatus );
        });
    };




