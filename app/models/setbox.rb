class Setbox < ApplicationRecord
  belongs_to :user
  has_many :cards, inverse_of: :setbox
  accepts_nested_attributes_for :cards, reject_if: :all_blank, allow_destroy: true
end
