class AvailableTime < ActiveRecord::Base
  belongs_to :debate


  validates :proposed_time,
    presence: true
end
