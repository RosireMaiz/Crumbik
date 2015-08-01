class UsuariosController < ApplicationController

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
    
end
