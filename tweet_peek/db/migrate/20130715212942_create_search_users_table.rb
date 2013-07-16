class CreateSearchUsersTable < ActiveRecord::Migration
  def up
    create_table :searches_users do |t|
      t.integer :search_id
      t.integer :user_id
    end

  end

  def down
    drop_table :searches_users
  end
end
