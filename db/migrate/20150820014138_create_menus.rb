class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
 		t.references :rol,			 index: true
    end
  end
end
