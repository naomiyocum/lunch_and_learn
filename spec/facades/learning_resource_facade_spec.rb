require 'rails_helper'

RSpec.describe LearningResourceFacade do
  describe 'class methods' do
    describe '.resources_for' do
      it 'returns a youtube video and a collection of 10 photos of the country' do
        resource = LearningResourceFacade.resources_for('Japan')
        expect(resource).to be_an_instance_of LearningResource
      end
    end

    describe '.convert_vid' do
      it 'returns only the title and video id of the YouTube video' do
        vid_data = LearningResourceFacade.convert_vid(YoutubeService.get_youtube_video('Japan'))
        expect(vid_data).to be_a Hash
        expect(vid_data).to have_key :title
        expect(vid_data).to have_key :youtube_video_id
      end
    end

    describe '.convert_photos' do
      it 'returns an array of photos with their url and alt tag' do
        photo_data = LearningResourceFacade.convert_photos(UnsplashService.get_photos_from('Japan'))
        expect(photo_data).to be_an Array
        expect(photo_data[0]).to have_key :alt_tag
        expect(photo_data[0]).to have_key :url
      end
    end
  end
end