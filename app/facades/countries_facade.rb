class CountriesFacade
  def self.all_countries
    countries = CountriesService.get_all_countries
    countries.map {|country| Country.new(country)}
  end
end