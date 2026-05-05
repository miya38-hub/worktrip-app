class Language
  def self.get_data(text)
    return { score: 0.0, magnitude: 0.0 } if text.blank?

    api_url = "https://language.googleapis.com/v1/documents:analyzeSentiment?key=#{ENV['GOOGLE_API_KEY']}"

    params = {
      document: {
        type: "PLAIN_TEXT",
        content: text
      }
    }.to_json

    uri = URI.parse(api_url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    https.open_timeout = 5
    https.read_timeout = 5

    request = Net::HTTP::Post.new(uri.request_uri)
    request["Content-Type"] = "application/json"

    response = https.request(request, params)

    unless response.is_a?(Net::HTTPSuccess)
      return { score: 0.0, magnitude: 0.0 }
    end

    body = JSON.parse(response.body)

    if body["error"]
      return { score: 0.0, magnitude: 0.0 }
    end

    sentiment = body["documentSentiment"]

    score = sentiment&.dig("score") || 0.0
    magnitude = sentiment&.dig("magnitude") || 0.0

    { score: score, magnitude: magnitude }
    
  end
end