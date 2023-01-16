class Country
  attr_reader :name
  
  def initialize(data)
    @name = data[:name][:common]
  end

  def self.all_countries
    CountriesFacade.all_countries
  end

  def self.random_country
    all_countries.sample.name
  end

  def self.valid_country?(user_input)
    all_countries.any? {|country| country.name == user_input.capitalize}
  end
end