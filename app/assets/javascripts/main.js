$(document).ready(function(){


	var table = $('#rols').DataTable({
		 "searching": false,
		  "select": true, 
		  "pageLength": 2,
		  "lengthChange": false
	});

	$('#btnAceptarRol').on('click', function() {
		var idRol = $("#rols").find('tbody tr.selected').attr("data-id");
		if (idRol == null || idRol == "") {
			alert("idRol " +  idRol);
			$('#change_rol').closeModal();
		} else {
			var request = $.ajax({
									url: '/usuario/actualizar_rol',
											method: "POST",
											data: { id_rol: idRol },
											dataType: "JSON"
									});
					           		request.done(function( data ) {
					           					window.location.href="/" 
										});
										 
									request.fail(function( jqXHR, textStatus ) {
										  alert( "Fallo la Actualización. " + textStatus );
										});	
		};
	});

	$('#rols tbody').on('click', 'tr', function () {
		if ( $(this).hasClass('selected') ) {
		    $(this).removeClass('selected');
		}
		else {
		    table.$('tr.selected').removeClass('selected');
		    $(this).addClass('selected');
		}
	} );


    $('#form .alert-danger').hide();
    $('#form .alert-success').hide();
 	$(".button-collapse").sideNav({edge: 'left', });
	$('ul.tabs').tabs();
	$('select').not('.disabled').material_select();

	$('.modal-trigger').leanModal();
    $(".dropdown-toggle").dropdown();
    $('.dropdown-button').dropdown({
	      //constrain_width: false, // Does not change width of dropdown to that of the activator
	      //hover: false // Activate on click
	    }
	);
	$('.tooltipped').tooltip({delay: 50});
    $('.datepicker').pickadate({
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
        onSet: function () {
          this.close();
          },
      });

	$(function () {
	  $('[data-toggle="popover"]').popover()
	});

	$('.materialboxed').materialbox();

	$("#busqueda-trigger").click(function(){
		$("#top-search-bar").css("display","table");
	});
	$("#hide-search-bar, main").click(function(){
		$("#top-search-bar").css("display","none");
	});
	$(".toggler-wrapper a").click(function(){
		$("main").toggleClass("cerrado");
	});
    //$('.collapsible').collapsible();
   // $('[data-toggle="tooltip"]').tooltip();
    
    $('.submenu-trigger').click(function () {
  		if($(this).hasClass("menu-open"))
  			$(this).removeClass("menu-open").addClass("menu-close");
  		else
  			$(this).removeClass("menu-close").addClass("menu-open");
	});

    // $(".favoritear").click(function(){
    // 	if($(this).hasClass("fav"))
    // 		$(this).removeClass("fav");
    // 	else
    // 		$(this).addClass("fav");
    // });

	$(document).on("click",".favoritear",function(){
			$(this).toggleClass("fav");
	    });

    $('.collapsible').collapsible({ "accordion" : false });

      
	$(document).scroll(function() {
	  var y = $(this).scrollTop();
	  if (y > 100) {
	    $('.scroll-to-top').fadeIn();
	  } else {
	    $('.scroll-to-top').fadeOut();
	  }
	});




	$(".scroll-to-top").click(function(){
		$('html,body').animate({
          scrollTop: 0
        }, 1000);
	});

	$(".visualizador-contenido").click(function(){
		var c = "<a href='javascript:void(0)' class='modal-close'><i class='mdi-content-clear'></i></a>";
		var u = $(this).attr("data-url");
		var t = $(this).attr("data-contenido"); 
		switch(t){
			case "imagen":
				c = c.concat("<img class='galeria' src='"+u+"'/>");
				c = c.concat("<div class='controles block-center'><a target='_blank' href='"+u+"'>"+
						"<i class='mdi-action-launch'></i></a><a href='"+u+"' download>"+
						"<i class='mdi-file-cloud-download'></i></a><a href='javascript:void(0)'>"+
						"<i class='fa fa-info'></i></a><div>");
				break;
			case "video":
				c = c.concat("<video width='320' height='240' autoplay>"+
  						"<source src='//www.youtube.com/embed/Q-ezaxiKe-Y' type='video/mp4'>"+
						"Your browser does not support the video tag.</video>");

				break;
		}
		$("#visualizador").html(c);
		$("#visualizador").openModal({
	        complete: function() { 
	        	$("#visualizador").html("");
	        } 
		});
		
	});
});

