require_relative 'graph'

def topological_sort(vertices)
  vertices_2 = vertices.dup
  sorted = []
  no_ins = []
  loop_count = 0
  vertices_2.each do |vert|
    if vert.in_edges.length == 0
      no_ins << vert
    end
  end
  while no_ins.length > 0
    working = no_ins.shift
    sorted << working
    no_ins.concat(
      working.out_edges.map { |oe| oe.to_vertex }
      .select { |vert| vert.in_edges.length == 1 })
    working.out_edges.each { |oe| oe.destroy! }
    return [] if sorted.length > vertices.length
  end
  sorted.length == vertices.length ? sorted : []
end
