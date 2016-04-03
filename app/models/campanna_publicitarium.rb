class CampannaPublicitarium < ActiveRecord::Base
	belongs_to :producto, class_name: "Producto"
	
	has_many :campanna_publicitaria_detalles, class_name: "CampannaPublicitariaDetalle", foreign_key: "campanna_publicitaria_id"
	
	has_many :criterio_campanna_pubs, class_name: "CriterioCampannaPub", foreign_key: "campanna_publicitaria_id"
  	has_many :criterio_difusion, :through => :criterio_campanna_pubs, foreign_key: "campanna_publicitaria_id"

  	accepts_nested_attributes_for :campanna_publicitaria_detalles
  	accepts_nested_attributes_for :criterio_campanna_pubs
  	
  	def cantidad_difusion
  		cantidad = 0
  		self.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
  			cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_detalle
  		end
  		cantidad
  	end
  	
 end
