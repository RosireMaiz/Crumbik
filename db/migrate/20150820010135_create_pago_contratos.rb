class CreatePagoContratos < ActiveRecord::Migration
  def change
    create_table :pago_contratos do |t|
      t.float 		:monto
      t.datetime 	:fecha
      t.references 	:usuario, index: true
      t.references 	:contrato, index: true
      t.references 	:modo_pago, index: true
      t.references 	:moneda, index: true

    end
  end
end
