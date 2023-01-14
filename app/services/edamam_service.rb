class EdamamService
  def self.get_recipes(country)
    get_url("/api/recipes/v2?q=#{country}")
  end
  
  def self.get_url(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.edamam.com') do |f|
      f.params['app_id'] = ENV['edamam-app-id']
      f.params['app_key'] = ENV['edamam-app-key']
      f.params['type'] = 'public'
    end
  end
end