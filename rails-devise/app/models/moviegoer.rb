class Moviegoer < ApplicationRecord
    has_many :reviews
	has_many :movies, :through => :reviews

    validates :name, uniqueness: true
end