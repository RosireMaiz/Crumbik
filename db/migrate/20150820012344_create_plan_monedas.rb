class CreatePlanMonedas < ActiveRecord::Migration
  def change
    create_table :plan_monedas do |t|
      t.float :monto
	  t.references :moneda, index: true
	  t.references :plan, index: true

    end
  end
end
