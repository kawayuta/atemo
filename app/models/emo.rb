class Emo < ApplicationRecord
  validates :text, presence: true
  serialize :words_points
  serialize :words_colors
  serialize :color

end
