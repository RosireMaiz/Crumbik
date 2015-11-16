class Plan < ActiveRecord::Base
	has_one :frecuencia_pago, class_name: "FrecuenciaPago"
	has_many :plan_servicio, class_name: "PlanServicio"
	has_many :servicio, :through => :plan_servicio
end
