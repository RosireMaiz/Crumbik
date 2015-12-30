class CreatePagoContratos < ActiveRecord::Migration
	  CREATE_TIMESTAMP = 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP'
  def change
    create_table :pago_contratos do |t|
      t.float 		:monto
      t.column 	:fecha, CREATE_TIMESTAMP
      t.references 	:usuario, index: true
      t.references 	:contrato, index: true
      t.references 	:modo_pago, index: true
    end
  end
end
