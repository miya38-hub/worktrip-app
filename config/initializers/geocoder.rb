Geocoder.configure(
  lookup: :google,
  use_https: true,
  api_key: ENV["GEOCODING_API_KEY"],  
  units: :km
)