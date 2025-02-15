output "winterlistOfSport {
value       = { for idx, name in local.winterlistOfSports : idx => "Sport Name: ${name}" \n}
}
output "total_output" {
   value = { for idx, name in local.total_output: idx => "total out: ${name}" \n }
}
output "characters" {
value =   { for idx, name in local.characters: idx => "character name: ${name}" \n}
}
