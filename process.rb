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
      puts 'Deserialising tasks...'
      @tasks = []
      @config['tasks'].each do |t|
        task_details = t.values.first
        task_class = Utils.get_class_by_name(
          'Stepper',
          task_details['type']
        )
        task = task_class.new(task_details['input'])
        task.name = t.keys.first
        parent_task_name = task_details['parent_task_name']

        # Find parent (if any)
        unless parent_task_name.nil?
          task.parent = @tasks.select do |t|
            t.name == parent_task_name
          end.first
        end

        task.process = self

        @tasks << task
      end

      # TODO: Ensure th parents are executed before the child
      puts "Tasks loaded."
    end

    def greet
      puts "=============================================="
      puts "=== Running process '#{@name}' ==="
      puts "=============================================="
      puts "Description: #{@description}"
    end

    def run
      puts "Running process..."
      @tasks.each do |task|
        task.perform
        task.finish
      end
      puts 'Done!'
    end

    def get_task_by_name(name)
      @tasks.select { |t| t.name.to_sym == name.to_sym }.first
    end
  end
end
