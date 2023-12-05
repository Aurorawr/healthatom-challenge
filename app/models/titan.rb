class Titan < ApplicationRecord
  has_many :sighting
  has_one :death
end
