require_relative "modal_family"
require_relative "scale"

module Musicology
  class GenerateModalFamilies
    def self.call
      new.call
    end

    def call
      modal_families
    end

    private

    def modal_families
      grouped_scales.values.map { |scales| ModalFamily.new(scales) }
    end

    def grouped_scales
      valid_scales.reduce({}) do |hash, scale|
        grouping_scale = hash.keys.detect { |s| s.rotation_of?(scale) }

        if grouping_scale
          hash.merge(grouping_scale => hash[grouping_scale] + [scale])
        else
          hash.merge(scale => [scale])
        end
      end
    end

    def valid_scales
      scales.select(&:valid?)
    end

    def scales
      (0..Scale::MAXIMUM).map { |bits| Scale.new(bits) }
    end
  end
end
