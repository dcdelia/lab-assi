class OperationsController < ApplicationController

    def top20
        if Tmdb.save_top20_popular_to_movies
            @message = 'Succeed'
        else
            @message = 'Failed'
        end
    end

    def bootstrap
    end
end