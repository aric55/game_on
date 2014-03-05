class Event < ActiveRecord::Base
	validates :name,     presence: true
	validates :dateheld, presence: true
end
