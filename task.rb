module Stepper
  require_relative 'mock_endpoints'

  class Task
    attr_accessor :name,
                  :input,
                  :output,
                  :status,
                  :result,
                  :parent,
                  :process,
                  :start_time,
                  :end_time,
                  :duration

    def initialize(
      name: ,
      step: ,
      input_params_hash:
    )
      @name = name
      @step = step
      @input = input_params_hash
      puts "Init task: #{@name}"
    end

    def perform
      @start_time = Time.now.getutc
      Utils.write_h2 "Performing '#{name}' (task #{@step} of #{@process.tasks.size})"
    end

    def finish
      puts "Finished '#{name}'"
      puts ''
      @end_time = Time.now.getutc
      @duration = @end_time - @start_time
    end
  end

  class CallApiTask < Task
  end

  class GetNameTask < CallApiTask
    def perform
      super()

      url = @input['url']
      slug = @input['slug']
      name  = eval("MockApi.#{slug}")
      puts "Getting name from API: '#{url}/#{slug}'...'#{name}'"

      # Create output
      @output = {
        "name": name
      }
    end
  end

  class GetFileContentsTask < Task
    require 'yaml'

    def perform
      super()
      filepath = @input['path']
      puts "Getting file contents of '#{filepath}'"

      # Create output
      @output = {
        'value': YAML.load_file(
          Utils.get_abs_path_from_file(
            @process.config_file_path,
            filepath
          )
        )['value'].to_i
      }
    end
  end

  class TalkToUserTask < Task
    def perform
      super()
      prepend = @input['prepend']
      name = @parent.output['name'.to_sym]
      append = @input['append']
      puts "#{prepend} #{name}, #{append}."
    end
  end

  class CompareValuesTask < Task
    def perform
      super()
      start_val = @process.get_task_by_name(@input['starting_value']).output['value'.to_sym]
      end_val = @process.get_task_by_name(@input['ending_value']).output['value'.to_sym]
      @output = {
        'starting_value': start_val,
        'ending_value': end_val,
        'diff_arithmetic': end_val - start_val,
        'diff_geometric': 100.0 * (end_val.to_f / start_val.to_f - 1.0)
      }
      Utils.print_hash_as_text_table @output
    end
  end
end
