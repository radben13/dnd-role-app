class AddUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.string :key
      t.references :player, foreign_key: true
      t.timestamps null: false
      t.datetime :logout_at
    end
  end
end
