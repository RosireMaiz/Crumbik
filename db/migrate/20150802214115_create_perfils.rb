class CreatePerfils < ActiveRecord::Migration
  def change
    create_table :perfils do |t|
      t.string :nombres
      t.string :apellidos
      t.string :sexo
      t.string :ocupacion
	    t.references :usuario, index: true
	    t.longblob :foto
      t.string :formato_foto
    end
  end
end