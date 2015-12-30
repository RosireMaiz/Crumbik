class CreateContratos < ActiveRecord::Migration
  CREATE_TIMESTAMP = 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP'

  def change
    create_table :contratos do |t|
      t.column :fecha_creacion, CREATE_TIMESTAMP
      t.date :fecha_vencimiento
      t.string :estatus
      t.string :observacion
      t.references :organizacion, index: true
      t.references :plan, index: true
    end
  end
end
