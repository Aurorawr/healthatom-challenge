##############################################################
# Titanes que han muerto por accidente ordenados cronológicamente por fecha de muerte
##############################################################

Titan.joins(:death).where(deaths: {cause: "Accidente"}).order("deaths.date ASC")

##############################################################
# Titán más alto que ha matado el Batallón 1
##############################################################

Titan.joins(death: :resource).where("resources.unit = 'Batallón 1'").order("height DESC").limit(1)

##############################################################
# Titanes que aún no mueren ordenados ascendentemente por altura
##############################################################

Titan.where.missing(:death).order("height ASC")

##############################################################
# Titanes que han sido visto más de una vez en un mismo año, ordenados ascendentemente por alias.
##############################################################

# Query para SQLite (donde fue testeado)
Titan.joins(:sighting).where("strftime('%Y', last_sight) IN (SELECT strftime('%Y', first_sight) FROM sightings s2 WHERE s2.titan_id = sightings.titan_id and s2.id != sightings.id)").order("alias ASC")

# Query para Postgres (debería funcionar)
Titan.joins(:sighting).where("EXTRACT(YEAR FROM last_sight) IN (SELECT EXTRACT(YEAR FROM first_sight) FROM sightings s2 WHERE s2.titan_id = sightings.titan_id and s2.id != sightings.id)").order("alias ASC")
##############################################################
# Recursos que han sido usados para matar titanes menores a 5 metros
##############################################################

Resource.select("name, unit, count(*)").joins(death: :titan).where("titans.height <= 5").group("name, unit")