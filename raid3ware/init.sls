# * install tar.gz to /opt
# * add sudo config
# * add helper script


{% from "raid3ware/map.jinja" import raid3ware with context %}


raid3ware_helper:
  file.managed:
    - name: /opt/3ware/bin/check_3ware_raid_helper
    - source: salt://raid3ware/files/check_3ware_raid_helper

raid3ware_install_cli:
  archive.extracted:
    - name: /opt/
    - source: salt://raid3ware/files/cli_linux_10.2.1_9.5.4.tar.gz
    - if_missing: /opt/3ware/bin/tw_cli_noarch

raid3ware_sudo_packages:
  pkg.installed:
    - pkgs: {{ map.sudopkgs }}
      
raid3ware_sudoersd:
  file.managed:
    - name: {{ map.sudodir }}/sudoers_snmp_3ware
    - source: salt://raid3ware/files/sudoers_snmp_3ware
    - require:
      pkg: raid3ware_sudo_packages

raid3ware_snmp_extend:
  file.append:
    - name: {{ map.snmpconf }}
    - text: |
      extend  3WARE   /usr/bin/sudo -u root /opt/3ware/bin/check_3ware_raid_helper


