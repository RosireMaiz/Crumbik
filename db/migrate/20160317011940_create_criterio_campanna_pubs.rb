class CreateCriterioCampannaPubs < ActiveRecord::Migration
  def change
    create_table :criterio_campanna_pubs do |t|
    	t.references :campanna_publicitaria, index: true
    	t.references :criterio_difusion, index: true
    	t.string :operador
    	t.string :valor
    	
      	t.timestamps null: false
    end
  end
end
