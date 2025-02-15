output "winterlistOfSport_name" {
value   ={ for idx, name in local.winterlistOfSports : idx => "winterlistOfSports wint: ${name}" }
}
output "total_output_name" {
   value = { for idx, name in local.total_output: idx => "total_output out: ${name}" }
}
output "characters_name" {
value =   { for idx, name in local.characters: characters => "characters char: ${name}"}
}
