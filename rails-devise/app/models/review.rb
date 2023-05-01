class Review < ApplicationRecord
    belongs_to :movie
	belongs_to :moviegoer

    validates :movie, uniqueness: { scope: :moviegoer,
        message: "one only review for a moviegoer" }
end