 # app/controllers/registrations_controller.rb

class RegistrationsController < Devise::RegistrationsController 

   # GET /resource/sign_up
  def new
    super
  end

  def create
    build_resource(sign_up_params)
    formato = "data:image/jpg;base64,"
    foto_perfil = Base64.encode64(File.open($FOTO_DEFAULT, "rb").read)
    @rol = Rol.where("nombre = ?", "Cliente").first 
	
    resource.build_perfil
	
  	resource.perfil.attributes  = {:foto => foto_perfil, :formato_foto => formato}
    resource.save
    yield resource if block_given?
    if resource.persisted?
      @nuevo = resource.usuario_rols.build(:rol => @rol)
      @nuevo.save   
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end

  end

  # GET /resource/edit
  def edit
    super
  end


end