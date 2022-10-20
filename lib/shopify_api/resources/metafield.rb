module ShopifyAPI
  class Metafield < Base
    include DisablePrefixCheck

    conditional_prefix :resource, true

    # The retreived metafield may include the legacy `value_type` field, which
    # we must remove when reserializing otherwise it will be sent back to the 
    # server and will trigger a deprecation warning
    #
    # source: https://stackoverflow.com/a/12826825/258794
    def to_json(options = {})
      self.attributes.to_json({ :except => :value_type }.merge(options))
    end

    def value
      return if attributes["value"].nil?
      attributes["type"] == "integer" ? attributes["value"].to_i : attributes["value"]
    end
  end
end
