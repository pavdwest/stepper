module Stepper
  class MockApi
      def self.get_name
          ['John', 'Jane', 'Bender', 'Andrew', 'Anthony'].sample
      end
  end
end
