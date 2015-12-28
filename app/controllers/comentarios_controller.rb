class ComentariosController < ApplicationController

def create
	@comentario = Comentario.new(comentario_params)
	@comentario.usuario_id =  current_usuario.id
	@comentario.save
	id_producto = params[:comentario][:producto_id]
	redirect_to :controller => 'productos', :action => 'show', :id_producto  => id_producto
end

private
	 def comentario_params
      accessible = [ :comentario,  :producto_id  ] # extend with your own params
      params.require(:comentario).permit(accessible)
    end
end
