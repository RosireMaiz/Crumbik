class CreatePlanServicios < ActiveRecord::Migration
  def change
    create_table :plan_servicios do |t|
      t.string :descripcion
      t.references :plan, index: true
      t.references :servicio, index: true
    end
  end
end
