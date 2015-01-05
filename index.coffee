module.exports = ->
  @import __dirname, 'attributes', 'default'
  @then @install 'apache2 apache2-utils'

  @then @template [__dirname, 'templates', 'default', 'ports.conf'],
    to: "/etc/apache2/ports.conf"
    sudo: true
    owner: 'root'
    group: 'root'
    mode: '0644'
