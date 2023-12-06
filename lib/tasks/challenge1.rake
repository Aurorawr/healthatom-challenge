class InvalidFileException < StandardError
end

namespace :titans do
  desc "Tarea para encontrar el mejor día para ir a explorar, basado en un archivo con información recolectada."
  task :best_day, [:filepath] do |t, args|
    if args[:filepath].present?
      begin
        require 'json'

        sightings_file = File.read(args[:filepath])

        sightings = JSON.parse(sightings_file)
        
        sighting_in_days = Array.new(365, 0)

        if sightings.class != Array
          raise InvalidFileException
        end
        rows_processed = 0
        sightings.each do |sighting|
          from, to = sighting
          if not (from and to and from.is_a? Integer and to.is_a? Integer)
            next
          end
          (from..to).each do |day|
            sighting_in_days[day] += 1 unless day >= 365
          end
          rows_processed += 1
        end

        puts "Datos válidos procesados: #{rows_processed}"

        if rows_processed > 0
          first_day_of_february = 31
          last_day_of_november = 333

          quantity, best_day = sighting_in_days[first_day_of_february..last_day_of_november].each_with_index.min

          puts "El mejor día para salir a explorar es el #{best_day}, con #{quantity} avistamientos según el archivo #{args[:filepath]}. ¡Entreguen sus corazones!"
        else
          puts "El archivo #{args[:filepath]} no tenía datos válidos para ser procesados"
        end
      rescue LoadError
        puts "Necesitas la gema 'json' para que este trabajo funcione. Debería venir instalado por defecto en las últimas versiones de Ruby."
      rescue Errno::ENOENT
        puts "El archivo #{args[:filepath]} no fue encontrado."
      rescue InvalidFileException
        puts "El archivo #{args[:filepath]} tiene un formato inválido: debe contener una lista con avistamientos de titanes. Revise el archivo desafio1/last_year.json como ejemplo."
      rescue Exception => exception
        puts "Se ha generado la siguiente excepción #{exception.class}: #{exception.message}"
      end
    else
      puts "Necesitas un archivo con información para poder obtener el mejor día para explorar. ¿O es que acaso no quieres sobrevivir?"
    end
  end
end