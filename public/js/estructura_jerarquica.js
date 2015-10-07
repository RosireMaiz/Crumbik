

 

var estructura = null;
var store_estructura = null;
var root = null;
var newNode = null;
var indexactive = 0;
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

		$('#select').on('change', function() {
			 idRol = this.value;
			 if (!primeravezmenuderecho) {
			 	objmenuderecho.hide();
				objrootmenuderecho.hide();
			}
			 store_estructura = Ext.create('Ext.data.TreeStore', {
			         		proxy: {
			         			type: 'ajax',
			         			url: '/menu/cargar_estructura?idRol='+idRol
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
				                              indexactive = index;
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

			
		 
		});

		$('#btnCancelar').on('click', function(){

			$('#ventanaEdicion').closeModal();

		});


 		agregarnodo = Ext.create('Ext.Action', {
                               	 
                               	 cls: "addnode",
								 glyph: 'xf055@FontAwesome',             
                                 text : 'Agregar nodo',
                                 handler : function() {
									funcion="agregar";                
                                 	$('legend#titulo').text("Agregar Nodo");       
									$(' .modal .input-field > label').removeClass('active')
									$('#nombre').val("");
									$('#nombre').css("text-transform"," capitalize");
 
									
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
                                 text : 'Eliminar nodo',
                                 handler : function() {
									funcion="eliminar";
									$('legend#titulo').text("Eliminar Nodo");
                                  
					           		$('#ventanaEdicion').openModal();
                                	objmenuderecho.hide();
                                 }
                                });
								
	 	editarnodo = Ext.create('Ext.Action', {
                                 id: "editnode",
								 glyph: 'xf044@FontAwesome',
								                
                                 text : 'Editar nodo',
                                 handler : function() {

					           		var request = $.ajax({
													  url: '/menu/consultar',
													  method: "POST",
													  data: { idnodo: nodeactive.get('id')},
													  dataType: "JSON"
													});
					           		request.done(function( data ) {
					           			funcion = "actualizar"
					           			         var nombre = data.nombre;
												 var icono = data.icono;
												 var url = data.url;
												 var res = icono.substring(2);
												 
												 $(' .modal .input-field > label').addClass('active');
										    	 $('legend#titulo').text("Editar Nodo");
												 $('#nombre').val(nombre);
												 $('#nombre').css("text-transform"," capitalize");
												  $("#icon").attr("name", res);
												  $('#icono > i').removeClass();
												  $('#icono > i').addClass(icono);
												  $('#icono').attr("data-icon", res);
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

