class CreateHistory < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :phone
      t.integer :need_id
    end
  end
end
