class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable#, :confirmable

  has_many :autenticacions, dependent: :delete_all

  has_one :pais
  has_one :perfil
  has_one :organizacion, :inverse_of=>:usuario

  accepts_nested_attributes_for :organizacion
  accepts_nested_attributes_for :perfil
  accepts_nested_attributes_for :pais

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
          username: auth.info.name
        )

        usuario.save!
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
end
