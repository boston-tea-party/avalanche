class AddUniquessConstraintToUploadsSha256 < ActiveRecord::Migration
  def change
    add_index :uploads, :sha256, unique: true
  end
end
