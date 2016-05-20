class roles::mysql {
    $mysql = hiera_hash('mysql')

    # install mysql
    class { '::mysql::server':
        root_password => $mysql['root_password'],
    }

    # create schemas
    $mysql['databases'].each |$mysql_schema| {
        # for each defined hiera mysql schema, create it
        mysql_database { "${mysql_schema['name']}":
            charset => $mysql_schema['charset'],
            collate => $mysql_schema['collate'],
        }
    }

    # create users and permissions
    $mysql['users'].each |$mysql_user| {
        # for each defined hiera mysql user, create them
        mysql_user { "${mysql_user['name']}@${mysql_user['host']}":
            ensure        => present,
            password_hash => mysql_password("${mysql_user['password']}")
        }

        $mysql_user['grants'].each |$mysql_grant| {
            # for each grant for each user, create them
            mysql_grant { "${mysql_user['name']}@${mysql_user['host']}/${mysql_grant['table']}":
                ensure     => present,
                user       => "${mysql_user['name']}@${mysql_user['host']}",
                table      => $mysql_grant['table'],
                options    => $mysql_grant['options'],
                privileges => $mysql_grant['privileges'],
            }
        }
    }

    # create the users, then create the grants
    Mysql_user <| |> -> Mysql_grant <| |>
}
