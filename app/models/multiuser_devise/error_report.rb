module MultiuserDevise
  class ErrorReport
    # attr_accessor :title, :detail, :status, :links

    def self.generate(errors, status)
      return if errors.nil?

      json = {}

      errors=errors.to_hash(true) if errors.class != Hash
      new_hash = errors.map do |k, v|
        v.map do |msg|
          { id: k.to_s.camelize(:lower), detail: msg, status: status.to_s }
        end
      end.flatten
      json[:errors] = new_hash
      json
    end

  end
end