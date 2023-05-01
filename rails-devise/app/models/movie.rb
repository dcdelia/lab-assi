class Movie < ApplicationRecord

    has_many :reviews, dependent: :destroy

    before_save :capitalize_title

    @@grandfathered_date = Date.parse('1 Nov 1968')

    def grandfathered?
        release_date && release_date < @@grandfathered_date
    end

    def self.all_ratings ; %w[G PG PG-13 R NC-17] ; end #  shortcut: array of strings

    def released_1930_or_later
        errors.add(:release_date, 'must be 1930 or later') if
                release_date && release_date < Date.parse('1 Jan 1930')
    end

    def capitalize_title
        self.title = self.title.split(/\s+/).map(&:downcase).
          map(&:capitalize).join(' ')
    end

    # model validation

	validates :title, :presence => true, uniqueness: { case_sensitive: false }
	validates :release_date, :presence => true
	validate :released_1930_or_later # uses custom validator below
	#validates :rating, :inclusion => {:in => Movie.all_ratings},
	#	:unless => :grandfathered?

    def avg_reviews
		sum = 0
		self.reviews.each do |review|
			sum = sum + review.potatoes
		end
		if self.reviews.count>0
			return sum/self.reviews.count
		else
			return "--"
		end
	end

end
