class CreateFeeds < ActiveRecord::Migration[5.0]
  def self.up
    create_table :feeds do |t|
      t.string :title
      t.string :url
      t.integer :user_id
      t.timestamps
    end
  add_index :feeds, :user_id
  end

  def self.down
    drop_table :feeds
  end
end
