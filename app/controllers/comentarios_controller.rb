class ComentariosController < ApplicationController

def create
	@comentario = Interaccion.new(comentario_params)
	@comentario.usuario_id =  current_usuario.id
	@comentario.tipo_interaccion =  Interaccion.tipo_interaccions["comentario"]
	@comentario.save
	id_producto = params[:comentario][:producto_id]
	if request.subdomain.present?
		redirect_to :controller => 'productos', :action => 'show', :id_producto  => id_producto
	else
		redirect_to :controller => 'plans', :action => 'show', :id_plan => id_producto
	end
	
end

private
	 def comentario_params
      accessible = [ :contenido,  :producto_id  ] # extend with your own params
      params.require(:comentario).permit(accessible)
    end
end
