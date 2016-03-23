class CriterioDifusion < ActiveRecord::Base
	has_many :criterio_campanna_pub, class_name: "CriterioCampannaPub", foreign_key: "criterio_difusion_id"
  	has_many :criterio_difusion, :through => :criterio_campanna_pub, foreign_key: "criterio_difusion_id"
end
