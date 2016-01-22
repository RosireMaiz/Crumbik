class Contrato < ActiveRecord::Base
  	belongs_to :organizacion
  	belongs_to :plan
  	has_many :pagos, class_name: "PagoContrato"
  	accepts_nested_attributes_for :pagos
end
