# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

titans = [
  ["Acorazado", rand(3..15)],
  ["Femenino", rand(3..15)],
  ["Bestia", rand(3..15)],
  ["Don Francisco", rand(3..15)],
  ["Miguelito", rand(3..15)],
  ["Tronchoman", rand(3..15)],
  ["Mandíbula", rand(3..15)],
  ["Martillo", rand(3..15)],
  ["Shaq", rand(3..15)],
  ["Diego", rand(3..15)],
  ["Fidel", rand(3..15)],
  ["Cargo", rand(3..15)],
  ["Ymir", rand(3..15)],
  ["Mamá de Connie", rand(3..15)],
  ["Pedro", rand(3..15)],
  ["Ling", rand(3..15)],
  ["Javier", rand(3..15)],
  ["Estefanía", rand(3..15)],
  ["Carmen", rand(3..15)],
  ["Dora", rand(3..15)]
]

resources = ["Agua", "Pólvora", "Gas", "Hojas (filo)", "Equipo maniobras"]

titans.each_with_index do |titan_data, index|
  titan = Titan.create!(alias: titan_data[0], height: titan_data[1])
  first_sight = Date.today - rand(10..35)
  last_sight = Date.today + rand(10..35)
  titan.sighting.create!(first_sight: first_sight, last_sight: last_sight)
  if index%2 == 0
    first_sight = last_sight + rand(10..35)
    last_sight = first_sight + rand(40..100)
    titan.sighting.create!(first_sight: first_sight, last_sight: last_sight)
  end
  if index%3 == 0
    death_date = Date.today - rand(100)
    death_cause ="Accidente"
    create_resource = false
    if index%2 == 0
      death_cause = "Batalla"
      create_resource = true
    end
    death = Death.create!(titan: titan, cause: death_cause, date: death_date)
    if create_resource
      resource = Resource.create!(name: resources[rand(resources.size)], unit: "Batallón #{rand(1..3)}")
      death.resource << resource
    end
  end
end

resources.each do |resource|
  Resource.create!(name: resource, unit: "Batallón 4")
end
