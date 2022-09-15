module Stepper
  class Utils
    def self.get_class_by_name(module_name, class_name)
      Object.const_get(module_name).const_get(class_name)
    end

    def self.get_abs_path_from_file(file, relative_path)
      filedir = Pathname(file).parent
      File.join(File.expand_path(filedir), relative_path)
    end
  end
end
