class YoutubeService
  def self.get_youtube_video(country)
    get_url("/youtube/v3/search?q=#{country}")
  end
  
  def self.get_url(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
  
  def self.conn
    Faraday.new('https://www.googleapis.com') do |f|
      f.params['key'] = ENV['youtube-key']
      f.params['part'] = 'snippet'
      f.params['maxResults'] = 1
      f.params['channelId'] = 'UCluQ5yInbeAkkeCndNnUhpw'
    end
  end
end