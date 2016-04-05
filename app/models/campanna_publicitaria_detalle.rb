class CampannaPublicitariaDetalle < ActiveRecord::Base

	enum medio_difusion: [:llamada, :sms, :email, :red_social]
	
	belongs_to :campanna_publicitarium, foreign_key: "campanna_publicitaria_id"
	has_many :interaccion_campanna_pub, class_name: "InteraccionCampannaPub",  foreign_key: "campanna_detalle_id"
	
	def cantidad_difusion_detalle
		cantidad = 0
		self.interaccion_campanna_pub.each do |interaccion_campanna|
			cantidad = cantidad + interaccion_campanna.interaccion_campanna_usuario.length
			cantidad = cantidad + interaccion_campanna.interaccion_campanna_social.length
		end
		cantidad
	end

	def cantidad_difusion_usuario
		cantidad = 0
		self.interaccion_campanna_pub.each do |interaccion_campanna|
			cantidad = cantidad + interaccion_campanna.interaccion_campanna_usuario.length
		end
		cantidad
	end

	def cantidad_difusion_social
		cantidad = 0
		self.interaccion_campanna_pub.each do |interaccion_campanna|
			cantidad = cantidad + interaccion_campanna.interaccion_campanna_social.length
		end
		cantidad
	end
end
