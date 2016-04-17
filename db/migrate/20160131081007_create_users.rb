##
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :account, index: true, foreign_key: true
      t.string :nick, null: false
      t.string :jabber, null: false

      t.datetime :jabber_confirmation_at
      t.string :jabber_confirmation_token, null: false

      t.string :lang, null: false
      t.string :country, null: false
      t.string :timezone, null: false

      t.timestamps null: false
    end

    add_index :users, :nick, unique: true
    add_index :users, :jabber, unique: true

    add_index :users, :jabber_confirmation_at
    add_index :users, :jabber_confirmation_token, unique: true

    add_index :users, :lang
    add_index :users, :country
    add_index :users, :timezone
  end
end
