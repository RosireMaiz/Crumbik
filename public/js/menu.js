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
	         		sorters: [{
	         			property: 'id',
	         			direction: 'ASC'
	         			
	         		}]
	         	});

	         	var tree = Ext.create('Ext.tree.Panel', {
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
    				animated: true
	         	});
	         });
