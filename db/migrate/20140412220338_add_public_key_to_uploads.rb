class AddPublicKeyToUploads < ActiveRecord::Migration
  def change
      add_column :uploads, :public_key, :text
  end
end
