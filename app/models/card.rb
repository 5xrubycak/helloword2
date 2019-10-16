class Card < ApplicationRecord
  belongs_to :setbox

  validates :card_word, :card_def, presence: { message: :blank} 
  validates :card_word, :card_def, length: { maximum: 20,
    message: :too_long} 

     

end
