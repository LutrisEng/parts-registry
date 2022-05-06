# frozen_string_literal: true

class PartRelation < ApplicationRecord
  PARTIAL_RELATION_TYPES = {
    contains: :part_of,
    manufactured_using: :manufactures
  }.freeze
  FULL_RELATION_TYPES = PARTIAL_RELATION_TYPES
                        .flat_map { |types| [[types[0], types[1]], [types[1], types[0]]] }
                        .to_h
                        .freeze

  belongs_to :part_a, class_name: 'Part'
  belongs_to :part_b, class_name: 'Part'

  def relation_type_t
    "relation_type.#{relation_type}".to_sym if relation_type
  end

  def inverse_relation_type
    FULL_RELATION_TYPES[relation_type] if relation_type
  end

  def inverse_relation_type_t
    "relation_type.#{inverse_relation_type}" if inverse_relation_type
  end
end
