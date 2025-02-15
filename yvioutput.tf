output "winterlistOfSport {
value       = { for idx, name in local.winterlistOfSports : idx => "Sport Name: ${name}" }
}
output "total_output" {
   value = { for idx, name in local.total_output: idx => "total out: ${name}" }
}
output "characters" {
value =   { for idx, name in local.characters: idx => "character name: ${name}" }
}
