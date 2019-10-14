class Card < ApplicationRecord
  belongs_to :setbox

  validates :card_word, :card_def, presence: true
  validates :card_word, :card_def, length: { maximum: 50,
    too_long: "最長不能超過50個字喔！" }
end
