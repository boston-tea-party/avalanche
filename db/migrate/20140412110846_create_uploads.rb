class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.timestamps
      t.text :sha256
      t.attachment :document
    end
  end
end
