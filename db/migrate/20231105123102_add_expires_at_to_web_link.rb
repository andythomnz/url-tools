class AddExpiresAtToWebLink < ActiveRecord::Migration[7.1]
  def up
    add_column :web_links, :expires_at, :datetime

    execute %[
      UPDATE web_links
      SET expires_at = NOW() + interval '6 month'
    ]

    change_column :web_links, :expires_at, :datetime, null: false
  end

  def down
    remove_column :web_links, :expires_at
  end
end
