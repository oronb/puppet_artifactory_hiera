#!/usr/bin/env ruby
$architecture = Facter["architecture"].value()
Facter.add(:java_home_8) do
  confine :kernel  => :linux
  setcode do
    distid = Facter.value(:osfamily)
    case distid
    when 'RedHat'
	Facter::Util::Resolution.exec("find / -name 'java-1.8.0-openjdk*#$architecture' | grep /usr/lib/jvm/")
	#Facter::Util::Resolution.exec("cat /tmp/oron | grep #$architecture")
    when 'Debian'
     # Facter::Util::Resolution.exec("find / -name 'java-8-openjdk*#$architecture' | grep /usr/lib/jvm/")
    end
  end
end
