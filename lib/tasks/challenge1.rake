namespace :titans do
  desc "Tarea para encontrar el mejor día para ir a explorar, basado en un archivo con información recolectada."
  task :best_day, [:filepath] do |t, args|
    if args[:filepath].present?
      require 'json'

      sightings_file = File.read(args[:filepath])

      sightings = JSON.parse(sightings_file)
      
      sighting_in_days = Array.new(365, 0)

      sightings.each do |sighting|
        from, to = sighting
        (from..to).each do |day|
          sighting_in_days[day] += 1 unless day >= 365
        end
      end

      first_day_of_february = 31
      last_day_of_november = 333

      quantity, best_day = sighting_in_days[first_day_of_february..last_day_of_november].each_with_index.min

      puts "El mejor día para salir a explorar es el #{best_day}, con #{quantity} avistamientos según el archivo #{args[:filepath]}. ¡Entreguen sus corazones!"
    else
      puts "Necesitas un archivo con información para poder obtener el mejor día para explorar. ¿O es que acaso no quieres sobrevivir?"
    end
  end
end