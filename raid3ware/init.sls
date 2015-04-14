# * install tar.gz to /opt
# * add sudo config
# * add helper script



raid3ware_helper:
  file.managed:
    - name: /opt/3ware/bin/check_3ware_raid_helper
    - source: salt://raid3ware/files/check_3ware_raid_helper

raid3ware_sudo_package:
  pkg.installed:
    - pkgs:
      - sudo

raid3ware_sudoersd:
  file.managed:
    - name: /etc/sudoers.d/sudoers_snmp_3ware
    - source: salt://raid3ware/files/sudoers_snmp_3ware

