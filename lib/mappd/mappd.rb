module Mappd
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def index(name, options = {})
      commands << [:add_index, [table_name, name, options]]
    end

    def rename(from, to)
      commands << [:rename_column, [table_name, from, to]]
    end

    def field(name, type = :string, options = {})
      commands << [:add_column, [table_name, name, type, options]]
    end

    def timestamps
      commands << [:add_timestamps, [table_name, null: true]]
    end

    def associations!
      reflect_on_all_associations.each do |association|
        case association.macro
        when :belongs_to
          commands << [:add_reference, [table_name, association.name, {}]]
        when :has_and_belongs_to_many
          commands << [:create_join_table,
                       [table_name.to_sym, association.name]]
        end
      end
    end

    def migrate!
      create_table!
      associations!
      execute_commands!
    end

    def commands
      @commands ||= []
    end

    private

    def create_table!
      connection.create_table(table_name) unless
      connection.table_exists?(table_name)
    end

    def execute_commands!
      commands.each do |command|
        if column_exists?(command)
          connection.send(:change_column, *command[1])
        else
          connection.send(command[0], *command[1])
        end
      rescue ActiveRecord::StatementInvalid => e
        warn(e)
      end
      reset!
    end

    def reset!
      reset_column_information
      @commands = []
    end

    def column_exists?(command)
      command[0] == :add_column &&
        connection.column_exists?(table_name, command[1][1])
    end

    def warn(message)
      @logger ||= Logger.new(nil)
      @logger.warn(message)
    end
  end
end
