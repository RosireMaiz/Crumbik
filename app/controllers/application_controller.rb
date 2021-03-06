require 'base64'
require 'rubygems' 
require 'twilio-ruby' 
require 'authy'
require 'rubygems'
require 'twitter'
$IMAGEN_DEFAULT = "app/assets/images/producto.png";
$FOTO_DEFAULT = "app/assets/images/avatar/sinfoto.jpg";
$LOGO_DEFAULT = "app/assets/images/header-logo.png";
$BANNER_DEFAULT = "app/assets/images/org-banner-construccion2.jpg";

Authy.api_key = 'eXSf1pyYNtbjrqEgX60TvQdp14Xn8Bnf'
Authy.api_uri = 'https://api.authy.com/'

$account_sid = 'ACc6b076d941741f47e46dfe041bd98eed' 
$auth_token = '4a8218fbf947e1865c470f7e2cb0d70c' 
$twilio_number = '+18594485515'

$consumer_key_twitter = 'iLW5ICM65xM9cO7npmEZRTSKz'
$consumer_secret_twitter = 'qXwz81sGgFPC09nFu9o17vo7HEhlIna9dnJ1xVlMTr9qldWCOm' 

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include SubdomainHelper  

  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_filter :set_mailer_url_options
  before_filter :load_db, :load_menu, :load_template

 	def ensure_signup_complete
 		# Ensure we don't go into an infinite loop
    	return if action_name == 'finish_signup'

	    # Redirect to the 'finish_signup' page if the user
	    # email hasn't been verified yet
	    if current_usuario && !current_usuario.email_verified? && !current_usuario.confirmacion_email
	      redirect_to finish_signup_path(current_usuario)
	    end
  end


  @menu

  @foto
  
  protected

  def after_sign_in_path_for(resource)
    return "/inicio"
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :current_password) }
  end
  
  private
    def load_db
      Apartment::Tenant.switch!()
      @organizacion = Organizacion.find_by(id: 0)
      return unless request.subdomain.present?
      organizacion = Organizacion.where(["subdominio = ?", request.subdomain]).pluck(:subdominio)
      if organizacion.length > 0
        @organizacion = Organizacion.find_by(subdominio: request.subdomain)
        Apartment::Tenant.switch!(request.subdomain)
      else
        redirect_to root_url(subdomain: false)
      end
    end

    def load_menu
      if usuario_signed_in?
        @foto = current_usuario.perfil.formato_foto + current_usuario.perfil.foto;
        @menuprueba = Menu.where(rol_id: current_usuario.rol_actual.id).first
      end
    end

    def load_template
      @style = "template/template-rosa.css"
      if !@organizacion.tema.blank?
        @style = "template/template-"+@organizacion.tema.to_s + ".css"
      end
    end
  	
end
