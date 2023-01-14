require 'rails_helper'

RSpec.describe LearningResource do
  it 'exists' do
    country = 'Japan'
    video = {
      title: 'I Miss Okinawa',
      youtube_video_id: 'abcdefg'
    }
    photos = [
      {
        alt_tag: 'soba',
        url: 'sobasobasoba'
      },
      {
        alt_tag: 'udon',
        url: 'udonudonudon'
      }
    ]

    resource = LearningResource.new(country, video, photos)

    expect(resource).to be_an_instance_of LearningResource
    expect(resource.country).to eq('Japan')
    expect(resource.video).to be_a Hash
    expect(resource.video).to have_key :title
    expect(resource.video).to have_key :youtube_video_id
    expect(resource.images).to be_an Array
    expect(resource.images[0]).to have_key :alt_tag
    expect(resource.images[0]).to have_key :url
  end
end