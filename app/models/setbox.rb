class Setbox < ApplicationRecord
  belongs_to :user
  has_many :cards, inverse_of: :setbox, :dependent => :destroy
  accepts_nested_attributes_for :cards, reject_if: :all_blank, allow_destroy: true

  def self.search(search) 
    if search
      where(['title LIKE ? OR cards.card_word LIKE ? OR cards.card_def LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"]) 
    else
      all
    end
  end

end


