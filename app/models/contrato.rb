class Contrato < ActiveRecord::Base
  	belongs_to :organizacion
  	has_one :plan

end
