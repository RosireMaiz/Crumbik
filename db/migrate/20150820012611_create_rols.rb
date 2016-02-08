class CreateRols < ActiveRecord::Migration
  def change
    create_table :rols do |t|
      t.string :nombre
      t.boolean :acceso_administrable, null: false, default: false
      t.integer :type_rol, default: 0
      t.string :estatus, default: "A", :limit => 1
    end
  end
end
