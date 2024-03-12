# replace 6.1 with your Rails version if you are not
# using the RVM 2.7.2 Ruby bundle on the BIAR VM
class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table 'movies' do |t|
      t.string 'title'
      t.string 'rating'
      t.text 'description'
      t.datetime 'release_date'
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end
