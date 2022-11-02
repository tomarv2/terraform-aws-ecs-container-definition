output "container_definition" {
  value = [for event in data.template_file.container_definition : jsondecode(event.rendered)]
}

output "encoded_container_definition" {
  value = replace(format("[%s]", join(",", [for event in data.template_file.container_definition : event.rendered])), "/\"(null)\"/", "$1")
}
