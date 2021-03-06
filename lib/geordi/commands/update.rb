desc 'update', 'Bring a project up to date'
long_desc <<-LONGDESC
Example: `geordi update`

Performs: `git pull`, `bundle install` (if necessary) and migrates (if applicable).
LONGDESC

option :dump, type: :string, aliases: '-d', banner: 'TARGET',
  desc: 'After updating, dump the TARGET db and source it into the development db'
option :test, type: :boolean, aliases: '-t', desc: 'After updating, run tests'

def update
  Interaction.announce 'Updating repository'
  Util.run!('git pull', show_cmd: true)

  invoke_geordi 'migrate'

  Interaction.success 'Successfully updated the project.'

  invoke_geordi 'dump', options.dump, load: true if options.dump
  invoke_geordi 'tests' if options.test
end
