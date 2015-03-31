module.exports = ->
  _.assign @,
    apache_site: (name, [o]...) => @inject_flow =>
      switch o?.action
        when 'enable'
          @then @template o.template,
            to: "/etc/apache2/sites-available/#{name}.conf"
            sudo: true
            owner: 'root'
            group: 'root'
            mode: '0755'
          @then @execute "a2ensite #{name}", sudo: true
        when 'disable'
          @then @execute "a2dissite #{name}", sudo: true
        else
          @die("invalid action passed to @apache_site(): #{name}")() # immediate death

    apache_module: (name, [o]...) => @inject_flow =>
      switch o?.action
        when 'enable'
          @then @execute "a2enmod #{name}", sudo: true
        when 'disable'
          @then @execute "a2dismod #{name}", sudo: true
        else
          @then @die "invalid action passed to @apache_module(): #{name}" # immediate death
