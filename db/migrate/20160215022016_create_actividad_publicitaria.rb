class CreateActividadPublicitaria < ActiveRecord::Migration
  def change
    create_table :actividad_publicitaria do |t|
      t.string :titulo
      t.string :descripcion
      t.date :inicio
      t.date :fin
      t.references :producto, index: true

      t.timestamps null: false
    end
  end
end
