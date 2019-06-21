$ports = Get-NetNatStaticMapping -NatName myNATNetwork | Select-Object InternalPort | 
Select-String -Pattern "\d+" |
ForEach-Object {
  $_.Matches.Groups[0].Value
}

$ids = Get-NetNatStaticMapping -NatName myNATNetwork | Select-Object  StaticMappingID | 
Select-String -Pattern "\d+" |
ForEach-Object {
  $_.Matches.Groups[0].Value
}

do {
  $what_to_do = 'x'
  while ( $what_to_do -ne 'q') {
    'Mapped Ports:'
    '-------------------'
    for ($i = 0; $i -lt $ports.Length; $i++) {
      Write-Color -Text $i')', $ports[$i] -Color Gray, White
    }
    '-------------------'
    $what_to_do = Read-Host -Prompt '0-9) Remove port. a) Add new ports c) Clear all ports'

    switch ($what_to_do) {
      "a" {
        $new_ports_string = Read-Host -Prompt 'Add ports'
        $new_ports = $new_ports_string -split ' '
        for ($i = 0; $i -lt $new_ports.Length; $i++) {
          Add-NetNatStaticMapping -ExternalIPAddress "0.0.0.0/24" -ExternalPort $new_ports[$i] -Protocol TCP -InternalIPAddress "192.168.0.2" -InternalPort $new_ports[$i] -NatName myNATNetwork
        }
        break
      }
      "c" {
        Remove-NetNatStaticMapping -NatName myNATNetwork
        break
      }
      default {
        $what_to_do | Select-String -Pattern "\d+" | ForEach-Object {
          $index = $_.Matches.Groups[0].Value
          Remove-NetNatStaticMapping -NatName myNATNetwork -StaticMappingID $ids[$index]
        }
        break
      }
    }    
    $ports = Get-NetNatStaticMapping -NatName myNATNetwork | Select-Object InternalPort | 
    Select-String -Pattern "\d+" |
    ForEach-Object {
      $_.Matches.Groups[0].Value
    }

    $ids = Get-NetNatStaticMapping -NatName myNATNetwork | Select-Object  StaticMappingID | 
    Select-String -Pattern "\d+" |
    ForEach-Object {
      $_.Matches.Groups[0].Value
    }
  }
} while ( $what_to_do -ne "q" )






