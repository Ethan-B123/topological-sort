# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'

class Array
  def has_vert?(val)
    any? { |vert| vert.value == val }
  end
  def find_vert(val)
    find { |vert| vert.value == val }
  end
  def values
    map { |vert| vert.value }
  end
end

def install_order(arr)
  verts = []
  edges = []
  arr.each do |md|
    if !verts.has_vert?(md[0])
      verts << Vertex.new(md[0])
    end
    if !verts.has_vert?(md[1])
      verts << Vertex.new(md[1])
    end
    edges << Edge.new(verts.find_vert(md[1]), verts.find_vert(md[0]))
  end
  values = verts.values
  max = values.max
  at_the_end = (1..max).to_a.select { |id| !values.include?(id) }
  topological_sort(verts).values + at_the_end
end
