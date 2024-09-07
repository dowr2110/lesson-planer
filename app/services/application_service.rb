# frozen_string_literal: true

# Abstract service object

module ApplicationService
  ##
  # Service object class methods
  module ClassMethods
    def call(*args, **kwargs)
      new(*args, **kwargs).call
    end
  end

  def self.prepended(base)
    base.include Dry::Monads[:result]
    base.extend ClassMethods
  end

  def call
    raise Errors::NotImplementedError unless defined?(super)

    super
  end
end
