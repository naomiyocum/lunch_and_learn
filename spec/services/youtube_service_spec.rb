require 'rails_helper'

RSpec.describe YoutubeService do
  describe 'class methods' do
    describe '.conn' do
      it 'connects to the Youtube API' do
        conn = YoutubeService.conn
        expect(conn.params).to have_key :key
        expect(conn.params).to have_key :part
        expect(conn.params).to have_key :maxResults
        expect(conn.params).to have_key :channelId
      end
    end

    describe '.get_url' do
      it 'parses through the response body and returns a JSON hash with keys as symbols' do
        url = YoutubeService.get_url("/youtube/v3/search?q=Japan")
        expect(url).to be_a Hash
      end
    end

    describe '.get_youtube_video' do
      it 'returns one youtube video' do
        vid = YoutubeService.get_youtube_video('Japan')
        expect(vid).to be_a Hash
        expect(vid[:items].count).to eq(1)

        japan_vid = vid[:items][0]
        expect(japan_vid[:id]).to have_key :videoId
        expect(japan_vid[:snippet]).to have_key :title
      end
    end
  end
end