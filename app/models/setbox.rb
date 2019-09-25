class Setbox < ApplicationRecord
  belongs_to :user
  has_many :cards, inverse_of: :setbox, :dependent => :destroy
  accepts_nested_attributes_for :cards, reject_if: :all_blank, allow_destroy: true

  def self.search(search) 
    if search
      where(['cards.card_word LIKE ?', "%#{search}%"]) 
    else
      all
    end
  end
end
