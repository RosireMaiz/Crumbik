class Cliente < ActiveRecord::Base
	belongs_to :tipo_cliente, class_name: "TipoCliente", foreign_key: "tipo_cliente_id"
	belongs_to :pais, class_name: "Pais", foreign_key: "pais_id"
	belongs_to :usuario, class_name: "Usuario"
end

