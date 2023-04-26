class LearningResource
  attr_reader :country, :video, :images
  
  def initialize(country:, vid:, pics:)
    @country = country
    @video = vid
    @images = pics
  end
end