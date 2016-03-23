class CreateUsuarioRols < ActiveRecord::Migration
  def change
    create_table :usuario_rols do |t|
      t.references :usuario, index: true
      t.references :rol, index: true

	  t.timestamps null: false
    end
  end
end
