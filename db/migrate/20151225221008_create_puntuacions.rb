class CreatePuntuacions < ActiveRecord::Migration
  def change
    create_table :puntuacions do |t|
      t.float :puntuacion
      t.references :usuario, index: true
      t.references :producto, index: true

      t.timestamps null: false
    end
  end
end
