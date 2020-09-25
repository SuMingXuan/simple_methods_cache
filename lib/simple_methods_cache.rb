require "simple_methods_cache/version"

module SimpleMethodsCache
  extend ActiveSupport::Concern

  def self.included(base)
    base.instance_eval do
      # TODO 苏铭轩20200925（将expires_in替换成options 使用Rails.cache自带的参数）
      def cache_methods(*method_names, expires_in: 1.day)
        method_cache_options ||= @@method_cache_options ||= {}
        method_names.each do |name|
          method_cache_options[name] = expires_in
        end
        class_variable_set('@@method_cache_options', method_cache_options)

        prepend InstanceMethods
      end
    end
  end

  module InstanceMethods
    def self.prepended(mod)
      mod.class_variable_get('@@method_cache_options').each_pair do |method_name, expires_in|
        define_method(method_name) do |*options|
          cache_key = "#{mod.class_name}/#{id}/#{method_name}"
          Rails.cache.fetch(cache_key, expires_in: expires_in) do
            super(*options)
          end
        end
      end
    end
  end
end
