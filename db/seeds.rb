# This file should ensure the existence of records required to run the application in every environment (production, # development, test). The code here should be idempotent so that it can be executed at any point in every environment. },
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

airport_data = [
  { region: "North America", country: "United States", city: "Washington D.C.", code: "DCA" },
  { region: "North America", country: "United States", city: "Harrisburg", state: "Pennsylvania", code: "LAN" },
  { region: "North America", country: "United States", city: "Atlanta", state: "Georgia", code: "ATL" },
  { region: "North America", country: "United States", city: "Chicago", state: "Illinois", code: "ORD" },
  { region: "North America", country: "Canada", city: "Ottawa", code: "YOW" },
  { region: "North America", country: "Canada", city: "Toronto", code: "YYZ" },
  { region: "North America", country: "Canada", city: "Montreal", code: "YUL" },
  { region: "Europe", country: "Germany", city: "Berlin", code: "BER" },
  { region: "Europe", country: "France", city: "Paris", code: "CDG" },
  { region: "Europe", country: "United Kingdom", city: "London", code: "LHR" },
  { region: "Europe", country: "Italy", city: "Rome", code: "FCO" },
  { region: "Europe", country: "Spain", city: "Madrid", code: "MAD" },
  { region: "Europe", country: "Belgium", city: "Brussels", code: "BRU" },
  { region: "Asia Pacific", country: "China", city: "Beijing", code: "PEK" },
  { region: "Asia Pacific", country: "Australia", city: "Canberra", code: "CBR" },
  { region: "Asia Pacific", country: "New Zealand", city: "Wellington", code: "WLG" }
]

airports = airport_data.map do |airport|
  Airport.create!(airport)
end

airports.each do |a|
  3.times do |day| # flights for each of the next three days
    3.times do |_| # 3 flights per day
      a.departing_flights.create!(
        arrival_airport: Airport.where.not(id: a.id).sample,
        departure_datetime: (day + 1).days.from_now.beginning_of_day + rand(24).hours,
        duration_minutes: rand(600) + 60
      )
    end
  end
end
