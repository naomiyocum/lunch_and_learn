class EdamamFacade
  def self.recipes_from(country)
    recipes = EdamamService.get_recipes(country)[:hits]
    recipes.map {|recipe| Recipe.new(recipe, country)}
  end
end