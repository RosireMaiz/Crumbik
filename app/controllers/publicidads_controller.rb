require "base64"
$IMAGEN_DEFAULT = "app/assets/images/producto.png";
class PublicidadsController < ApplicationController

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			if !request.subdomain.present?
				redirect_to root_path
			else
				@publicidad = Publicidad.new
				formato_imagen = "data:image/png;base64,"
    			imagen = Base64.encode64(File.open($IMAGEN_DEFAULT, "rb").read)
    			@publicidad.formato_imagen = formato_imagen
    			@publicidad.imagen = imagen
				render "publicidads/new"
			end
		end
	end

	def create
		publicidad = Publicidad.new(publicidad_params)
	    publicidad.save
	  	redirect_to :controller => 'publicidads', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else

	        @rol =  Rol.where(nombre: 'Empresario')
	        
	        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

	        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
	          render root_path
	        else
	           publicidads = Publicidad.order('id ASC').page(params[:page]).per(9)
	           render "publicidads/publicidads"	
	        end
         
     	end
	end

	def edit
		if !usuario_signed_in?
			redirect_to root_path
		else
			if !request.subdomain.present?
				redirect_to root_path
			else
				id = params[:id_publicidad]
				publicidad = Publicidad.where("id = ?", id).first	
				render "publicidads/edit"
			end
		end
	end

	def save_edit
		id = params[:publicidad_id]

		publicidad_edit = Publicidadd.where(["id = ?", id]).first
		
		publicidad_edit.update(publicidad_params)

		redirect_to :controller => 'publicidads', :action => 'consultar'
	end

	def update_estatus
		id = params[:idpublicidad]
		estatus = params[:estatus]
		if Publicidad.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end


	def eliminar
		id = params[:idpublicidad]
		publicidad = Publicidad.where(id: id).first
		publicidad.destroy
      if publicidad.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	private
	 def publicidad_params
      accessible = [ :descripcion,  :formato_imagen, :imagen, :producto_id  ] # extend with your own params
      params.require(:publicidad).permit(accessible)
    end
end
