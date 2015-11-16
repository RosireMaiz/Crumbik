class PlanServicio < ActiveRecord::Base
	belongs_to :servicio
	belongs_to :plan
end
