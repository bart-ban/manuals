1. Install Wireguard portal - **https://github.com/h44z/wg-portal**
2. Add systemd service - sudo nano **nano /etc/systemd/system/wg-portal.service**
~~~~
[Unit]
Description=WG-Portal - Web UI for WireGuard
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
Group=root
ExecStart=/opt/wg-portal/wg-portal_linux_amd64
WorkingDirectory=/opt/wg-portal
Restart=on-failure
RestartSec=5s
AmbientCapabilities=CAP_NET_ADMIN
CapabilityBoundingSet=CAP_NET_ADMIN
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
~~~~



3. Sample config file - **/opt/wg-porta/config/config.yml**
~~~
   core:
  admin_user: **ADMIN_LOGIN**
  admin_password: **SUPER_SECRET_PASSWORD**
  admin_api_token: ""
  disable_admin_user: false
  editable_keys: true
  create_default_peer: false
  create_default_peer_on_creation: false
  re_enable_peer_after_user_enable: true
  delete_peer_after_user_deleted: false
  self_provisioning_allowed: false
  import_existing: true
  restore_state: true

backend:
  default: local
  local_resolvconf_prefix: tun.

advanced:
  log_level: info
  log_pretty: false
  log_json: false
  start_listen_port: 51820
  start_cidr_v4: 10.11.12.0/24
  use_ip_v6: false
  config_storage_path: "/root/wgconfig"
  expiry_check_interval: 15m
  rule_prio_offset: 20000
  route_table_offset: 20000
  api_admin_only: true
  limit_additional_user_peers: 0

database:
  debug: false
  slow_query_threshold: "0"
  type: sqlite
  dsn: data/sqlite.db
  encryption_passphrase: ""

statistics:
  use_ping_checks: true
  ping_check_workers: 10
  ping_unprivileged: false
  ping_check_interval: 1m
  data_collection_interval: 1m
  collect_interface_data: true
  collect_peer_data: true
  collect_audit_data: true
  listening_address: :8787

mail:
  host: 127.0.0.1
  port: 25
  encryption: none
  cert_validation: true
  username: ""
  password: ""
  auth_type: plain
  from: Wireguard Portal <noreply@wireguard.local>
  link_only: false
  allow_peer_email: false

auth:
  oidc: []
  oauth: []
  ldap: []
  webauthn:
    enabled: true
  min_password_length: 16
  hide_login_form: false

web:
  listening_address: 192.168.100.249:8888
  external_url: http://192.168.100.249:8888
  site_company_name: WireGuard Portal
  site_title: WireGuard Portal
  session_identifier: wgPortalSession
  session_secret: very_secret
  csrf_secret: extremely_secret
  request_logging: false
  expose_host_info: false
  cert_file: ""
  key_File: ""

webhook:
  url: ""
  authentication: ""
  timeout: 10s
~~~~

4. Eventually add prometheus scrape job
~~~
  - job_name: wg-portal
    scrape_interval: 60s
    static_configs:
      - targets: ['192.168.100.249:8787']
~~~
