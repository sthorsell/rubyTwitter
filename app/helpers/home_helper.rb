module HomeHelper

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def consumer(args)
      args.each do |arg|
        method_name = ("get_consumer_from_" + arg[0].to_s).to_sym
        # raise method_name.to_yaml
        send :define_method, method_name do
          provider = arg[0].to_s.upcase
          consumer = OAuth::Consumer.new(ENV["#{provider}_CONSUMER_KEY"], ENV["#{provider}_CONSUMER_SECRET"],
          { :site => arg[1].to_s,
            :scheme => :header
            })

            return consumer
          end
        end
      end
    end
  end
