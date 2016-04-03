var icon_difusion = ["mdi-notification-phone-in-talk", "fa fa-comments", "mdi-communication-email", "mdi-social-share" ];
var text_difusion = ["Llamada", "SMS", "Email", "Red Social" ];
var value_difusion = ["llamada", "sms", "email", "red_social" ];
var medio_difusion_seleted = new Array(false, false, false, false);
var count_criterio = 0, 
    count_criterio_validate = 0,
    count_medio_difusion = 0;

jQuery(function ($) {

	$(document).ready(function(){

		var formCampannaPublicitaria = $('#add_campanna_publicitaria');
		var errorCampannaPublicitaria= $('.alert-danger', formCampannaPublicitaria);
		var successCampannaPublicitaria= $('.alert-success', formCampannaPublicitaria);
		formCampannaPublicitaria.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not foc+us the last invalid input
								rules: {
									"campanna_publicitarium[titulo]":{
										required:true,
						        		maxlength: 50,
						        		minlength: 10
									    
									},
									
									"campanna_publicitarium[descripcion]":{
										required:true,
										maxlength: 300,
						        		minlength: 50,
									},
									"campanna_publicitarium[fecha_inicio]":{
										required:true,
										
									},
									"campanna_publicitarium[fecha_fin]":{
										required:true,
										
									},
									
								},
								messages:{
									"campanna_publicitarium[titulo]":{
										required:"Indica el título.",
										maxlength:"Se acepta un máximo de 50 caracteres ",
										minlength:"Se acepta un mínimo de 10 caracteres ",
									},
									
									"campanna_publicitarium[descripcion]":{
										required:"Indica la descripción.",
										maxlength:"Se acepta un máximo de 300 caracteres ",
										minlength:"Se acepta un mínimo de 50 caracteres ",
									},
									"campanna_publicitarium[fecha_inicio]":{
										required:"Ingresa la fecha de inicio.",
										
									},
									"campanna_publicitarium[fecha_fin]":{
										required:"Ingresa la fecha de finalización",
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
					                        successCampannaPublicitaria.hide();
					                        errorCampannaPublicitaria.show();
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
	
		var formEditCampannaPublicitaria = $('#edit_campana_publicitaria');
		var errorEditCampannaPublicitaria = $('.alert-danger', formEditCampannaPublicitaria);
		var successEditCampannaPublicitaria = $('.alert-success', formEditCampannaPublicitaria);

		formEditCampannaPublicitaria.validate({
						        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
			                    errorElement: 'span', //default input error message container
			                    errorClass: 'msj-error', // default input error message class
			                    focusInvalid: false, // do not focus the last invalid input
								rules: {
									"campanna_publicitarium[titulo]":{
										required:true,
						        		maxlength: 50,
						        		minlength: 10
									    
									},
									
									"campanna_publicitarium[descripcion]":{
										required:true,
										maxlength: 300,
						        		minlength: 50,
									},
									"campanna_publicitarium[fecha_inicio]":{
										required:true,
										
									},
									"campanna_publicitarium[fecha_fin]":{
										required:true,
										
									},
									
								},
								messages:{
									"campanna_publicitarium[titulo]":{
										required:"Indica el título.",
										maxlength:"Se acepta un máximo de 50 caracteres ",
										minlength:"Se acepta un mínimo de 10 caracteres ",
									},
									
									"campanna_publicitarium[descripcion]":{
										required:"Indica la descripción.",
										maxlength:"Se acepta un máximo de 300 caracteres ",
										minlength:"Se acepta un mínimo de 50 caracteres ",
									},
									"campanna_publicitarium[fecha_inicio]":{
										required:"Ingresa la fecha de inicio.",
										
									},
									"campanna_publicitarium[fecha_fin]":{
										required:"Ingresa la fecha de finalización",
									},
								},

					             invalidHandler: function (event, validator) { //display error alert on formServicio submit   
					                        successEditCampannaPublicitaria.hide();
					                        errorEditCampannaPublicitaria.show();
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

		 $('#campanna_publicitaria_inicio').pickadate({
		        selectMonths: true, // Creates a dropdown to control month
		        selectYears: true, // Creates a dropdown of 15 years to control year
		        labelMonthNext: 'Próximo Mes',
		        labelMonthPrev: 'Mes Anterior',
		        labelMonthSelect: 'Selecione Mes',
		        labelYearSelect: 'Selecione Año',
		        monthsFull: [ 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre' ],
		        monthsShort: [ 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic' ],
		        weekdaysFull: [ 'Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sábado' ],
		        weekdaysShort: [ 'Dom', 'Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab' ],
		        weekdaysLetter: [ 'D', 'L', 'M', 'X', 'J', 'V', 'S' ],
		        today: 'Hoy',
		        clear: 'Limpiar',
		        close: 'Cerrar',
		        format: 'dd/mm/yyyy',
		        closeOnSelect: true,
		        closeOnClear: false,
		      /*  onSet: function () {
		          this.close();
		          },*/

		        onClose:function(){

		                  var inicio = $("#campanna_publicitaria_inicio").val();
		                  var  fin = $("#campanna_publicitaria_fin").val();
		                  if (inicio != "" && inicio != null && fin != "" 
		                      && fin != null) {
		                      
		                      if (inicio > fin) {
		                          $("#campanna_publicitaria_inicio-error").addClass("valid").html("");;
		                          $("#campanna_publicitaria_inicio-error_local").removeClass("hiden").html("Ingrese una fecha menor que la fecha de finalización");
		                          $("#campanna_publicitaria_fin-error_local").addClass("hiden").html("");
		                      } else {
		                          $("#campanna_publicitaria_inicio-error").addClass("valid").html("");
		                          $("#campanna_publicitaria_inicio-error_local").addClass("hiden").html("");
		                          $("#campanna_publicitaria_fin-error_local").addClass("hiden").html("");
		                      };
		                  }

		                }           
		      });


		  $('#campanna_publicitaria_fin').pickadate({
		        selectMonths: true, // Creates a dropdown to control month
		        selectYears: true, // Creates a dropdown of 15 years to control year
		        labelMonthNext: 'Próximo Mes',
		        labelMonthPrev: 'Mes Anterior',
		        labelMonthSelect: 'Selecione Mes',
		        labelYearSelect: 'Selecione Año',
		        monthsFull: [ 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre' ],
		        monthsShort: [ 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic' ],
		        weekdaysFull: [ 'Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sábado' ],
		        weekdaysShort: [ 'Dom', 'Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab' ],
		        weekdaysLetter: [ 'D', 'L', 'M', 'X', 'J', 'V', 'S' ],
		        today: 'Hoy',
		        clear: 'Limpiar',
		        close: 'Cerrar',
		        format: 'dd/mm/yyyy',
		        closeOnSelect: true,
		        closeOnClear: false,
		/*        onSet: function () {
		          this.close();
		          },*/

		          onClose:function(){
		                    var inicio = $("#campanna_publicitaria_inicio").val();
		                    var  fin = $("#campanna_publicitaria_fin").val();
		                    if (inicio != "" && inicio != null && fin != "" 
		                        && fin != null) {
		                      if (inicio > fin) {
		                          $("#campanna_publicitaria_fin-error").addClass("valid").html("");;
		                          $("#campanna_publicitaria_fin-error_local").removeClass("hiden").html("Ingrese una fecha mayor que la fecha de inicio");
		                          $("#campanna_publicitaria_inicio-error_local").addClass("hiden").html("");
		                          
		                      }else{
		                          $("#campanna_publicitaria_fin-error").addClass("valid").html("");
		                          $("#campanna_publicitaria_inicio-error_local").addClass("hiden").html("");
		                          $("#campanna_publicitaria_fin-error_local").addClass("hiden").html("");
		                      };
		                    }


		                  }           
		      });
		  
		      $('#add_campanna_publicitaria').submit(function(event){
		         
		          var inicio = $("#campanna_publicitaria_inicio").val();
		          var  fin = $("#campanna_publicitaria_fin").val();
		         
		          if ( inicio != "" && inicio != null && fin != "" && fin != null   && inicio > fin) {
		            $("#campanna_publicitaria_fin-error_local").removeClass("hiden").html("Ingrese una fecha mayor que la fecha de inicio");
		            $("#campanna_publicitaria_inicio-error_local").addClass("hiden").html("");
		            $('.alert-danger').show();
		            $('.alert-success').hide();
		            $('html,body').animate({
		                scrollTop: $(".steps").offset().top-350
		            }, 'slow');
		            event.preventDefault();
		          } else {
		            $("#campanna_publicitaria_inicio-error_local").addClass("hiden").html("");
		            $("#campanna_publicitaria_fin-error_local").addClass("hiden").html("");
		          };

		          if (count_medio_difusion == 0) {
		            $("#campanna_publicitarium_campanna_publicitaria_detalles_attributes-error_local").removeClass("hidden");
		            event.preventDefault();
		           return false;
		           }
		          else{ 
		            $("#campanna_publicitarium_campanna_publicitaria_detalles_attributes-error_local").addClass("hidden");
		          }

		      });


	});
});	

  $("#agregar-medio-difusion").click(function(){
    var source = $("#select_medio_difusion");
    var id_difusion = source.val(),
        medio = medio_difusion_seleted[id_difusion];
        if (!medio) {
          var icon = icon_difusion[id_difusion],
              text = text_difusion[id_difusion]
              value = value_difusion[id_difusion];
          medio_difusion_seleted[id_difusion] = true;
          $("#medio-difusion").append("<div id='div_"+ id_difusion+ "' class='col s6' style='padding-bottom: 5px;'> <span><a href='#!'  id= '"+ id_difusion + "_text' class='red-social-add light-blue' ><i class= '"+ icon + "'></i></a> "+ text + "</span> <a onclick='delete_medio_difusion(div_"+ id_difusion+ ", "+id_difusion+")' id='delete-difusion' data-id='"+ id_difusion + "' href='javascript:void(0)'  class='tooltipped delete-difusion' data-position='right' data-delay='50' data-tooltip='Eliminar'><i class='mdi-navigation-close green-text'></i></a>  <input name='campanna_publicitarium[campanna_publicitaria_detalles_attributes][][medio_difusion]' value='"+ value + "' hidden/></div>");
          count_medio_difusion++;
          if(count_medio_difusion == 1){
          	$("#campanna_publicitarium_campanna_publicitaria_detalles_attributes-error_local").addClass("hidden");	
          }
          
        }
    
  });
  function delete_medio_difusion(id_div, id_difusion){
     $(id_div).remove();
     medio_difusion_seleted[id_difusion] = false;
     count_medio_difusion--;
     if (count_medio_difusion == 0) {
        $("#campanna_publicitarium_campanna_publicitaria_detalles_attributes-error_local").removeClass("hidden");
       }
      else{ 
        $("#campanna_publicitarium_campanna_publicitaria_detalles_attributes-error_local").addClass("hidden");
      }
   };

   $("#agregar-criterio-difusion").click(function(){
          var source = $("#select_criterio_difusion");
          var id_criterio_difusion = source.val();
          var id_select = "#select_"+id_criterio_difusion +"_"+ count_criterio;
          alert(id_criterio_difusion);
          if (id_criterio_difusion != null) {
          	var request = $.ajax({
                        url: '/criterio_difusions/consultar_criterio_difusion',
                        method: "POST",
                        data: { id_criterio_difusion: id_criterio_difusion},
                        dataType: "JSON",
                        success: function( data ) {
                                  var nombreval = data.nombre; 

                                   $("#criterios-difusion").append("<div id='div_criterio_" + id_criterio_difusion 
                                   	+ "_" + count_criterio + "'class='row'><input name='campanna_publicitarium[criterio_campanna_pubs_attributes][][criterio_difusion_id]' value="+ id_criterio_difusion+" hidden/><div class='input-field col s3'><p>"+ nombreval +"</p></div><div class='input-field col s4  no-margin-v'><select id='select_"+ id_criterio_difusion +"_"+ count_criterio+"' name='campanna_publicitarium[criterio_campanna_pubs_attributes][][operador]'><option value='=' disabled selected>Operador</option><option value='='>Igual a</option><option value='>='>Mayor que</option><option value='<='>Menor que</option><option value='!='>Diferente a</option></select></div><div class='col s5'><div class='input-field input-group no-margin-v'><input id='valor' name='campanna_publicitarium[criterio_campanna_pubs_attributes][][valor]' type='text' class='validate'><a onclick='delete_criterio_difusion(div_criterio_" + id_criterio_difusion +"_" + count_criterio +")' id='delete-criterio' href='javascript:void(0)'  class='tooltipped input-group-addon' data-position='right' data-delay='50' data-tooltip='Eliminar'><i class='mdi-navigation-close green-text'></i></a><label for='valor'>Valor</label></div> </div></div>");
                                     
                                     $(id_select).material_select();
                                     count_criterio++;
                                  }
                      });  
          	$("#campanna_publicitarium_criterio_campanna_pubs_attributes-error_local").addClass("hidden");

          } else {
          	 $("#campanna_publicitarium_criterio_campanna_pubs_attributes-error_local").removeClass("hidden");
          }
          	
          

   });

  function delete_criterio_difusion(id_div){
     $(id_div).remove();
   };
