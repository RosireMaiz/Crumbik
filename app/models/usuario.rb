require "base64"
$ADMIN_ICON = "app/assets/images/avatar/sinfoto.jpg";
class Usuario < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :autenticacions, dependent: :delete_all

  belongs_to :pais
  has_one :perfil
  has_one :organizacion, :inverse_of=>:usuario

  has_many :usuario_rols, class_name: "UsuarioRol", foreign_key: "usuario_id"
  has_many :rols, :through => :usuario_rols

  accepts_nested_attributes_for :organizacion
  accepts_nested_attributes_for :perfil
  accepts_nested_attributes_for :pais

  

  attr_accessor :rol_actual
  @rol_actual

  after_initialize :set_rol_actual

  def self.find_for_oauth(auth, signed_in_resource = nil)
    autenticacion = Autenticacion.find_for_oauth(auth)
    usuario = signed_in_resource ? signed_in_resource : autenticacion.usuario
 
    if usuario.nil?
      email = auth.info.email
      usuario = Usuario.find_by(email: email) if email

      # Create the usuario if it's a new registration
      if usuario.nil?
        password = Devise.friendly_token[0,20]
        
        usuario = Usuario.new(
          email: email ? email : "#{auth.uid}@change-me.com",
          password: password,
          password_confirmation: password, 
          username: auth.info.name,
        )


        formato = "data:image/jpg;base64,"
        foto_perfil = Base64.encode64(File.open($ADMIN_ICON, "rb").read)
        @rol = Rol.where("nombre = ?", "Cliente").first 
        usuario.build_perfil
        
        usuario.perfil.attributes  = {:foto => foto_perfil, :formato_foto => formato}
        
        usuario.save!
        @nuevo = usuario.usuario_rols.build(:rol => @rol)
        @nuevo.save  
      end    
      
    end
 
    if autenticacion.usuario != usuario
      autenticacion.usuario = usuario
      autenticacion.save!
    end
    
    usuario
  end
 
  def email_verified?
    if self.email
      if self.email.split('@')[1] == 'change-me.com'
        return false
      else
        return true
      end
    else
      return false
    end
  end

  private
    def set_rol_actual
      if !self.rols[0].blank?
        if !self.current_rol_id.nil?
          rol = Rol.find_by("id = ? ", self.current_rol_id)
          self.rol_actual = rol #self.rols[0]
        else
          self.current_rol_id = self.rols[0].id
          self.rol_actual = self.rols[0]
        end
      end
    end
  
end
