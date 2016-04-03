class MyMailer < Devise::Mailer 
  default from: "from@example.com"
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
  	if Apartment::Tenant.current != "crumbik"
  		@subdominio = Apartment::Tenant.current
  		Apartment::Tenant.switch!()
  		@organizacion =  Organizacion.find_by("subdominio = ?", Apartment::Tenant.current.to_s)
  		@nombre = @organizacion.nombre
  		Apartment::Tenant.switch!(@subdominio)
  	else
      @organizacion =  Organizacion.find_by("id = ?", 0)
      @nombre = @organizacion.nombre
  	end
  	opts[:from] = I18n.t('devise.mailer.from', name: @nombre)
  end

end