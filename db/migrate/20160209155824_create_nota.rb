class CreateNota < ActiveRecord::Migration
  def change
    create_table :nota do |t|
      t.string :titulo
      t.text :contenido
      t.string :color
      t.references :usuario, index: true

      t.timestamps null: false
    end
  end
end
