class UsuarioRedSocial < ActiveRecord::Base
	belongs_to :usuario
  	belongs_to :red_social
end
