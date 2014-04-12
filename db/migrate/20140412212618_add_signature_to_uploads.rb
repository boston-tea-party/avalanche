class AddSignatureToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :signature, :text
  end
end
