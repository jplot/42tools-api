class CreateCursusUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :cursus_users do |t|
      t.references :cursus, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
