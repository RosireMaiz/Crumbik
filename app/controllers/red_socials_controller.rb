class RedSocialsController < ApplicationController
	def validar_red_social
	    if RedSocial.exists?(nombre: params[:red_social][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def validar_red_social_update
	    if RedSocial.exists?(  ["nombre = ? AND  id <> ? ", params[:red_social][:nombre], params[:idredsocial] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@red_social = RedSocial.new
			if request.subdomain.present?
				render  root_path
			else
				render "red_socials/new"
			end
		end
	end

	def create
		@red_social = RedSocial.new(red_social_params)
		@red_social.save
		redirect_to :controller => 'red_socials', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else

	        @rol =  Rol.where(nombre: 'Administrador del sistema')
	        
	        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

	        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
	          render "portal/index_principal"
	        else
	           @red_socials = RedSocial.order('id ASC')
	           @valor = true;
	           render "red_socials/red_socials"	
	        end
         
     	end
	end
	
	def update_estatus
		id = params[:idredsocial]
		estatus = params[:estatus]
		if RedSocial.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def update
		id = params[:idredsocial]
		nombre = params[:nombre]
		icono = params[:icono]
		if RedSocial.exists?(  ["nombre = ? AND  id <> ? ", nombre, id]) 
			render :text =>'{ "success" : "true", "existe" : "true" }'
		else

			if RedSocial.update(id, :nombre => nombre, :icono => icono)
				render :text =>'{ "success" : "true", "existe" : "false"}'
			else
				render :text => '{ "success" : "false"}'
			end
		end
	end

	def eliminar
		id = params[:idredsocial]
		red_social = RedSocial.where(id: id).first
		red_social.destroy
      if red_social.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_red_social
		id = params[:idredsocial]
		@red_social = RedSocial.where(id: id).first
		render :json => @red_social
	end

	private
		def red_social_params
	      accessible = [ :nombre, :icono, :color] # extend with your own params
	      params.require(:red_social).permit(accessible)
	    end

end
