jQuery(function ($) {
  $(document).ready(function(){

  var formPublicidad = $('#add_publicidad');
  var errorPublicidad = $('.alert-danger', formPublicidad);
  var successPublicidad = $('.alert-success', formPublicidad);
  formPublicidad.validate({
                    doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                          errorElement: 'span', //default input error message container
                          errorClass: 'msj-error', // default input error message class
                          focusInvalid: false, // do not focus the last invalid input
                rules: {

                  "publicidad[fecha_inicio]":{
                    required:true,
                    
                  },
                  "publicidad[fecha_finalizacion]":{
                    required:true,
                    
                  },
                  
                },
                messages:{
                  "publicidad[fecha_inicio]":{
                    required:"Ingresa la fecha de inicio.",
                    
                  },
                  "publicidad[fecha_finalizacion]":{
                    required:"Ingresa la fecha de finalizacion",
                  },

                },

                 errorPlacement: function (error, element) { // render error placement for each input type
                               
                                      error.insertAfter(element); // for other inputs, just performServicio default behavior
                                  
                              },

                       invalidHandler: function (event, validator) { //display error alert on formServicio submit   
                                  successPublicidad.hide();
                                  errorPublicidad.show();
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


 $("#imagen_publicidad").fileinput({
      'browseLabel':'Cambiar',
      'showCaption':false,
      'initialPreview': [ "<img src='" + $("#imagen").attr("class") +"' class='file-preview-image ' alt='Avatar' title='Imagen de publicidad'>"],
      'initialPreviewShowDelete':false,
      'initialCaption':'archivo(s) seleccionado(s)',
      'allowedFileTypes':['image'],
      'allowedFileExtensions':['jpg', 'png', 'jpeg'],
      'browseClass':'btn btn-primary right',
      'browseIcon':'<i class="mdi-file-attachment"></i>',
      'showRemove':false,
      'showUpload':false,
      'uploadLabel':'Subir',
      'uploadIcon':'<i class="mdi-file-file-upload"></i>',
      'uploadClass':'btn btn-success ',
      'showClose':false
    });




  $("#imagen_publicidad").change( readImage )


  $('#publicidad_fecha_inicio').pickadate({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: true, // Creates a dropdown of 15 years to control year
        labelMonthNext: 'Próximo Mes',
        labelMonthPrev: 'Mes Anterior',
        labelMonthSelect: 'Selecione Mes',
        labelYearSelect: 'Selecione Año',
        monthsFull: [ 'Enero', 'Febrero', 'MArzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre' ],
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
        onClose:function(){

                  var fecha_inicio = $("#publicidad_fecha_inicio").val();
                  var  fecha_finalizacion = $("#publicidad_fecha_finalizacion").val();
                  if (fecha_inicio != "" && fecha_inicio != null && fecha_finalizacion != "" 
                      && fecha_finalizacion != null) {
                      
                      if (fecha_inicio > fecha_finalizacion) {
                          $("#publicidad_fecha_inicio-error").addClass("valid").html("");;
                          $("#publicidad_fecha_inicio-error_local").removeClass("hiden").html("Ingrese una fecha menor que la fecha de finalización");
                          $("#publicidad_fecha_finalizacion-error_local").addClass("hiden").html("");
                      } else {
                          $("#publicidad_fecha_inicio-error").addClass("valid").html("");
                          $("#publicidad_fecha_inicio-error_local").addClass("hiden").html("");
                          $("#publicidad_fecha_finalizacion-error_local").addClass("hiden").html("");
                      };
                  }

                }           
      });


  $('#publicidad_fecha_finalizacion').pickadate({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: true, // Creates a dropdown of 15 years to control year
        labelMonthNext: 'Próximo Mes',
        labelMonthPrev: 'Mes Anterior',
        labelMonthSelect: 'Selecione Mes',
        labelYearSelect: 'Selecione Año',
        monthsFull: [ 'Enero', 'Febrero', 'MArzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre' ],
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

          onClose:function(){
                    var fecha_inicio = $("#publicidad_fecha_inicio").val();
                    var  fecha_finalizacion = $("#publicidad_fecha_finalizacion").val();
                    if (fecha_inicio != "" && fecha_inicio != null && fecha_finalizacion != "" 
                        && fecha_finalizacion != null) {
                      if (fecha_inicio > fecha_finalizacion) {
                          $("#publicidad_fecha_finalizacion-error").addClass("valid").html("");;
                          $("#publicidad_fecha_finalizacion-error_local").removeClass("hiden").html("Ingrese una fecha mayor que la fecha de inicio");
                          $("#publicidad_fecha_inicio-error_local").addClass("hiden").html("");
                          
                      }else{
                          $("#publicidad_fecha_finalizacion-error").addClass("valid").html("");
                          $("#publicidad_fecha_inicio-error_local").addClass("hiden").html("");
                          $("#publicidad_fecha_finalizacion-error_local").addClass("hiden").html("");
                      };
                    }


                  }           
      });
  
      $('#add_publicidad').submit(function(event){
         
          var fecha_inicio = $("#publicidad_fecha_inicio").val();
          var  fecha_finalizacion = $("#publicidad_fecha_finalizacion").val();
         
          if ( fecha_inicio != "" && fecha_inicio != null && fecha_finalizacion != "" && fecha_finalizacion != null   && fecha_inicio > fecha_finalizacion) {
            $("#publicidad_fecha_finalizacion-error_local").removeClass("hiden").html("Ingrese una fecha mayor que la fecha de inicio");
            $("#publicidad_fecha_inicio-error_local").addClass("hiden").html("");
            $('.alert-danger').show();
            $('.alert-success').hide();
            $('html,body').animate({
                scrollTop: $(".steps").offset().top-350
            }, 'slow');
            event.preventDefault();
          } else {
            $("#publicidad_fecha_inicio-error_local").addClass("hiden").html("");
            $("#publicidad_fecha_finalizacion-error_local").addClass("hiden").html("");
          };

      });


    function readImage() {
        
      if ( this.files && this.files[0] ) {
          var FR = new FileReader();
          FR.onload = function(e) {
            var formato = e.target.result.split(";base64,")[0] + ";base64,";
            var base64 = e.target.result.split(formato)[1];
            $("#publicidad_imagen").val(base64);
            $("#publicidad_formato_imagen").val(formato);
          };       
          FR.readAsDataURL( this.files[0] );
         
      }

    }
