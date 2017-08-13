# Class: munki_prefs
# ===========================
#
# This class manages all available preferences for Munki https://github.com/munki/munki
# The class is Munki version aware and will only set the preferences
# that are relevent to the installed version of Munki.
# Unrequired default preferences are remove from the plist file.
# 
# Facts
# -----
# 
# The following facts are provided by this module
# 
# munki_http_headers:
#   Array: The contents of the 'additionalhttpheaders' preference array on the disk.
# 
# munki_client_version
#   Nested Values:
#     full:
#       String: Full Munki Version
#     major:
#       String: Munki Major Version Number
#     minor:
#       String: Munki Minor Version Number
#     patch:
#       String: Munki Patch Version Number
#
# Parameters
# ----------
# All parameter descriptions taken from the official Munki Wiki
# https://github.com/munki/munki/wiki/Preferences
#
# * `applesoftwareupdatesonly`
# If true, only install updates from an Apple Software Update server.
# No Munki repository is needed or used.
#   Default Value: false
# 
# * `installapplesoftwareupdates`
# If true, install updates from an Apple Software Update server, 
# in addition to "regular" Munki updates.
#   Default Value: false
#
# * `unattendedappleupdates`
# If true, updates that declare no "must-close" applications, 
# or have one or more "must-close" applications, none of which is running, 
# and do not require a logout or restart will be installed as part of a 
# normal periodic background run without notifying the user. 
# (OS X 10.10+, Munki 2.5+)
#   Default Value: false
#
# * `softwareupdateserverurl`
# Catalog URL for Apple Software Updates. If undefined or empty, 
# Munki will use the same catalog that the OS uses when you run 
# Apple's Software Update application or call /usr/sbin/softwareupdate.
#   Default Value: Empty String
#
# * `softwarerepourl`
# Base URL for Munki repository
#   Default Value: 'http://munki/repo'
#
# * `packageurl`
# Base URL for Munki pkgs. Useful if your packages are served from
# a different server than your catalogs or manifests.
#   Default Value: "$softwarerepourl/pkgs"
# 
# * `catalogurl`
# Base URL for Munki catalogs. Useful if your catalogs are served from
# a different server than your packages or manifests.
#   Default Value: "$softwarerepourl/catalogs"
# 
# * `manifesturl`
# Base URL for Munki manifests. Useful if your manifests are served
# from a different server than your catalogs or manifests.
#   Default Value: "$softwarerepourl/manifests"
# 
# * `iconurl`
# Base URL for product icons. Useful if your icons are served from
# a different server or different directory than the default.
#   Default Value: "$softwarerepourl/icons"
# 
# * `clientresourceurl`
# Base URL for custom client resources for Managed Software Center. 
# Useful if your resources are served from a different server or
# different directory than the default.
#   Default Value: "$softwarerepourl/client_resources"
# 
# * `clientresourcesfilename`
# Specific filename to use when requesting custom client resources.
# Default Value: Empty String
# 
# * `helpurl`
# If defined, a URL to open/display when the user selects 
# "Managed Software Center Help" from Managed Software Center's Help menu.
#   Default Value: Empty String
# 
# * `clientidentifier`
# Identifier for Munki client. Usually is the same as a manifest name
# on the Munki server. If this is empty or undefined, 
# Munki will attempt the following identifiers, 
# in order: fully-qualified hostname, "short" hostname,
# serial number, and finally "site_default".
#   Default Value: Empty String
# 
# * `managedinstalldir`
# Folder where Munki keeps its data on the client.
#   Default Value: '/Library/Managed Installs'
# 
# * `logfile`
# Primary log is written to this file. Other logs are 
# written into the same directory as this file.
#   Default Value: '/Library/Managed Installs/Logs/ManagedSoftwareUpdate.log'
# 
# * `logtosyslog`
# If true, log to syslog in addition to ManagedSoftwareUpdate.log.
#   Default Value: false
# 
# * `logginglevel`
# Higher values cause more detail to be written to the primary log.
#   Default Value: 1
# 
# * `daysbetweennotifications`
# Number of days between user notifications from Managed Software Center.
# Set to 0 to have Managed Software Center notify every time a 
# background check runs if there are available updates.
#   Default Value: 1
# 
# * `usenotificationcenterdays`
# (New in Munki 3) Number of days Notification Center notifications 
# should be used before switching to launching Managed Software Center.
#   Default Value: 3
# 
# * `useclientcertificate`
# If true, use an SSL client certificate when communicating with 
# the Munki server. Requires an https:// URL for the Munki repo.
#   Default Value: false
# 
# * `useclientcertificatecnasclientidentifier`
# If true, use the CN of the client certificate as the Client Identifier.
# Used in combination with the UseClientCertificate key.
#   Default Value: false
# 
# * `softwarerepocapath`
# Path to the directory that stores your CA certificate(s). 
# See the curl man page for more details on this parameter.
#   Default Value: Empty String
# 
# * `softwarerepocacertificate`
# Absolute path to your CA Certificate.
#   Default Value: Empty String
# 
# * `clientcertificatepath`
# Absolute path to a client certificate. 
# There are 3 defaults for this key. Concatenated cert/key PEM 
# file accepted.
#   Default Value: Empty String
# 
# * `clientkeypath`
# Absolute path to a client private key.
#   Default Value: Empty String
# 
# * `additionalhttpheaders`
# This key provides the ability to specify custom HTTP headers 
# to be sent with all curl() HTTP requests. AdditionalHttpHeaders 
# must be an array of strings with valid HTTP header format.
#   Default Value: Empty Array
# 
# * `packageverificationmode`
# Controls how Munki verifies the integrity of downloaded packages. 
# Possible values are: 
#   none: No integrity check is performed. 
#   hash: Integrity check is performed if package info contains 
#     checksum information. 
#   hash_strict: Integrity check is performed, 
#     and fails if package info does not contain checksum information.
#   Default Value: 'hash'
# 
# * `suppressusernotification`
# If true, Managed Software Center will never notify the user 
# of available updates. Managed Software Center can still be 
# manually invoked to discover and install updates.
#   Default Value: false
# 
# * `suppressautoinstall`
# If true, Munki will not automatically install or remove items.
#   Default Value: false
# 
# * `suppressloginwindowinstall`
# If true, Munki will not install items while idle at 
# the loginwindow except for those marked for unattended_install 
# or unattended_uninstall.
#   Default Value: false
# 
# * `suppressstopbuttononinstall`
# If true, Managed Software Center will hide the stop button 
# while installing or removing software, preventing users 
# from interrupting the install.
#   Default Value: false
# 
# * `installrequireslogout`
# If true, Managed Software Center will require a logout 
# for all installs or removals.
#   Default Value: false
# 
# * `showremovaldetail`
# If true, Managed Software Center will display detail for 
# scheduled removals.
#   Default Value: false
# 
# * `msulogenabled`
# Log user actions in the GUI.
#   Default Value: false
# 
# * `msudebuglogenabled`
# Debug logging for Managed Software Center.
#   Default Value: false
# 
# * `localonlymanifest`
# Defines the name of your LocalOnlyManifest. Setting this 
# activates the feature. Unsetting it means Munki will remove
# the file on the next run.
#   Default Value: Empty String
# 
# * `followhttpredirects`
# Defines whether Munki will follow all, some or no redirects 
# from the web server.
#   Default Value: 'none'
# 
# * `ignoresystemproxies`
# If true, HTTP and/or HTTPS proxies set system-wide will be 
# ignored, connections will be made directly.
#   Default Value: false
# 
# * `performauthrestarts`
# (New in Munki 3) If true, Munki will attempt to perform a 
# filevault auth restart.
#   Default Value: false
# 
# * `recoverykeyfile`
# (New in Munki 3) Absolute path to a plist file containing 
# filevault credentials in key/value format. 
# Used to perform auth restarts.
#   Default Value: Empty String
# 
# Variables
# ----------
#
# There are no required variables for this class, however applying it
# without customising any of the relevent parameters for your environemnt
# will result in the same file that Munki would write out by itself anyway.
# 
# Examples
# --------
#
# @example
#    class { 'munki_prefs':
#      softwarerepourl => 'http://munki.example.domain/repo',
#    }
#
# Authors
# -------
#
# Matt Cahill
#
# Copyright
# ---------
#
# Copyright 2017 Matt Cahill, unless otherwise noted.
#
class munki_prefs (
  Boolean                             $applesoftwareupdatesonly                 = false,
  Boolean                             $installapplesoftwareupdates              = false,
  Boolean                             $unattendedappleupdates                   = false,
  String                              $softwareupdateserverurl                  = '',
  String                              $softwarerepourl                          = 'http://munki/repo',
  String                              $packageurl                               = "$softwarerepourl/pkgs",
  String                              $catalogurl                               = "$softwarerepourl/catalogs",
  String                              $manifesturl                              = "$softwarerepourl/manifests",
  String                              $iconurl                                  = "$softwarerepourl/icons",
  String                              $clientresourceurl                        = "$softwarerepourl/client_resources",
  String                              $clientresourcesfilename                  = '',
  String                              $helpurl                                  = '',
  String                              $clientidentifier                         = '',
  String                              $managedinstalldir                        = '/Library/Managed Installs',
  String                              $logfile                                  = '/Library/Managed Installs/Logs/ManagedSoftwareUpdate.log',
  Boolean                             $logtosyslog                              = false,
  Integer                             $logginglevel                             = 1,
  Integer                             $daysbetweennotifications                 = 1,
  Integer                             $usenotificationcenterdays                = 3,
  Boolean                             $useclientcertificate                     = false,
  Boolean                             $useclientcertificatecnasclientidentifier = false,
  String                              $softwarerepocapath                       = '',
  String                              $softwarerepocacertificate                = '',
  String                              $clientcertificatepath                    = '',
  String                              $clientkeypath                            = '',
  Array[String]                       $additionalhttpheaders                    = [],
  Enum['none', 'hash', 'hash_strict'] $packageverificationmode                  = 'hash',
  Boolean                             $suppressusernotification                 = false,
  Boolean                             $suppressautoinstall                      = false,
  Boolean                             $suppressloginwindowinstall               = false,
  Boolean                             $suppressstopbuttononinstall              = false,
  Boolean                             $installrequireslogout                    = false,
  Boolean                             $showremovaldetail                        = false,
  Boolean                             $msulogenabled                            = false,
  Boolean                             $msudebuglogenabled                       = false,
  String                              $localonlymanifest                        = '',
  Enum['none', 'https', 'all']        $followhttpredirects                      = 'none',
  Boolean                             $ignoresystemproxies                      = false,
  Boolean                             $performauthrestarts                      = false,
  String                              $recoverykeyfile                          = '',
){
  # Preferences that munki writes to disk on every run, to avoid constant resource 
  # applications we don't want to remove these even if they are at default values.
  $written_preferences = [
    "AppleSoftwareUpdatesOnly",
    "ManagedInstallDir",
    "LogFile",
    "LogToSyslog",
    "LoggingLevel",
    "DaysBetweenNotifications",
    "UseClientCertificate",
    "PackageVerificationMode",
    "SuppressUserNotification",
    "SuppressAutoInstall",
    "SuppressStopButtonOnInstall",
    "FollowHTTPRedirects",
    "SoftwareUpdateServerURL",
    "ClientIdentifier",
    "InstallAppleSoftwareUpdates",
    "SoftwareRepoURL",
    "UnattendedAppleUpdates",
  ]
  # Default values for munki preferences, if a preference is not in the list above
  # and matches a default we'll remove it from the plist for tidyness.
  $munki_default_values = {
    "AppleSoftwareUpdatesOnly"                 => false,
    "InstallAppleSoftwareUpdates"              => false,
    "SoftwareUpdateServerURL"                  => '',
    "SoftwareRepoURL"                          => 'http://munki/repo',
    "PackageURL"                               => "$softwarerepourl/pkgs",
    "CatalogURL"                               => "$softwarerepourl/catalogs",
    "ManifestURL"                              => "$softwarerepourl/manifests",
    "ClientIdentifier"                         => '',
    "ManagedInstallDir"                        => '/Library/Managed Installs',
    "LogFile"                                  => '/Library/Managed Installs/Logs/ManagedSoftwareUpdate.log',
    "LogToSyslog"                              => false,
    "LoggingLevel"                             => 1,
    "DaysBetweenNotifications"                 => 1,
    "UseClientCertificate"                     => false,
    "UseClientCertificateCNAsClientIdentifier" => false,
    "SoftwareRepoCAPath"                       => '',
    "SoftwareRepoCACertificate"                => '',
    "ClientCertificatePath"                    => '',
    "ClientKeyPath"                            => '',
    "AdditionalHttpHeaders"                    => [],
    "PackageVerificationMode"                  => 'hash',
    "SuppressUserNotification"                 => false,
    "SuppressAutoInstall"                      => false,
    "SuppressLoginwindowInstall"               => false,
    "SuppressStopButtonOnInstall"              => false,
    "InstallRequiresLogout"                    => false,
    "ShowRemovalDetail"                        => false,
    "MSULogEnabled"                            => false,
    "MSUDebugLogEnabled"                       => false,
    "LocalOnlyManifest"                        => '',
    "FollowHTTPRedirects"                      => 'none',
    "IgnoreSystemProxies"                      => false,
    "UnattendedAppleUpdates"                   => false,
    "IconURL"                                  => "$softwarerepourl/icons",
    "ClientResourceURL"                        => "$softwarerepourl/client_resources",
    "ClientResourcesFilename"                  => '',
    "HelpURL"                                  => '',
    "UseNotificationCenterDays"                => 3,
    "PerformAuthRestarts"                      => false,
    "RecoveryKeyFile"                          => '',
  }
  # Map the module params to their plist key names
  $munki_1_prefs = {
    "AppleSoftwareUpdatesOnly"                 => $applesoftwareupdatesonly,
    "InstallAppleSoftwareUpdates"              => $installapplesoftwareupdates,
    "SoftwareUpdateServerURL"                  => $softwareupdateserverurl,
    "SoftwareRepoURL"                          => $softwarerepourl,
    "PackageURL"                               => $packageurl,
    "CatalogURL"                               => $catalogurl,
    "ManifestURL"                              => $manifesturl,
    "ClientIdentifier"                         => $clientidentifier,
    "ManagedInstallDir"                        => $managedinstalldir,
    "LogFile"                                  => $logfile,
    "LogToSyslog"                              => $logtosyslog,
    "LoggingLevel"                             => $logginglevel,
    "DaysBetweenNotifications"                 => $daysbetweennotifications,
    "UseClientCertificate"                     => $useclientcertificate,
    "UseClientCertificateCNAsClientIdentifier" => $useclientcertificatecnasclientidentifier,
    "SoftwareRepoCAPath"                       => $softwarerepocapath,
    "SoftwareRepoCACertificate"                => $softwarerepocacertificate,
    "ClientCertificatePath"                    => $clientcertificatepath,
    "ClientKeyPath"                            => $clientkeypath,
    "AdditionalHttpHeaders"                    => $additionalhttpheaders,
    "PackageVerificationMode"                  => $packageverificationmode,
    "SuppressUserNotification"                 => $suppressusernotification,
    "SuppressAutoInstall"                      => $suppressautoinstall,
    "SuppressLoginwindowInstall"               => $suppressloginwindowinstall,
    "SuppressStopButtonOnInstall"              => $suppressstopbuttononinstall,
    "InstallRequiresLogout"                    => $installrequireslogout,
    "ShowRemovalDetail"                        => $showremovaldetail,
    "MSULogEnabled"                            => $msulogenabled,
    "MSUDebugLogEnabled"                       => $msudebuglogenabled,
    "LocalOnlyManifest"                        => $localonlymanifest,
    "FollowHTTPRedirects"                      => $followhttpredirects,
    "IgnoreSystemProxies"                      => $ignoresystemproxies,
  }
  $munki_2_prefs = {
    "UnattendedAppleUpdates"                   => $unattendedappleupdates,
    "IconURL"                                  => $iconurl,
    "ClientResourceURL"                        => $clientresourceurl,
    "ClientResourcesFilename"                  => $clientresourcesfilename,
    "HelpURL"                                  => $helpurl,
  }
  $munki_3_prefs = {
    "UseNotificationCenterDays"                => $usenotificationcenterdays,
    "PerformAuthRestarts"                      => $performauthrestarts,
    "RecoveryKeyFile"                          => $recoverykeyfile,
  }

  if $::kernel != 'Darwin' {
    fail("This module handles application preferences for Munki. Which only works on OS X.")
  }
  # Merge the required preference and defaults hashes based on the client's version of munki
  if versioncmp("${::clientversion}", '4.0.0') >= 0 {
    if $facts['munki_client_version']['major'] == "3" {
      $munki_prefs = $munki_1_prefs + $munki_2_prefs + $munki_3_prefs
    } elsif $facts['munki_client_version']['major'] == "2" {
      $munki_prefs = $munki_1_prefs + $munki_2_prefs
    } else {
      $munki_prefs = $munki_1_prefs
    }
  } else {
    $munki_prefs = $munki_1_prefs
  }
  # Iterate through each of the settings taking action based on preference data type.
  $munki_prefs.each |$setting, $value| {
    # Assign command line switch based on preference data type.
    $type_switch = $value ? {
      String  => '-string',
      Integer => '-int',
      Boolean => '-bool',
      Array   => '-array-add',
      default => '-string',
    }
    # Remap grep search value for booleans because defaults command prints 1/0 not true/false
    $match_value = $value ? {
      true    => "1",
      false   => "0",
      default => $value,
    }
    # Do what's required.
    case $value {
      String, Integer, Boolean: {
        # String, Integer, Boolean all get handled the same, default values are deleted unless in the list.
        # Non-default values are written out.
        if $value == $munki_default_values[$setting] {
          if $setting in $written_preferences {
            exec { "munki_prefs_add/$setting/$value":
              command => "/usr/bin/defaults write /Library/Preferences/ManagedInstalls $setting $type_switch \"$value\"",
              unless  => "/usr/bin/defaults read /Library/Preferences/ManagedInstalls $setting | /usr/bin/egrep -q \'^$match_value\$\'",
            }
          } else {
            exec { "munki_prefs_delete/$setting":
              command => "/usr/bin/defaults delete /Library/Preferences/ManagedInstalls $setting",
              onlyif  => "/usr/bin/defaults read /Library/Preferences/ManagedInstalls $setting",
            }
          }
        } else {
          exec { "munki_prefs_add/$setting/$value":
            command => "/usr/bin/defaults write /Library/Preferences/ManagedInstalls $setting $type_switch \"$value\"",
            unless  => "/usr/bin/defaults read /Library/Preferences/ManagedInstalls $setting | /usr/bin/egrep -q \'^$match_value\$\'",
          }
        }
      }
      Array: {
        # The (currently) singular Array, AdditionalHttpHeaders, is handled as follows:
        # A fact is used to check the current state of the array (the only way to know).
        # If the Array is at its default value we remove it and if it's different from the collected fact
        # we delete it and write it out again using array-add. This is not really sustainable if the number of arrays increases.
        # Maybe collect all the arrays for the domain like this but nice: # defaults read /Library/Preferences/ManagedInstalls | egrep -v '\{|\}' | awk '{print $1}' | while read line ; do echo -n "$line " ; defaults read-type /Library/Preferences/ManagedInstalls "$line" ; done | grep array | awk '{print $1}'
        if $value == $munki_default_values[$setting] {
          exec { "munki_prefs_delete/$setting":
            command => "/usr/bin/defaults delete /Library/Preferences/ManagedInstalls $setting",
            onlyif  => "/usr/bin/defaults read /Library/Preferences/ManagedInstalls $setting",
          }
        } elsif $value != $munki_http_headers {
          exec { "munki_prefs_delete/$setting":
            command => "/usr/bin/defaults delete /Library/Preferences/ManagedInstalls $setting",
            onlyif  => "/usr/bin/defaults read /Library/Preferences/ManagedInstalls $setting",
          }
          $value.each |$array_value|{
            exec { "munki_prefs_add/$setting/$array_value":
              command => "/usr/bin/defaults write /Library/Preferences/ManagedInstalls $setting $type_switch $array_value",
              unless  => "/usr/bin/defaults read /Library/Preferences/ManagedInstalls $setting | /usr/bin/egrep -q \'^.*\\\"?$array_value\\\"?[,]?\$\'",
              require => Exec["munki_prefs_delete/$setting"],
            }
          }
        }
      }
      default: {}
    }
  }
}