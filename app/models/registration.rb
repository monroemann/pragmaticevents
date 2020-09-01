class Registration < ApplicationRecord
  belongs_to :event
  belongs_to :user

  HOW_HEARD_OPTIONS =  [
  	'Newsletter',
  	'Friend',
  	'Monroe'
  ]

  validates :how_heard, inclusion: { in: HOW_HEARD_OPTIONS }
  
end
