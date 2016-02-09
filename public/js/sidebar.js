
Ext.require([
	         	'Ext.tree.*',
	         	'Ext.data.*',
	         	'Ext.tip.*'
	         ]);

	         Ext.onReady(function() {
	         	Ext.QuickTips.init();

	$("#ext-element-3 .chat-vivo").click(function () {
	    $('#chat').addClass('popup-box-on');
	});

	         	var store = Ext.create('Ext.data.TreeStore', {
	         		proxy: {
	         			type: 'ajax',
	         			url: '/menu/portal'
	         		},
	         		root: {
	         			text: 'Menu',
	         			id: 'root_node',
	         			expanded: true
	         		},
	         		folderSort: false,
	         			
	         	});

	         	var tree = Ext.create('Ext.tree.Panel', {
	         		id:"tree_menu",
	         		store: store,
	         		cls:'no-padding',
	         		rootVisible: false,
	         		renderTo: 'tree_el',
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
		 							var idactive = $(node).attr('id');
		 							var request = $.ajax({
													  url: '/menu/consultar',
													  method: "POST",
													  data: { idnodo: nodeactive.get('id')},
													  dataType: "JSON"
													});
					           		request.done(function( data ) {
					           			

					           			         var nombre = data.nombre;
												
												 if (nombre == "Chat") {
												 	 $('#chat').addClass('popup-box-on');
												 };
										});
                        },
	         	       	
                    }
	         	});

		        
	         });

