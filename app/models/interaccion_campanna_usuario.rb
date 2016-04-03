class InteraccionCampannaUsuario < ActiveRecord::Base
	
	belongs_to :interaccion_campanna_pub, foreign_key: "interaccion_campanna_id"
  	belongs_to :usuario, foreign_key: "usuario_id"

end
