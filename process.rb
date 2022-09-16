module Stepper
  class Process
    require 'yaml'
    require_relative 'utils'

    attr_accessor :name,
                  :description,
                  :tasks,
                  :config,
                  :config_file_path

    def initialize(config_file_path)
      @config_file_path = config_file_path
      @config = YAML.load_file(config_file_path)

      # Get basic info
      @name = @config['name']
      @description = @config['description']
      greet

      # Create tasks
      # TODO: Bulk could probably be moved to the base Task class
      puts 'Deserialising tasks...'
      @tasks = []
      @config['tasks'].each_with_index do |t, i|
        task_details = t.values.first
        task_class = Utils.get_class_by_name(
          'Stepper',
          task_details['type']
        )
        task = task_class.new(
          name: t.keys.first,
          step: i + 1,
          input_params_hash: task_details['input']
        )
        parent_task_name = task_details['parent_task_name']
        task.parent = get_task_by_name(parent_task_name) unless parent_task_name.nil?
        task.process = self

        @tasks << task
      end

      # TODO: Ensure th parents are executed before the child
      puts "Tasks loaded."
    end

    def greet
      Utils.write_h1 @name
      puts "Description: #{@description}"
    end

    def run
      puts "Running process..."
      @tasks.each do |task|
        task.perform
        task.finish
      end
      summarise
      puts 'Done!'
    end

    def summarise
      require 'text-table'
      Utils.write_h2 'Summary'
      puts "Completed #{@tasks.size} tasks."

      rows = []
      @tasks.each do |t|
        rows << [t.name, "#{'%.6f' % t.duration}"]
      end

      table = Text::Table.new(
        :head => ['Task', 'Duration'],
        :rows => rows
      )
      puts table
    end

    def get_task_by_name(name)
      @tasks.select { |t| t.name.to_sym == name.to_sym }.first
    end
  end
end
