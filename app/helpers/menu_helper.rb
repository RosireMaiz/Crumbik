module MenuHelper
	def construir menu
		codigo = "<ul>"
		menu.opcionmenu.each do |item|
			if item.hijos.length > 0
				codigo << "<li><a href='#submenu-#{item.id}' class='submenu-trigger' data-toggle='collapse'>"
				codigo << "<i class='#{item.icono.to_s}'></i> <span>#{item.nombre}</span></a>"
				codigo << "<div id='submenu-#{item.id}' class='collapsible collapse'>"
				codigo << "<ul class='submenu'>"
				item.hijos.each do |hijo|
					codigo << "<li><a href='#{hijo.url}'><i class='#{hijo.icono.to_s}'></i> <span>#{hijo.nombre}</span></a></li>"
				end
				codigo << "</ul></div></li>"
			else
				codigo << "<li><a href='#{item.url}'><i class='#{item.icono.to_s}'></i><span>#{item.nombre}</span></a></li>"
			end
		end
		codigo << "</ul>"

		raw(codigo)
	end
end