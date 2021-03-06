require 'thor'

module PhilColumns
  class Cli
    class Generate < Thor

      def self.banner( command, namespace=nil, subcommand=false )
        return "#{basename} generate help [SUBCOMMAND]" if command.name == 'help'
        "#{basename} #{command.usage}"
      end

      desc "generate seed NAME", "Generate a seed class"
      long_desc <<-LONGDESC
        Generate a seed file with name NAME.
      LONGDESC
      def seed( name )
        PhilColumns::Command::Generate::Seed.new( options.merge( seed_name: name )).execute
      end

      def self.handle_argument_error( command, error, _, __ )
        method = "handle_argument_error_for_#{command.name}"

        if respond_to?( method )
          send( method, command, error )
        else
          handle_argument_error_default( command, error )
        end
      end

      def self.handle_argument_error_default( command, error )
        $stdout.puts "Incorrect usage of generate subcommand: #{command.name}"
        $stdout.puts "  #{error.message}", ''
        $stdout.puts "For correct usage:"
        $stdout.puts "  phil_columns generate help #{command.name}"
      end

      def self.handle_no_command_error( name )
        $stdout.puts "Unrecognized command: #{name}"
      end

    end
  end
end
