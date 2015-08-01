class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 	def ensure_signup_complete
 		# Ensure we don't go into an infinite loop
    	return if action_name == 'finish_signup'

	    # Redirect to the 'finish_signup' page if the user
	    # email hasn't been verified yet
	    if current_usuario && !current_usuario.email_verified? && !current_usuario.confirmacion_email
	      redirect_to finish_signup_path(current_usuario)
	    end
  end

  	
end
