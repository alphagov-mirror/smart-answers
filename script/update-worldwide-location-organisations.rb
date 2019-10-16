require "open-uri"

worldwide_locations_path = Rails.root.join("test", "fixtures", "worldwide_locations.yml")
worldwide_locations = YAML.load_file(worldwide_locations_path)

worldwide_locations.each do |location_slug|
  puts "Updating data for #{location_slug}"

  url = "https://www.gov.uk/api/world-locations/#{location_slug}/organisations.json"
  # rubocop:disable Security/Open
  json = open(url).read
  # rubocop:enable Security/Open

  organisations_fixture_path = Rails.root.join("test/fixtures/worldwide/#{location_slug}_organisations.json")

  File.open(organisations_fixture_path, "w") do |file|
    # rubocop:disable Security/JSONLoad
    data = JSON.load(json)
    # rubocop:enable Security/JSONLoad
    file.puts JSON.pretty_generate(data)
  end
end
