Geocoder.configure(
  lookup: :google,
  use_https: true,
  api_key: ENV["GOOGLE_MAP_API_KEY"],
  units: :km,
  timeout: 5
)