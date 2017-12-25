require_relative "modal_family"
require_relative "scale"
require_relative "popular_scales"

module Musicology
  class ModalFamilyCollection
    def all
      build_from(valid_scales)
    end

    def popular
      build_from(popular_scales)
    end

    private

    def build_from(given_scales)
      cluster_related_scales(given_scales).map do |scales|
        ModalFamily.new(scales)
      end
    end

    def cluster_related_scales(scales)
      group_scales_by_rotation(scales).values
    end

    def group_scales_by_rotation(scales)
      scales.reduce({}) do |hash, scale|
        grouping_scale = hash.keys.detect { |s| s.rotation_of?(scale) }

        if grouping_scale
          hash.merge(grouping_scale => hash[grouping_scale] + [scale])
        else
          hash.merge(scale => [scale])
        end
      end
    end

    def popular_scales
      valid_scales.select { |scale| POPULAR_SCALES.include?(scale.word) }
    end

    def valid_scales
      all_scales.select(&:valid?)
    end

    def all_scales
      (0..Scale::MAXIMUM).map { |bits| Scale.new(bits) }
    end
  end
end
