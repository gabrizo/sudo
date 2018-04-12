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
  $command    = undef,
  $context    = '/etc/sudoers',
  $host       = 'ALL',
  $runas_user = 'ALL',
  $tag        = undef,
  $user       = undef,
) {
  
  validate_string($context, $host, $runas_user)
  if $command {
    validate_string($command)
  }
  
  if $tag {
    validate_string($tag)
  }

  augeas { "$title": 
    context => "/files$context",
    lens    =>  "Sudoers.lns",
    changes => [
      "set spec[user = '$user']/user $user",
      "set spec[user = '$user']/host_group/host $host",
      "set spec[user = '$user']/host_group/command $command",
      "set spec[user = '$user']/host_group/command/runas_user $runas_user",
      "set spec[user = '$user']/host_group/command/tag $tag",      
    ]
  }
}
