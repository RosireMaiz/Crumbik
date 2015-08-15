class CreatePerfils < ActiveRecord::Migration
  def change
    create_table :perfils do |t|
      t.string :nombres
      t.string :apellidos
      t.string :sexo
      t.string :ocupacion
t.references :usuario

      t.timestamps null: false
    end
  end
end
