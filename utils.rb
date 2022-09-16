module Stepper
  require 'text-table'

  class Utils
    def self.get_class_by_name(module_name, class_name)
      Object.const_get(module_name).const_get(class_name)
    end

    def self.get_abs_path_from_file(file, relative_path)
      filedir = Pathname(file).parent
      File.join(File.expand_path(filedir), relative_path)
    end

    def self.write_h1(text)
      self.write_header('=', text)
    end

    def self.write_h2(text)
      self.write_header('*', text)
    end

    def self.write_h3(text)
      self.write_header('-', text)
    end

    def self.write_header(character, text)
      len = text.size + 4*2
      puts character * len
      puts character * 3 + " #{text} " + character * 3
      puts character * len
    end

    def self.print_hash_as_text_table(hash)
      table = Text::Table.new(
        :head => hash.keys,
        :rows => [hash.values]
      )
      puts table
    end
  end
end
