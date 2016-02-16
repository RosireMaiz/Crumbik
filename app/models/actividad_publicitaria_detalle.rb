class ActividadPublicitariaDetalle < ActiveRecord::Base
	belongs_to :actividad_publicitarium, foreign_key: "campanna_id"
	enum type_actividad: [ :sms, :llamada, :email ]
	
end
