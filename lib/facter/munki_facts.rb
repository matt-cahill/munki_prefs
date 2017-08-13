require "facter"

Facter.add("munki_http_headers") do
  confine :kernel => "Darwin"
  setcode do
    headers = Facter::Util::Resolution.exec("/usr/bin/defaults read /Library/Preferences/ManagedInstalls AdditionalHttpHeaders |  egrep -v '\\\(|\\\)' | sed -e 's/^ *//g'").rstrip.gsub(",\n",",").rstrip.gsub('"','')
    headers.split(',')
  end
end

Facter.add("munki_client_version") do
  confine :kernel => "Darwin"
  setcode do
    result = {}
    munki_version = Facter::Util::Resolution.exec("/usr/local/munki/managedsoftwareupdate --version")
    munki_version_array = munki_version.split('.')
    result = {
      'full'  => munki_version,
      'major' => munki_version_array[0],
      'minor' => munki_version_array[1],
      'patch' => munki_version_array[2],
    }
    result
  end
end