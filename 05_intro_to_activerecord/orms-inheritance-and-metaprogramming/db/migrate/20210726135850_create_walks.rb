class CreateWalks < ActiveRecord::Migration[5.2]
  def change
    create_table :walks do |t|
      t.datetime :time
      
      t.timestamps
    end
  end
end
