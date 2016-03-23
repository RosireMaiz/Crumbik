
var rolActual = null
var estructura = null;
var store_estructura = null;
var idactive = 0;
var nodeactive = null;
var objmenuderecho = null;
var objrootmenuderecho = null;
var primeravezmenuderecho = true;
var funcion = null;
var agregarnodo = null;
var eliminarnodo = null;
var editarnodo = null;

var menuderecho = null;
var rootmenuderecho = null;
var idRol = 1;
var tipoMenu=0;

Ext.require([
	         	'Ext.tree.*',
	         	'Ext.data.*', 
	         	'Ext.tip.*'
	         ]);

Ext.onReady(function() {
	Ext.QuickTips.init();
	         	
	Ext.fly(document.body).on("click", function(e) {
	    
	        if (!primeravezmenuderecho) {
			 	objmenuderecho.hide();
				objrootmenuderecho.hide();
			}
	    
	});
		$.get('/current_rol', function(result){
		 	idRolActual = result.idRolActual;
		});

		$('#select').on('change', function() {
			idRol = this.value;
			tipoMenu = $('#select_type_menu').val();
			if (idRol != null) {
				actualizar();	
			}
	
		});

		$('#select_type_menu').on('change', function() {
			idRol = $('#select').val();;
			tipoMenu =  this.value;;
			if (idRol != null) {
				actualizar();	
			}		
		});


		$('#btnGuardar').on('click', function(){
			if($("#add_nodo").valid()){
				var request = $.ajax({
									url: '/menu/actualizar',
											method: "POST",
											data: { idnodo: nodeactive.get('id'),
													funcion: funcion,
													nombre: $('#nombre').val(),
													icono: $('#icono').val(),
													url: $('#url').val(),
													padre_id: nodeactive.get('id')
												},
											dataType: "JSON"
									});
					           		request.done(function( data ) {

					           				if (idRolActual == idRol) {
					           			
					           					location.reload(); 

					           				}else{
					           					$('#ventanaEdicion').closeModal();
												actualizar();
					           				};
					           				
										});
										 
									request.fail(function( jqXHR, textStatus ) {
										  alert( "Request failed: " + textStatus );
										});
      		}           		

			
		});


		$('#btnAceptar').on('click', function(){
			
				var request = $.ajax({
									url: '/menu/actualizar',
											method: "POST",
											data: { idnodo: nodeactive.get('id'),
													funcion: funcion
												},
											dataType: "JSON"
									});
					           		request.done(function( data ) {
					           				if (idRolActual == idRol) {
					           					location.reload(); 	
					           				}else{
					           					$('#ventanaEliminar').closeModal();
												actualizar();
					           				};
					           				
										});
										 
									request.fail(function( jqXHR, textStatus ) {
										  alert( "Request failed: " + textStatus );
										});         		
		});


 		agregarnodo = Ext.create('Ext.Action', {                               	 
                               	 cls: "addnode",
								 glyph: 'xf055@FontAwesome',             
                                 text : 'Agregar Nodo',
                                 handler : function() {
									funcion="agregar";
									var request = $.ajax({
													  url: '/menu/consultar',
													  method: "POST",
													  data: { idnodo: nodeactive.get('id'),
															  funcion: funcion},
													  dataType: "JSON"
													});
									var icono = $('#iconoPicker > i').attr('class');                
                                 	$('h5#titulo').text("Agregar Nodo");       
									$('.modal .input-field > label').removeClass('active');
									$('#icono').val(icono);
									$('#nombre').removeClass('msj-error');
									$('#url').removeClass('msj-error');
									$('#nombre').removeClass('valid');									
									$('#url').removeClass('valid');
									$( "span.msj-error" ).remove();
									$('#nombre').css("text-transform"," capitalize");
									$('#nombre').val("");
									$('#url').val("");
									$('#url').css("text-transform"," lowercase");
									$('#ventanaEdicion').openModal();
									objmenuderecho.hide();
									objrootmenuderecho.hide();
                                 }
                                });

    	eliminarnodo = Ext.create('Ext.Action', {
                                 id: "delnode",
								 glyph: 'xf00d@FontAwesome',
                                 text : 'Eliminar Nodo',
                                 handler : function() {

									var request = $.ajax({
													  url: '/menu/consultar',
													  method: "POST",
													  data: { idnodo: nodeactive.get('id'),
															  funcion: funcion},
													  dataType: "JSON"
													});
					           		request.done(function( data ) {
					           			funcion = "eliminar"
					           			         var nombre = data.nombre;
												 var mensaje = "¿Seguro que desea ELIMINAR el nodo seleccionado (" + nombre.replace(/(?:^|\s)\S/g, function(a) { return a.toUpperCase(); }) + "), los nodos hijos también seran eliminados? ";
												 $('#mensajeEliminar').text(mensaje);
												 $('#ventanaEliminar').openModal();
										});
										 
									request.fail(function( jqXHR, textStatus ) {
										  alert( "Request failed: " + textStatus );
										});
                            		objmenuderecho.hide();

                                 }
                                });
								
	 	editarnodo = Ext.create('Ext.Action', {
                                 id: "editnode",
								 glyph: 'xf044@FontAwesome',
                                 text : 'Editar Nodo',
                                 handler : function() {
									funcion = "actualizar"
					           		var request = $.ajax({
													  url: '/menu/consultar',
													  method: "POST",
													  data: { idnodo: nodeactive.get('id'),
															  funcion: funcion},
													  dataType: "JSON"
													});
					           		request.done(function( data ) {
					           			

					           			         var nombre = data.nombre;
												 var icono = data.icono;
												 var url = data.url;
												 var res = icono.substring(3);
												 $('#nombre').removeClass('msj-error');
												 $('#url').removeClass('msj-error');
												
												 $('#nombre').removeClass('valid');									
												 $('#url').removeClass('valid');
												 $(' .modal .input-field > label').addClass('active');
										    	 $('h5#titulo').text("Editar Nodo");
												 $('#nombre').val(nombre);
												 $('#nombre').css("text-transform"," capitalize");
											 	 $('#icono').val(icono);
											 	 $( "span.msj-error" ).remove();
												 $('#iconoPicker > i').removeClass();
												 $('#iconoPicker > i').addClass(icono);
												 $('#iconoPicker').attr("data-icon", res);
												 $('#url').val(url);
												 $('#ventanaEdicion').openModal();
										});
										 
									request.fail(function( jqXHR, textStatus ) {
										  alert( "Request failed: " + textStatus );
										});
                            		objmenuderecho.hide();
       
                                 }
                                });

	  	menuderecho = Ext.define('App.MenuDerecho', { 
	    	            extend: 'Ext.menu.Menu',
	                  items : [agregarnodo, eliminarnodo, editarnodo]
	                 });

	  	rootmenuderecho = Ext.define('App.RootMenuDerecho', { 
	    	            extend: 'Ext.menu.Menu',
	                  items : [agregarnodo]
	                 });



	         });

