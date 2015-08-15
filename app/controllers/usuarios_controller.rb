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
				@usuario.build_organizacion
				@usuario.build_perfil
				#@usuario.organizacion.contratos.build
				render "usuarios/new"
			end
		end
	end

	def create
		@usuario = Usuario.new(usuario_params)
		# @pago = Pago.new
		# @pago.monto =  params[:pago][:monto]
		# @pago.modo_pago = ModoPago.find(params[:modo_pago])
		# @usuario
		@respuesta = Hash.new
	    if @usuario.save 	    	
	       @respuesta["codigo"] = 200
	       @respuesta["url"] = entrar_url(:subdomain => @usuario.organizacion.subdominio)
	    else  
	       @respuesta["codigo"] = 500
	       @respuesta["errores"] = @usuario.errors.full_messages
	    end  
	    render json: @respuesta
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
    def usuario_params
      accessible = [ :name, :email, :username ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:usuario][:password].blank?
      params.require(:usuario).permit(accessible)
    end

   	def usuario_params_organizacion
	    accessible = [ :nombre, :apellido, :email,:organizacion_attributes => [ :id, :nombre, :descripcion, :subdominio] ] # extend with your own params
	    accessible << [ :password, :password_confirmation ] unless params[:usuario][:password].blank?
	    params.require(:usuario).permit(accessible)
	end
    
end
