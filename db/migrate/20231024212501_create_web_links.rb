class CreateWebLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :web_links do |t|
      t.timestamps
      t.text :destination, null: false
      t.string :key, null: false, index: { unique: true, name: 'unique_keys' }
    end
  end
end
