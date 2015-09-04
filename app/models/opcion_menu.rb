class OpcionMenu < ActiveRecord::Base
	belongs_to :menu, class_name: "Menu", foreign_key: "menu_id"
	has_many :hijos, class_name: "OpcionMenu", foreign_key: "padre_id"
	belongs_to :padre, class_name: "OpcionMenu"
	default_scope { order('orden ASC') }



 @@nro=0

  #ContarHijos, Usado por el metodo: BuscarTodosArbolJson
  def ContarHijos(menu,padreid)
   @opcionMenus = OpcionMenu.all   
   @son=0
   @i=1
   @opcionMenus.each do |arbol|   
   	if arbol.menu_id.to_i==menu.id.to_i and arbol.padre_id.to_i==padreid.to_i
   	 @son=@son+1
   	 @i=@i+1;
   	end
   end
   return @son 
  end
  
  #ObtenerHijos, Usado por el metodo: BuscarTodosArbolJson
  def ObtenerHijos(menu,padreid)
	 totaldeRegistros1 = self.ContarHijos(menu,padreid)
	 if totaldeRegistros1>0
	  @tira = @tira+"  children: [ "
	  @opcionMenus = OpcionMenu.where("menu_id = ? AND padre_id = ?", menu.id.to_s, padreid).order(orden: :asc)
	  i=0
	  @opcionMenus.each do |arbol|
     @tira = @tira+" { text: ' <i class= \" " + arbol.icono.to_s + "\"  ></i> <span class= \"no-padding\"> " + arbol.nombre +  " </span>', cls:'no-padding',id: '" + arbol.id.to_s  + "',  href: '" + arbol.url.to_s  + "', "
	   self.ObtenerHijos(menu,arbol.id)
	   i=i+1
     if i<totaldeRegistros1
      @tira = @tira+" }, "
     else
      @tira = @tira+" } ] "
	   end
	  end
	 else
	  @tira = @tira+"  leaf: true  "
	 end
  end
	
  #Buscar todos los nodos y generar en formato JSON para Ext.tree.Panel
  def BuscarTodosArbolJson(menu)
    @opcionMenus = OpcionMenu.new
    @opcionMenus = OpcionMenu.where("menu_id = ? AND padre_id = ?", menu.id, 0).order(orden: :asc)
    totaldeRegistros = @opcionMenus.length;
    @tira='[ '
    if totaldeRegistros>0            
  	  j=0
  		@opcionMenus.each do |arbol|
      if arbol.hijos.length >0
        @tira = @tira+" { text: '<i class= \" " + arbol.icono.to_s + "\" ></i> <span > " + arbol.nombre + " </span> ', cls: 'active waves-effect ', expanded: false, id: '" + arbol.id.to_s  + "', href: '', "
      else
        @tira = @tira+" { text: '<i class= \" " + arbol.icono.to_s + "\" ></i> <span > " + arbol.nombre + " </span> ', cls: 'active waves-effect ', expanded: false, id: '" + arbol.id.to_s  + "', href: '" + arbol.url.to_s  +  "', "
      end
  		 
  		self.ObtenerHijos(menu,arbol.id)
  		j=j+1
      if j<totaldeRegistros
        @tira = @tira+ " }, "
      else
        @tira = @tira+" } ] "
  		end
  	end
  	else
  		@tira= @tira+"{ { text: 'No hay datos', id: '" + total.to_s + "', href: '', leaf: true } } ]"
  	end
  	return @tira
  end
  	
end
