class UnsplashService
  def self.get_photos_from(country)    
    get_url("/search/photos?query=#{country}")
  end

  def self.get_url(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
  
  def self.conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.headers['Authorization'] = "Client-ID #{ENV['unsplash-key']}"
    end
  end
end