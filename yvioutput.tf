output "winterlistOfSport_name" {
value       = { for winterlistOfSport name in local.winterlistOfSports : winterlistOfSport => "Sport Name: ${name}" \n}
}
output "total_output_name" {
   value = { for total_output name in local.total_output: total_output => "total out: ${name}" \n }
}
output "characters_name" {
value =   { for characters name in local.characters: characters => "character name: ${name}" \n}
}
