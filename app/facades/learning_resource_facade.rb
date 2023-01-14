class LearningResourceFacade
  def self.resources_for(country)
    photo_data = convert_photos(UnsplashService.get_photos_from(country))
    video_data = convert_vid(YoutubeService.get_youtube_video(country))
    LearningResource.new(photo_data, video_data, country)
  end

  def self.convert_vid(data)
    {
      title: data[:items][0][:snippet][:title],
      youtube_video_id: data[:items][0][:id][:videoId]
    }
  end

  def self.convert_photos(data)
    photo_array = []
    data[:results].each do |photo|
      photo_array << {
        alt_tag: photo[:alt_description],
        url: photo[:urls][:regular]
      }
    end
    photo_array
  end
end