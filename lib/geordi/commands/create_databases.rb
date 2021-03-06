desc 'create-databases', 'Create all databases', hide: true
def create_databases
  invoke_geordi 'create_database_yml'
  invoke_geordi 'bundle_install'

  Interaction.announce 'Creating databases'

  if File.exist?('config/database.yml')
    command = []
    command << Util.binstub_or_fallback('rake')
    command << 'db:create:all'
    command << 'parallel:create' if Util.file_containing?('Gemfile', /parallel_tests/)

    Util.run!(command)
  else
    puts 'config/database.yml does not exist. Nothing to do.'
  end
end
