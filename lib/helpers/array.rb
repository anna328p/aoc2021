# frozen_string_literal: true

# Patches to the Array class
class Array
  def median
    return nil if empty?

    sorted = sort
    len = length
    mid = len / 2

    if len.odd?
      sorted[mid]
    else
      (sorted[mid - 1] + sorted[mid]) / 2.0
    end
  end

  def swizzle(indices)
    indices.map { self[_1] }
  end
end
