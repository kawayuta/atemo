class CreateEmos < ActiveRecord::Migration[5.1]
  def change
    create_table :emos do |t|
      t.text :text
      t.integer :emo
      t.decimal :point, precision: 10, scale: 10
      t.text    :words_points
      t.text    :color
      t.text    :words_colors
      t.timestamps
    end
  end
end
