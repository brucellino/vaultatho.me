# Currently Enterprise only
# resource "vault_raft_snapshot_agent_config" "local" {
#   name             = "snaps"
#   file_prefix      = "backup"
#   interval_seconds = 604800
#   retain           = 5
#   path_prefix      = "bak/"
#   storage_type     = "local"
#   local_max_space  = "1000000"
# }

resource "vault_raft_autopilot" "this" {
  cleanup_dead_servers               = true
  dead_server_last_contact_threshold = "1m0s"
  max_trailing_logs                  = 10
}
