require "http"

class Tmdb

    def self.save_top20_popular_to_movies
        attempts = 0
        begin
            attempts += 1
            response = HTTP.timeout(2).get("https://api.themoviedb.org/3/movie/popular", :params => {:api_key => Rails.application.credentials[:tmdb][:api_key], :language => 'en-US', :page => '1'})
        rescue => e
            if attempts < 10
                #sleep(1)
                retry
            else
                return false
            end
        end
        
        results = response.parse['results']
        ratings = {}
        results.each do |r|
            attempts = 0
            begin
                attempts += 1
                tmp_movie_id = r['id']
                response = HTTP.timeout(2).get("https://api.themoviedb.org/3/movie/#{tmp_movie_id}/release_dates", :params => {:api_key => Rails.application.credentials[:tmdb][:api_key]})
            rescue => e
                if attempts < 10
                    #sleep(1)
                    retry
                else
                    return false
                end
            end
            tmdb_movie_id = response.parse['id']
            results2 = response.parse['results']
            results2.each do |r2|
                if r2['iso_3166_1'] == 'US'
                    r2['release_dates'].each do |r3|
                        if r3['certification'].size > 0
                            ratings[tmdb_movie_id] = r3['certification']
                            break
                        end
                    end
                end
            end
        end

        results.each do |r|
            m = Movie.new
            m.title = r['title']
            m.release_date = Date.parse(r['release_date'])
            m.description = r['overview']
            m.rating = ratings[r['id']]
            m.save!
        end
        return true
    end
end