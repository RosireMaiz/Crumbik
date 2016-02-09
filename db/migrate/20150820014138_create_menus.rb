class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
    	t.integer :type_menu, default: 0
 		t.references :rol, index: true
    end
  end
end
