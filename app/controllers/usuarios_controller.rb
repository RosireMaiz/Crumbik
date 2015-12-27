require "base64"
class UsuariosController < ApplicationController

	def validar_email
		if Usuario.exists?(email: params[:usuario][:email])
			render json: false
		else
			render json: true
		end
	end
	
	def validar_email_update
		if Usuario.exists?( ["email = ? AND  id <> ? ",  params[:usuario][:email], current_usuario.id ])
			render json: false
		else
			render json: true
		end
	end

	def current_rol
    	render json: {idRolActual: current_usuario.rol_actual.id}
	end

	def new
		if usuario_signed_in?
			redirect_to root_path
		else
			@usuario = Usuario.new
			if request.subdomain.present?
				render "devise/registrations/new"
			else
				@usuario.build_organizacion
				@usuario.build_perfil				
				@usuario.organizacion.contratos.build
				render "usuarios/new"
			end
		end
	end

	def new_user
		if !usuario_signed_in?
			redirect_to root_path
		else
			@usuario = Usuario.new
			if request.subdomain.present?
				render "devise/registrations/new"
			else
				@usuario.build_perfil				
				@usuario.rols.build
				render "usuarios/new_portal"
			
			end
		end
	end


	def create
    	formato = "data:image/jpg;base64,"
    	formato_logo = "data:image/png;base64,"
    	formato_banner = "data:image/jpg;base64,"
    	foto_perfil = Base64.encode64(File.open($FOTO_DEFAULT, "rb").read)
    	logo_organizacion = Base64.encode64(File.open($LOGO_DEFAULT, "rb").read)
    	banner_organizacion = Base64.encode64(File.open($BANNER_DEFAULT, "rb").read)

		@rol = Rol.where("nombre = ?", "Empresario").first 
		@usuario = Usuario.new(usuario_params_organizacion)

		@usuario.perfil.attributes  = {:foto => foto_perfil, :formato_foto => formato}
		@usuario.organizacion.attributes  = {:logo => logo_organizacion, :formato_logo => formato_logo, :formato_banner => formato_banner, :banner => banner_organizacion}
		# @pago = Pago.new
		# @pago.monto =  params[:pago][:monto]
		# @pago.modo_pago = ModoPago.find(params[:modo_pago])
		# @usuario
		@respuesta = Hash.new
	    if @usuario.save

	    	@nuevo = @usuario.usuario_rols.build(:rol => @rol)
    		@nuevo.save 	

			@respuesta["codigo"] = 200
	       	@respuesta["url"] = entrar_url(:subdomain => @usuario.organizacion.subdominio)
	       	
	       	Apartment::Tenant.switch!(@usuario.organizacion.subdominio )
			
			@usuarionuevo = Usuario.new(usuario_params)
			@usuarionuevo.perfil.attributes  = {:foto => foto_perfil, :formato_foto => formato}
			@usuarionuevo.save

			@nuevo_rol = @usuarionuevo.usuario_rols.build(:rol => @rol) 
    		@nuevo_rol.save
			Apartment::Tenant.switch()	

	    else  
	       @respuesta["codigo"] = 500
	       @respuesta["errores"] = @usuario.errors.full_messages
	    end  
	    render json: @respuesta
	end

	def create_portal
		formato = "data:image/jpg;base64,"
    	foto_perfil = Base64.encode64(File.open($FOTO_DEFAULT, "rb").read)
    	@usuario = Usuario.new(usuario_params_rols)
		@usuario.perfil.attributes  = {:foto => foto_perfil, :formato_foto => formato}
		@usuario.save
		redirect_to :controller => 'usuarios', :action => 'usuarios'
	end

	def usuarios
		if !usuario_signed_in?
        	render "portal/index"
     	else

	        @rol =  Rol.where(nombre: 'Administrador del sistema')
	        
	        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

	        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
	          render "portal/index_principal"
	        else
	           @usuarios = Usuario.order('id ASC').page(params[:page]).per(9)
	           @valor = true;
	           render "usuarios/usuarios_portal"	
	        end
         
     	end
	end

	def show
		if  params[:id].present?
			@u_id = params[:id]
			usua = Usuario.where("id = ?", @u_id)
			usua.each do |usuario|
				@usuario = usuario;
			end
		else
			@usuario = current_usuario
		end
		@usuredes = UsuarioRedSocial.includes(:red_social).where("usuario_id = ?", @usuario.id)
	end

	def edit
			if usuario_signed_in? 

				@usuario = current_usuario

				@usuredes = UsuarioRedSocial.includes(:red_social).where("usuario_id = ?", @usuario.id)
				@red_socials = RedSocial.where("estatus = ?", 'A')
			else
				redirect_to root_path
			end	
	end

	def save

		 @usuario = current_usuario

		 @usuario.update(usuario_params)


		 @perfil = Perfil.where("usuario_id = ?", @usuario.id)

		 @perfil.each do |per|
		 	@perfil = per
		 end

		 @perfil.nombres = params[:usuario][:perfil_attributes][:nombres]
		 @perfil.apellidos = params[:usuario][:perfil_attributes][:apellidos]
		 @perfil.sexo = params[:usuario][:perfil_attributes][:sexo]
		 @perfil.ocupacion = params[:usuario][:perfil_attributes][:ocupacion]
		 @perfil.save

		 id_usuario = @usuario.id
		 
		 if ! params[:usuario][:red_social_attributes].blank?
		 	redes_sociales = params[:usuario][:red_social_attributes][:actual]

			if ! redes_sociales.nil?
				redes_sociales.each do |red_social|
				 	id = red_social[0]
				 	url = red_social[1]
				 	red_social_org = UsuarioRedSocial.where("id = ?", id).first
				 	if url.nil? || url == ""
						red_social_org.destroy
				 	else
				 		red_social_org.update(:url => url)
				 	end
				end
			end

			redes_sociales_nuevas = params[:usuario][:red_social_attributes][:nueva]

			if ! redes_sociales_nuevas.nil?

				redes_sociales_nuevas.each do |red_social_nueva|
					id = red_social_nueva[0]
			 		url = red_social_nueva[1]
			 		
			 		if ! url.nil?
			 			red_social_org = UsuarioRedSocial.new
			 			red_social_org.url = url
			 			red_social_org.red_social_id = id
			 			red_social_org.usuario_id = id_usuario
			 			red_social_org.save
			 		end
			  	end
			end

		 end

		

		 @usuario = Usuario.find_by(id: current_usuario.id)
		 @usuredes = UsuarioRedSocial.includes(:red_social).where("usuario_id = ?", @usuario.id)

		 redirect_to :controller => 'usuarios', :action => 'show'
	end

	def save_foto
	
		@usuario = current_usuario

		  @perfil = Perfil.where("usuario_id = ?", @usuario.id)
		  @perfil.each do |per|
		  	@perfil = per
		  end
			
		  #Archivo subido por el usuario.
	      archivo = params[:avatar_id]

 		  formato = "data:"+ archivo.content_type+";base64,"
		  foto_perfil = Base64.encode64(File.open(archivo.tempfile, "rb").read)

    	  @perfil.foto = foto_perfil

    	  @perfil.formato_foto = formato

    	  @perfil.save
		
		redirect_to :controller => 'usuarios', :action => 'edit'
	end



	def finish_signup
	    if request.patch? && params[:usuario] # Revisa si el request es de tipo patch, es decir, llenaron el formulario y lo ingresaron
	     
	      @usuario = Usuario.find_by(email: params[:usuario][:email])  

	      if @usuario.nil?
	        @usuario = Usuario.find(params[:id])
	      else
	        @usuarioid = Usuario.find(params[:id])

	        if @usuarioid.id != @usuario.id

	          autenticacion = Autenticacion.where("usuario_id = ?", @usuarioid.id).first
	          autenticacion.attributes = {:usuario_id => @usuario.id}
	          autenticacion.save
	          @usuarioid.destroy

	        end
	        
	      end
	      @usuario.attributes = {:confirmacion_email => true}
	      @usuario.save
	      
	      if @usuario.update(usuario_params)
	      	
	        sign_in(@usuario, :bypass => true)
	        redirect_to root_path, notice: 'Hemos guardado tu informacion correctamente.'
	      else
	        @show_errors = true
	      end
	    end
  	end
 
  private
  	def set_user
	    @usuario = Usuario.find(params[:id])
	 end

    def usuario_params
      accessible = [ :email, :username,  :pais_id ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:usuario][:password].blank?
      params.require(:usuario).permit(accessible)
    end

   	def usuario_params_organizacion
	    accessible = [ :email, :username, :perfil_attributes =>[ :nombres, :apellidos], :organizacion_attributes => [ :id, :nombre, :descripcion, :subdominio, :pais_id, :tipo_organizacion_id ] ] # extend with your own params
	    accessible << [ :password, :password_confirmation ] unless params[:usuario][:password].blank?
	    params.require(:usuario).permit(accessible)
	end
    
   def usuario_params_rols
	    accessible = [ :email, :username, :pais_id, :perfil_attributes =>[ :nombres, :apellidos, :sexo],  :rol_ids => [] ] # extend with your own params
	    accessible << [ :password, :password_confirmation ] unless params[:usuario][:password].blank?
	    params.require(:usuario).permit(accessible)
	end

end
