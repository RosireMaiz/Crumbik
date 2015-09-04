require "base64"
$ADMIN_ICON = "app/assets/images/avatar/sinfoto.jpg";
$ADMIN_ICONC = "app/assets/images/header-logo.png";


class UsuariosController < ApplicationController

	def validar_email
		if Usuario.exists?(email: params[:usuario][:email])
			render json: false
		else
			render json: true
		end
	end

	def new
		if usuario_signed_in?
			redirect_to root_path
		else
			@usuario = Usuario.new
			if request.subdomain.present?
				render "devise/registrations/new"
			else
				@rol = Rol.where("nombre = ?", "Empresario").first  
				@usuario.build_organizacion
				@usuario.build_perfil				
				#@usuario.organizacion.contratos.build
				render "usuarios/new"
			end
		end
	end

	def create
    	formato = "data:image/jpg;base64,"
    	formato_logo = "data:image/png;base64,"
    	foto_perfil = Base64.encode64(File.open($ADMIN_ICON, "rb").read)
    	logo_organizacion = Base64.encode64(File.open($ADMIN_ICONC, "rb").read)

		@rol = Rol.where("nombre = ?", "Empresario").first 
		@usuario = Usuario.new(usuario_params_organizacion)

		@usuario.perfil.attributes  = {:foto => foto_perfil, :formato_foto => formato}
		@usuario.organizacion.attributes  = {:logo => logo_organizacion, :formato_logo => formato_logo}
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
		#usuredes = UsuarioRedSocial.includes(:red_social).where("usuario_id = ?", @usuario.id)
	end

	def edit
			if usuario_signed_in? 

				@usuario = current_usuario

			else
				redirect_to root_path
			end	
	end

	def save

		 @usuario = current_usuario

		 @usuario.update(usuario_params_organizacion)

		 if ! params[:usuario][:perfil_attributes][:googleplus].nil?
		 		red_social = RedSocial.find_by(nombre: 'googleplus')
		 	
		 		usuarioR = UsuarioRedSocial.where("usuario_id = ? and red_social_id = ?", current_usuario.id, red_social.id)
		 		usuarioR.each do |us|
		 			usuarioR = us
		 		end

		 		if ! usuarioR.nil?
		 			usuarioR.valor = params[:usuario][:perfil_attributes][:googleplus]
		 			usuarioR.save
		 		else 
			 		usuarioR = UsuarioRedSocial.new
			 		usuarioR.usuario_id = current_usuario.id
			 		usuarioR.red_social_id = red_social.id
			 		usuarioR.valor = params[:usuario][:perfil_attributes][:googleplus]
			 		usuarioR.save
		 		end
		 end
		 if ! params[:usuario][:perfil_attributes][:facebook].nil?

		 	red_social = RedSocial.find_by(nombre: 'facebook')
		 	
		 		usuarioR = UsuarioRedSocial.where("usuario_id = ? and red_social_id = ?", current_usuario.id, red_social.id)
		 		usuarioR.each do |us|
		 			usuarioR = us
		 		end

		 		if ! usuarioR.nil?
		 			usuarioR.valor = params[:usuario][:perfil_attributes][:facebook]
		 			usuarioR.save
		 		else 
			 		usuarioR = UsuarioRedSocial.new
			 		usuarioR.usuario_id = current_usuario.id
			 		usuarioR.red_social_id = red_social.id
			 		usuarioR.valor = params[:usuario][:perfil_attributes][:facebook]
			 		usuarioR.save
		 		end

		 end
		 if ! params[:usuario][:perfil_attributes][:twitter].nil?

		 	red_social = RedSocial.find_by(nombre: 'twitter')
		 	
		 		usuarioR = UsuarioRedSocial.where("usuario_id = ? and red_social_id = ?", current_usuario.id, red_social.id)
		 		usuarioR.each do |us|
		 			usuarioR = us
		 		end

		 		if ! usuarioR.nil?
		 			usuarioR.valor = params[:usuario][:perfil_attributes][:twitter]
		 			usuarioR.save
		 		else 
			 		usuarioR = UsuarioRedSocial.new
			 		usuarioR.usuario_id = current_usuario.id
			 		usuarioR.red_social_id = red_social.id
			 		usuarioR.valor = params[:usuario][:perfil_attributes][:twitter]
			 		usuarioR.save
		 		end

		 end
		 if ! params[:usuario][:perfil_attributes][:linkedin].nil?

		 	red_social = RedSocial.find_by(nombre: 'linkedin')
		 	
		 		usuarioR = UsuarioRedSocial.where("usuario_id = ? and red_social_id = ?", current_usuario.id, red_social.id)
		 		usuarioR.each do |us|
		 			usuarioR = us
		 		end

		 		if ! usuarioR.nil?
		 			usuarioR.valor = params[:usuario][:perfil_attributes][:linkedin]
		 			usuarioR.save
		 		else 
			 		usuarioR = UsuarioRedSocial.new
			 		usuarioR.usuario_id = current_usuario.id
			 		usuarioR.red_social_id = red_social.id
			 		usuarioR.valor = params[:usuario][:perfil_attributes][:linkedin]
			 		usuarioR.save
		 		end

		 end

		 if ! params[:usuario][:perfil_attributes][:github].nil?

		 	red_social = RedSocial.find_by(nombre: 'github')
		 	
		 		usuarioR = UsuarioRedSocial.where("usuario_id = ? and red_social_id = ?", current_usuario.id, red_social.id)
		 		usuarioR.each do |us|
		 			usuarioR = us
		 		end

		 		if ! usuarioR.nil?
		 			usuarioR.valor = params[:usuario][:perfil_attributes][:github]
		 			usuarioR.save
		 		else 
			 		usuarioR = UsuarioRedSocial.new
			 		usuarioR.usuario_id = current_usuario.id
			 		usuarioR.red_social_id = red_social.id
			 		usuarioR.valor = params[:usuario][:perfil_attributes][:github]
			 		usuarioR.save
		 		end

		 end


		@usuario = Usuario.find_by(id: current_usuario.id)
		@usuredes = UsuarioRedSocial.includes(:red_social).where("usuario_id = ?", @usuario.id)

		render "usuarios/show"
	end

	def save_foto
		dir = "public/systems/"+ request.subdomain + "/avatar"

		@usuario = current_usuario

		  @perfil = Perfil.where("usuario_id = ?", @usuario.id)
		  @perfil.each do |per|
		  	@perfil = per
		  end

		  #Archivo subido por el usuario.
	      archivo = params[:avatar_id]
	      #Nombre original del archivo.
	      nombre = archivo.original_filename


	      #Extensión del archivo.
	      extension = nombre.slice(nombre.rindex("."), nombre.length).downcase

	       #Nombre original del archivo.
	      nombre = @usuario.id.to_s + extension
	      
	     archivo.original_filename = nombre


         #Ruta del archivo.
         path = File.join(dir, nombre)
         #Crear en el archivo en el directorio. Guardamos el resultado en una variable, será true si el archivo se ha guardado correctamente.
         resultado = File.open(path, "wb") { |f| f.write(archivo.read) }
         #Verifica si el archivo se subió correctamente.

    	  @perfil.foto = nombre

    	  @perfil.save
		
		render "/usuarios/edit"



		# def cleanup
  #   File.delete("#{RAILS_ROOT}/dirname/#{@filename}") 
  #           if File.exist?("#{RAILS_ROOT}/dirname/#{@filename}")
  # 		end
		
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
      accessible = [ :email, :username, :perfil_attributes =>[ :nombres, :apellidos] ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:usuario][:password].blank?
      params.require(:usuario).permit(accessible)
    end

   	def usuario_params_organizacion
	    accessible = [ :email, :username, :perfil_attributes =>[ :nombres, :apellidos], :organizacion_attributes => [ :id, :nombre, :descripcion, :subdominio] ] # extend with your own params
	    accessible << [ :password, :password_confirmation ] unless params[:usuario][:password].blank?
	    params.require(:usuario).permit(accessible)
	end
    

end
