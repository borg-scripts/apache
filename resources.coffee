module.exports = ->
  _.assign @,
    apache_site: (name, [o]...) => (cb) =>
      switch o?.action
        when 'enable'
          @template o.template,
            to: "/etc/apache2/sites-available/#{name}.conf"
            sudo: true
            owner: 'root'
            group: 'root'
            mode: '0755'
            =>
              @execute "a2ensite #{name}", sudo: true, cb
        when 'disable'
          @execute "a2dissite #{name}", sudo: true, cb
        else
          @die("invalid action passed to @apache_site(): #{name}")() # immediate death

    apache_module: (name, [o]...) => (cb) =>
      switch o?.action
        when 'enable'
          @execute "a2enmod #{name}", sudo: true, cb
        when 'disable'
          @execute "a2dismod #{name}", sudo: true, cb
        else
          @die("invalid action passed to @apache_module(): #{name}")() # immediate death
