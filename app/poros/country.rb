class Country
  attr_reader :name
  
  def initialize(data)
    @name = data[:name][:common]
  end

  def self.valid_country?(user_input)
    countries = CountriesFacade.all_countries
    countries.any? {|country| country.name == user_input.capitalize}
  end
end