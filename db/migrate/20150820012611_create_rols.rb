class CreateRols < ActiveRecord::Migration
  def change
    create_table :rols do |t|
      t.string :nombre
      t.boolean :acceso_administrable, null: false, default: false
      t.string :estatus, default: "A", :limit => 1

	  t.timestamps null: false
    end
  end
end
