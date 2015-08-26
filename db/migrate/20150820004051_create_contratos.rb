class CreateContratos < ActiveRecord::Migration
  def change
    create_table :contratos do |t|
      t.datetime :fecha_creacion
      t.datetime :fecha_vencimiento
      t.string :estatus
      t.string :observacion
      t.references :organizacion, index: true
      t.references :plan, index: true
      t.references :frecuencia_pago, index: true

    end
  end
end
