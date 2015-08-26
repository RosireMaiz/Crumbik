class Contrato < ActiveRecord::Base
  	belongs_to :organizacion
  	has_one :plan
	has_one :frecuencia_pago, class_name: "FrecuenciaPago"
end
