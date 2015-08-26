class Rol < ActiveRecord::Base
	has_many :usuario_rols, class_name: "UsuarioRol", foreign_key: "rol_id"
	has_many :usuarios, :through => :usuario_rols
	has_many :menus
end
