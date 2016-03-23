class CreateCampannaPublicitaria < ActiveRecord::Migration
  def change
    create_table :campanna_publicitaria do |t|
      t.string :titulo
      t.string :descripcion
      t.date :fecha_inicio
      t.date :fecha_fin
      t.references :producto

      t.timestamps null: false
    end
  end
end
