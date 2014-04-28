class CreateGuardians < ActiveRecord::Migration
  def change
    create_table :guardians do |t|
      t.string :name
      t.string :child
      t.string :email
      t.string :phone
      t.integer :score

      t.timestamps
    end
  end
end
