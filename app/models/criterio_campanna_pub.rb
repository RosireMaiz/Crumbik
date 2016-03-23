class CriterioCampannaPub < ActiveRecord::Base

	belongs_to :campanna_publicitarium, foreign_key: "campanna_publicitaria_id"
  	belongs_to :criterio_difusion, foreign_key: "criterio_difusion_id"
  	
end
