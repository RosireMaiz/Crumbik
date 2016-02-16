class ActividadPublicitariaDetalle < ActiveRecord::Base
	belongs_to :actividad_publicitarium
	enum type_actividad: [ :sms, :llamadas, :email ]

end
