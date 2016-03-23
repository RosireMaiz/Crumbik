class CampannaPublicitarium < ActiveRecord::Base
	belongs_to :producto, class_name: "Producto"
	has_many :campanna_publicitario_detalle, class_name: "CampannaPublicitariaDetalle"
	
	has_many :criterio_campanna_pub, class_name: "CriterioCampannaPub", foreign_key: "campanna_publicitaria_id"
  	has_many :criterio_difusion, :through => :criterio_campanna_pub, foreign_key: "campanna_publicitaria_id"
 end
