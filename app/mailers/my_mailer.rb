class MyMailer < Devise::Mailer 

require 'base64'
  helper :application # gives access to all helpers defined within `application_helper`.
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    custom_options(opts)
    super
  end

  def reset_password_instructions(record, token, opts={})
	custom_options(opts)
    super
  end

  def unlock_instructions(record, token, opts={})
    custom_options(opts)
    super
  end

  private

  def custom_options(opts)
  	if Apartment::Tenant.current != "crum"
  		@subdominio = Apartment::Tenant.current
  		Apartment::Tenant.switch!()
  		@organizacion =  Organizacion.where("subdominio = ?", Apartment::Tenant.current.to_s).first
  		@nombre = @organizacion.nombre
  		Apartment::Tenant.switch!(@subdominio)
  	else
  		@nombre = Apartment::Tenant.current
  	end
  	opts[:from] = I18n.t('devise.mailer.from', name: @nombre)
  end

end