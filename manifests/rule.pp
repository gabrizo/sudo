# sudo::rule
#
# A defined type to manage puppet rules
#
# @summary manage sudo rules using puppet
#
# @example
#   sudo::rule { 'admin':
#     user    => '%admin',
#     command => '/sbin/shutdown', 
#   }
define sudo::rule(
  $command    = 'ALL',
  $context    = '/etc/sudoers',
  $host       = 'ALL',
  $runas_user = 'ALL',
  $nopasswd   = false,
  $user       = undef,
) {

  validate_bool($nopasswd)
  if $user {
    validate_string($user)
    $sudoer = $user
  } else {
    $sudoer = $title
  }

  validate_string($context, $host, $runas_user)
  if $command {
    validate_string($command)
  }

  if ($nopasswd){
    $changes = [
      "set spec[user = '${sudoer}']/user '${sudoer}'",
      "set spec[user = '${sudoer}']/host_group/host '${host}'",
      "set spec[user = '${sudoer}']/host_group/command '${command}'",
      "set spec[user = '${sudoer}']/host_group/command/runas_user '${runas_user}'",
      "set spec[user = '${sudoer}']/host_group/command/tag NOPASSWD",
    ]
  } else {
    $changes = [
      "set spec[user = '${sudoer}']/user '${sudoer}'",
      "set spec[user = '${sudoer}']/host_group/host '${host}'",
      "set spec[user = '${sudoer}']/host_group/command '${command}'",
      "set spec[user = '${sudoer}']/host_group/command/runas_user '${runas_user}'",
    ]
  }

  augeas { $title:
    context => "/files${context}",
    lens    => 'Sudoers.lns',
    changes => $changes,
  }
}
