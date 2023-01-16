require 'rails_helper'

RSpec.describe UnsplashService do
  describe 'class methods' do
    describe '.conn' do
      it 'connects to the Unsplash API' do
        conn = UnsplashService.conn
        expect(conn.headers).to have_key 'Authorization'
      end
    end

    describe '.get_url' do
      it 'parses through the response body and returns a JSON hash with keys as symbols' do
        VCR.use_cassette 'Unsplash Service' do
          url = UnsplashService.get_url("/search/photos?query=Japan")
          expect(url).to be_a Hash
        end
      end
    end

    describe '.get_photos' do
      it 'returns photos from a specific country' do
        VCR.use_cassette 'Unsplash Service' do
          photos = UnsplashService.get_photos_from('Japan')
          expect(photos[:results].count).to eq(10)

          photo = photos[:results][0]
          expect(photo).to have_key :alt_description
          expect(photo[:urls]).to have_key :full
        end
      end
    end
  end
end