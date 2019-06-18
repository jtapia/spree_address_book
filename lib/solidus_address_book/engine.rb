# frozen_string_literal: true

module SolidusAddressBook
  class Engine < Rails::Engine
    isolate_namespace Spree
    engine_name 'solidus_address_book'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "solidus_address_book.environment", before: :load_config_initializers do |app|
      SolidusAddressBook::Config = SolidusAddressBook::Configuration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Spree::Ability.register_ability(Spree::AddressAbility)
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
