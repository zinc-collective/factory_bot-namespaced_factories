require 'factory_bot'
require "factory_bot/namespaced_factories/version"

module FactoryBot
  module NamespacedFactories
    class Error < StandardError; end
    # See:
    #  - https://github.com/thoughtbot/factory_bot/issues/199
    #  - https://github.com/thoughtbot/factory_bot/commit/652818bd1701db67ea03cd062c8259cd7fb37807
    #
    # There are two main use-cases for Namespaced Factories:
    #   1. Sharing Factories from an Engine or Gem
    #   2. Decomposing an application using domain driven design
    class NamespacedFactory
      def initialize(namespace, options)
        @namespace = namespace
        @options = options
        @prefix = options.fetch(:prefix, "#{namespace.to_s.underscore}_")
        @require_prefix = options.fetch(:require_prefix, true)
      end

      def factory(name, options = {}, &block)
        __dsl__.factory("#{prefix}#{name}".to_sym, options.merge(class: "#{namespace}::#{name.to_s.classify}"), &block)
        register_without_namespace(name, options, &block)
      end

      private

      attr_reader :namespace, :require_prefix, :prefix

      alias require_prefix? require_prefix

      def register_without_namespace?(name)
        !require_prefix? && !Internal.factories.registered?(name)
      end

      def register_without_namespace(name, options = {}, &block)
        return unless register_without_namespace?(name)

        __dsl__.factory(name.to_sym, options.merge(class: "#{namespace}::#{name.to_s.classify}"), &block)
      rescue FactoryBot::DuplicateDefinitionError => _e
        # Not sure why the Internal.factories.registered? isn't preventing this...
      end

      def __dsl__
        @__dsl__ ||= FactoryBot::Syntax::Default::DSL.new
      end
    end
  end

  module Syntax
    module Default
      class DSL
        def with_namespace(namespace, options = {}, &block)
          FactoryBot::NamespacedFactories::NamespacedFactory.new(namespace, options).instance_exec(&block)
        end
      end
    end
  end
end
