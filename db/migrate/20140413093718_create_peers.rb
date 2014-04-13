class CreatePeers < ActiveRecord::Migration
  def change
    create_table :peers do |t|
      t.timestamps
      t.text :target, null: false
      t.text :port, null: false
    end
  end
end
