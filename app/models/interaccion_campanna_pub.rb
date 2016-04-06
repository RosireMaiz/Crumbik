class InteraccionCampannaPub < ActiveRecord::Base

	belongs_to :campanna_publicitaria_detalle, foreign_key: "campanna_detalle_id"
	
	belongs_to :usuario_ejecutivo,  class_name: "Usuario", foreign_key: "usuario_ejecutivo_id"


	has_many :interaccion_campanna_usuario, class_name: "InteraccionCampannaUsuario", foreign_key: "interaccion_campanna_id"
  	has_many :usuario, :through => :interaccion_campanna_usuario, foreign_key: "interaccion_campanna_id"


  	has_many :interaccion_campanna_social, class_name: "InteraccionCampannaSocial", foreign_key: "interaccion_campanna_id"
  	has_many :organizacion_red_social, :through => :interaccion_campanna_social, foreign_key: "interaccion_campanna_id"

end
