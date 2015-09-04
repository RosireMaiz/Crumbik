class MenuController < ApplicationController

 def index
 end

 def ajax
	@opcionMenus = OpcionMenu.new
	@tira = @opcionMenus.BuscarTodosArbolJson(@menuprueba)
	render :text => @tira
 end
 
end