# Defines a ppa repository mirrored to a local AZ
define apt::ppa_mirror(
  $ensure            = 'present',
  $options           = $::apt::ppa_mirror_options,
  $release           = undef,
  $location          = undef,
  $allow_unsigned    = false,
  $architecture      = undef,
  $pin               = undef,
  $include           = {},
  $comment           = $name,
  $repos             = 'main',
  $include_src       = undef,
  $include_deb       = undef,
  $required_packages = undef,
  $key_content       = undef,
  $key_source        = undef,
  $key_id            = undef,
  $key_server        = undef,
  $key_options       = undef
  ) {

    if ! $location {
      fail ('Mirrored location is required')
    }

    if ! $key_id {
      fail ('Key ID is required for verification (hash)')
    }

    if ! $key_content and ! $key_source {
      fail ('Key Content or Source is required')
    }

    $_key = {
      'id'      => $key_id,
      'server'  => $key_server,
      'content' => $key_content,
      'source'  => $key_source,
      'options' => $key_options
    }

    apt::source { $title:
      ensure            => $ensure,
      comment           => $comment,
      location          => $location,
      release           => $release,
      repos             => $repos,
      include           => $include,
      key               => $_key,
      pin               => $pin,
      architecture      => $architecture,
      allow_unsigned    => $allow_unsigned,
      include_src       => $include_src,
      include_deb       => $include_deb,
      required_packages => $required_packages
    }
}
