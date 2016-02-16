class ActividadPublicitarium < ActiveRecord::Base
	belongs_to :producto
	has_many :actividad_publicitaria_detalle, class_name: "ActividadPublicitariaDetalle", foreign_key: "campanna_id"
end
