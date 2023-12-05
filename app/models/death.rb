class Death < ApplicationRecord
  belongs_to :titan
  has_and_belongs_to_many :resource
end
