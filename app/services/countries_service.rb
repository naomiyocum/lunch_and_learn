class CountriesService
  def self.get_all_countries
    JSON.parse(conn.get('/v3.1/all').body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://restcountries.com')
  end
end