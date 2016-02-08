
Ext.require([
	         	'Ext.tree.*',
	         	'Ext.data.*',
	         	'Ext.tip.*'
	         ]);

	         Ext.onReady(function() {
	         	Ext.QuickTips.init();



	         	var store = Ext.create('Ext.data.TreeStore', {
	         		proxy: {
	         			type: 'ajax',
	         			url: '/menu/ajax'
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
	         	});

		        
	         });

/*function actualizarMenu(){
			//$("#tree_menu").remove();
			var store = Ext.create('Ext.data.TreeStore', {
	         		proxy: {
	         			type: 'ajax',
	         			url: '/menu/ajax'
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
	         	});
	}*/