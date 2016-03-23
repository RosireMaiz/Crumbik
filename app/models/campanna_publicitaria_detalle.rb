class CampannaPublicitariaDetalle < ActiveRecord::Base

	enum tipo_difusion: [:llamada, :sms, :email, :red_social]
	belongs_to :campanna_publicitarium, foreign_key: "campanna_publicitaria_id"
	has_many :interaccion_campanna_pub, class_name: "InteraccionCampanaPub"
	
end
