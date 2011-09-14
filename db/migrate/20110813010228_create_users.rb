class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :original
      t.string :original_uid
      t.string :translated
      t.string :translated_uid
      t.string :lang_from
      t.string :lang_to

      t.timestamps
    end
  end
end
