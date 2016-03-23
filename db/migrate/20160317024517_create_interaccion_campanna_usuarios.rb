class CreateInteraccionCampannaUsuarios < ActiveRecord::Migration
  def change
    create_table :interaccion_campanna_usuarios do |t|
      t.string :observacion
      t.integer :duracion
      t.string :email
      t.string :telefono_movil

      t.references :usuario, index: true
      t.references :interaccion_campanna, index: true

      t.timestamps null: false
    end
  end
end
