class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.string :comentario
      t.string :estatus, default: "A", :limit => 1
      t.references :usuario, index: true
      t.references :producto, index: true

      t.timestamps null: false
    end
  end
end
