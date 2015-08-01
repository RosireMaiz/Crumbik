class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    @usuario = Usuario.find_for_oauth(env["omniauth.auth"], current_usuario)
 
    if @usuario.persisted? # Chequea que nuestro usuario se haya guardado en la base de datos y no sea una instancia superficial
      flash[:notice] = "You are in..!!! Go to edit profile to see the status for the accounts"
      sign_in_and_redirect @usuario, event: :authentication
      
    else
     session["devise.usuario_attributes"] = usuario.attributes
      redirect_to new_usuario_registration_url
    end
  end

  def after_sign_in_path_for(resource) # Revisa después de cada login si el mail del usuario es válido

    if resource.confirmacion_email
      super resource # Acción por defecto de Devise (si no está configurada, va al root_path)
   else
      finish_signup_path(resource)
    end
  end
 
  alias_method :facebook, :all
  alias_method :twitter, :all
  alias_method :linkedin, :all
  alias_method :github, :all
  alias_method :passthru, :all
  alias_method :google_oauth2, :all
end