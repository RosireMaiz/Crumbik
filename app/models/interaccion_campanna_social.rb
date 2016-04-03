class InteraccionCampannaSocial < ActiveRecord::Base
	belongs_to :interaccion_campanna_pub, foreign_key: "interaccion_campanna_id"
  	belongs_to :organizacion_red_social, foreign_key: "organizacion_red_socials_id"
end
