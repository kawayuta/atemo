class CreateEmos < ActiveRecord::Migration[5.1]
  def change
    create_table :emos do |t|
      t.text :text
      t.integer :emo
      t.integer :point

      t.timestamps
    end
  end
end
