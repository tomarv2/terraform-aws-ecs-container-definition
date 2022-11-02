data "template_file" "container_definition" {
  for_each = var.config

  template = file("${path.module}/container-definition.json.tpl")

  vars = {
    name               = each.key
    launch_type        = try(each.value.launch_type, "EC2")
    region             = try(each.value.region, null)
    health_check       = try(jsonencode(each.value.healthcheck), "null")
    log_configuration  = try(jsonencode(each.value.log_configuration), "{}")
    memory_reservation = try(each.value.memory_reservation, "null")
    command            = try(jsonencode(each.value.command), "null")
    entrypoint         = try(jsonencode(each.value.entrypoint), "null")
    environment        = try(jsonencode(each.value.environment), "null")
    environment_files  = try(jsonencode(each.value.environment_files), "null")
    secrets            = try(jsonencode(each.value.secrets), "null")
    mount_points = jsonencode(length(try(each.value.mount_points, {})) > 0 ? [
      for mount_point in each.value.mount_points : {
        containerPath = lookup(mount_point, "containerPath")
        sourceVolume  = lookup(mount_point, "sourceVolume")
        readOnly      = tobool(lookup(mount_point, "readOnly", false))
      }
    ] : try(each.value.mount_points, null))
    image                    = each.value.container_image
    readonly_root_filesystem = try(each.value.readonly_root_filesystem, true)
    privileged               = try(each.value.privileged, false)
    repository_credentials   = try(jsonencode(each.value.repository_credentials), "null")
    port_mapping             = try(jsonencode(each.value.port_mapping), "null")
    networking_mode          = try(each.value.network_mode, "awsvpc")
    container_memory         = try(each.value.container_memory, "null")
    container_cpu            = try(each.value.container_cpu, "null")
    essential                = try(each.value.essential, "true")
  }
}

