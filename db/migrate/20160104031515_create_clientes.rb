class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombres
      t.string :apellidos
      t.text :direccion
      t.string :email
      t.string :telefono
      t.string :telefono_movil
      t.string :sexo
      t.references :usuario, index: true,  default: 0
      t.string :estatus, default: "A", :limit => 1

      t.timestamps null: false
    end
  end
end