function actualizar(){

			if (!primeravezmenuderecho) {
			 	objmenuderecho.hide();
				objrootmenuderecho.hide();
			}
			
			store_estructura = Ext.create('Ext.data.TreeStore', {
			         		proxy: {
			         			type: 'ajax',
			         			url: '/menu/cargar_estructura?idRol='+idRol+'&tipoMenu='+tipoMenu
			         		},
			         		root: {
			         			text: 'Menu',
			         			id: '0',
			         			cls: 'active waves-effect',
			         			expanded: true
			         		},
			         		folderSort: false,
			         		
			         	});

			estructura = Ext.create('Ext.tree.Panel', {
	         		id:"estructura",
	         		cls:'no-padding',
	         		store: store_estructura,
	         		renderTo: 'tree',
	         		border: false,
	         		titleVisible: false,
	         		useArrows: true,
	         		lines: false,
	         		autoScroll: true,
	         		containerScroll: true,
    				animated: true,

    				listeners: {
                        itemclick: function(view, node) {
		                        	nodeactive = node;
		 							idactive = $(node).attr('id');
		 							if (!primeravezmenuderecho) {
									 	objmenuderecho.hide();
										objrootmenuderecho.hide();
									}
                        },
	                    itemcontextmenu: function(view, r, node, index, e) {
											  e.stopEvent();
											  idactive = nodeactive.get('id');
				                              if (primeravezmenuderecho) {
					                               primeravezmenuderecho = false;
					                               objmenuderecho = Ext.create('App.MenuDerecho');
												   objrootmenuderecho =  Ext.create('App.RootMenuDerecho');
												   if(idactive == 0 ){
														objrootmenuderecho.showAt(e.getXY());
												   }else{
												   		objmenuderecho.showAt(e.getXY());
												   }
				                              }
				                              else {
					                               if(idactive == 0 ){
														objrootmenuderecho.showAt(e.getXY());
												   }else{
												   		objmenuderecho.showAt(e.getXY());
												   }

				                              }
										  	return false;
                            },
	         	       	
                    }
	         	});
	}