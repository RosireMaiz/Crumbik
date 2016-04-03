jQuery(function ($) {
  $(document).ready(function(){

    $('#criterio_difusions').dataTable({
        "select": false, 
        "pageLength": 4,
        "lengthChange": false,
        "language": {
            "zeroRecords": "No hay datos disponibles en la tabla",
            "infoEmpty": "No hay datos disponibles en la tabla",
            
        }

    });

    var formCriterioDifusion= $('#add_criterio_difusion');
    var errorCriterioDifusion = $('.alert-danger', formCriterioDifusion);
    var successCriterioDifusion = $('.alert-success', formCriterioDifusion);
    formCriterioDifusion.validate({
                        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                            errorElement: 'span', //default input error message container
                            errorClass: 'msj-error', // default input error message class
                            focusInvalid: false, // do not focus the last invalid input
                  rules: {
                    "criterio_difusion[nombre]":{
                      required:true,
                        remote: {
                            url: "/validar_criterio_difusion",
                            type: "post"
                          }
                    },
                  },
                  messages:{
                    "criterio_difusion[nombre]":{
                      required:"Indica el nombre",
                      remote:"Ya existe un Criterio de Difusión con este nombre."
                    },
                  },

                   errorPlacement: function (error, element) { // render error placement for each input type
                                 
                                        error.insertAfter(element); // for other inputs, just performRol default behavior
                                    
                                },

                         invalidHandler: function (event, validator) { //display error alert on formRol submit   
                                    successCriterioDifusion.hide();
                                    errorCriterioDifusion.show();
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

  });

}); 
  function eliminar(id_criterio_difusion){
    var request = $.ajax({
                            url: '/criterio_difusions/eliminar',
                            method: "POST",
                            data: { id_criterio_difusion: id_criterio_difusion},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
  };

  function validar( id_criterio_difusion){
    id_modal="#modaleditar"+id_criterio_difusion
    $(id_modal).validate({
                              doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
                              errorElement: 'span', //default input error message container
                              errorClass: 'msj-error', // default input error message class
                              focusInvalid: false, // do not focus the last invalid input
                              rules: {
                                "criterio_difusion[nombre]":{
                                  required:true,
                                    remote: {
                                        url: "/validar_criterio_difusion_update?id_criterio_difusion="+ id_criterio_difusion ,
                                        type: "post"
                                      },
                                },
                                "criterio_difusion[where]":{
                                  required: true,
                                },
                                "criterio_difusion[descripcion]":{
                                  required: true,
                                },

                              },
                              messages:{
                                "criterio_difusion[nombre]":{
                                  required:"Indica el nombre",
                                  remote:"Ya existe un Criterio de Difusión con este nombre."
                                },
                                "criterio_difusion[tabla]":{
                                  required:"Indica la condición",
                                },
                                "criterio_difusion[descripcion]":{
                                  required:"Indica la descripción",
                                },
                              },

                               errorPlacement: function (error, element) { // render error placement for each input type
                                               error.insertAfter(element); // for other inputs, just perform default behavior
                                              },
                });
  };

  function update(id_criterio_difusion){
 var modal = "#modaleditar"+id_criterio_difusion;
    if ($(modal).valid()) {
     
      var nombre = "#nombre"+id_criterio_difusion;
      var descripcion ="#descripcion"+id_criterio_difusion;
      var tabla = "#select_tabla"+id_criterio_difusion;
      var column = "#select_column"+id_criterio_difusion;
      var where = "#criterio_difusion_where"+id_criterio_difusion;

      var nombreval = $(nombre).val();
      var descripcionval = $(descripcion).val(); 
      var tablaval = $(tabla).val(); 
      var camposeleccionval = $(column).val(); 
      var whereval = $(where).val();
      var request = $.ajax({
                              url: '/criterio_difusions/update',
                              method: "POST",
                              data: { id_criterio_difusion: id_criterio_difusion, nombre: nombreval,
                                      descripcion: descripcionval, tabla: tablaval, 
                                      campo_seleccion: camposeleccionval, campo_comparacion: whereval},
                              dataType: "JSON"
                            });

          request.done(function( data ) {
                                           location.reload(); 
                                        });
                       
          request.fail(function( jqXHR, textStatus ) {
                                                      alert( "Request failed: " + textStatus );
                                                     });

      }
  };

  function load_table_criterio(id_criterio_difusion){
    validar(id_criterio_difusion);
    var id_criterio_difusion = id_criterio_difusion;
    var id_select_column = "#select_column"+id_criterio_difusion;
    var id_select_tabla = "#select_tabla"+id_criterio_difusion;
    var request = $.ajax({
                            url: '/criterio_difusions/consultar_criterio_difusion',
                            method: "POST",
                            data: { id_criterio_difusion: id_criterio_difusion},
                            dataType: "JSON",
                            success: function( data ) {
                                      var tabla = data.tabla ; 
                                      var campo_seleccion = data.campo_seleccion ;          
                                      $(id_select_tabla).val(tabla);
                                      $(id_select_tabla).material_select();

                                     $.ajax({
                                        url: '/update_columns',
                                        method: "POST",
                                        data: { table: tabla },
                                                dataType: "JSON",
                                        success: function( data ) {
                                          var $selectDropdown =  $(id_select_column).empty().html(' ');
                                          for (var i = 0 ; i < data.length ; i++) {
                                              var value =data[i].name;
                                              $selectDropdown.append(
                                              $("<option></option>")
                                                  .attr("value",value)
                                                  .text(value)
                                              );
                                          }
                                          $(id_select_column).val(campo_seleccion);
                                          $(id_select_column).material_select();
                                      
                                        }
                                      });   

                                    }
                          });   
  };


  function cancelar(id_criterio_difusion){
    var modal = "#modaleditar"+id_criterio_difusion;
    var nombre = "#nombre"+id_criterio_difusion;
    var descripcion ="#descripcion"+id_criterio_difusion;
    var tabla = "#select_tabla"+id_criterio_difusion;
    var column = "#select_column"+id_criterio_difusion;
    var where = "#criterio_difusion_where"+id_criterio_difusion;

    $(modal).closeModal();
    var request = $.ajax({
                            url: '/criterio_difusions/consultar_criterio_difusion',
                            method: "POST",
                            data: { id_criterio_difusion: id_criterio_difusion},
                            dataType: "JSON",
                            success: function( data ) {

                                      var nombreval = data.nombre ; 
                                      var descripcionval = data.descripcion ; 
                                      var tablaval = data.tabla ; 
                                      var columnval = data.campo_seleccion;
                                      var whereval = data.campo_comparacion;
                                      $(nombre).val(nombreval);
                                      $(descripcion).val(descripcionval);
                                      $(where).val(whereval);
                                      $('.input-field > label').attr("class", 'active');

                                      $(nombre).removeClass('msj-error');
                                      $(nombre).removeClass('valid');                  
                                      
                                      $(descripcion).removeClass('msj-error');
                                      $(descripcion).removeClass('valid');

                                      $(where).removeClass('msj-error');
                                      $(where).removeClass('valid');

                                      $( "span.msj-error" ).remove();
                                      $(tabla).val(tablaval);
                                      $(tabla).material_select();


                                     $.ajax({
                                        url: '/update_columns',
                                        method: "POST",
                                        data: { table: tablaval },
                                                dataType: "JSON",
                                        success: function( data ) {
                                          var $selectDropdown =  $(column).empty().html(' ');
                                          for (var i = 0 ; i < data.length ; i++) {
                                              var value =data[i].name;
                                              $selectDropdown.append(
                                              $("<option></option>")
                                                  .attr("value",value)
                                                  .text(value)
                                              );
                                          }
                                          $(column).val(columnval);
                                          $(column).material_select();
                                      
                                        }
                                      });

                                    }
                          });   
  };  

function update_estatus(id_criterio_difusion, estatus){
    var request = $.ajax({
                            url: '/criterio_difusions/update_estatus',
                            method: "POST",
                            data: { id_criterio_difusion: id_criterio_difusion, estatus: estatus},
                            dataType: "JSON"
                          });

        request.done(function( data ) {
                                        location.reload(); 
                                      });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });
};

function change_select_table(id_criterio_difusion){
  var id_select_column = "#select_column"+id_criterio_difusion;
  var id_select_tabla = "#select_tabla"+id_criterio_difusion;
  var where = "#criterio_difusion_where"+id_criterio_difusion;
  var name_table = $(id_select_tabla).val();

  var id_select_column_span = "#select_column_table"+id_criterio_difusion;
  var id_from_span = "#from_table"+id_criterio_difusion;
  var id_where_span = "#where_text"+id_criterio_difusion;
  
  var whereval = $(where).val();

  var request = $.ajax({
                          url: '/update_columns',
                          method: "POST",
                          data: { table: name_table },
                                  dataType: "JSON",
                          success: function( data ) {
                            var $selectDropdown =  $(id_select_column).empty().html(' ');
                            for (var i = 0 ; i < data.length ; i++) {
                                var value =data[i].name;
                                $selectDropdown.append(
                                $("<option></option>")
                                    .attr("value",value)
                                    .text(value)
                                );                               
                            }
                            $(id_select_column).material_select();
                          
                            var columnval =   $(id_select_column).val();

                            $(id_select_column_span).html(columnval);
                            $(id_from_span).html(name_table);
                            $(id_where_span).html(whereval);

                          }
                    });   
};

function change_select_column(id_criterio_difusion){
  var id_select_column = "#select_column"+id_criterio_difusion;;

  var id_select_column_span = "#select_column_table"+id_criterio_difusion;
                      
  var columnval =   $(id_select_column).val();

  $(id_select_column_span).html(columnval);

 
};

function change_where(id_criterio_difusion){

  var where = "#criterio_difusion_where"+id_criterio_difusion;
 
  var id_where_span = "#where_text"+id_criterio_difusion;
  
  var whereval = $(where).val();

 
  $(id_where_span).html(whereval);

 
};