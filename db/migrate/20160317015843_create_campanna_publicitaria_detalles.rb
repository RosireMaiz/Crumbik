class CreateCampannaPublicitariaDetalles < ActiveRecord::Migration
  def change
    create_table :campanna_publicitaria_detalles do |t|
    	t.integer :medio_difusion
    	t.references :campanna_publicitaria, index: true
      	
      	t.timestamps null: false
    end
  end
end
