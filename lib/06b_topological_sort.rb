require_relative '06a_graph'

# O(|V| + |E|).
def topological_sort(vertices)
  in_edge_counts = {}
  queue = []

  vertices.each do |v|
    in_edge_counts[v] = v.in_edges.count
    queue << v if v.in_edges.empty?
  end

  sorted_vertices = []

  until queue.empty?
    vertex = queue.shift
    sorted_vertices << vertex

    vertex.out_edges.each do |e|
      to_vertex = e.to_vertex

      in_edge_counts[to_vertex] -= 1
      queue << to_vertex if in_edge_counts[to_vertex] == 0
    end
  end

  sorted_vertices
end

# TESTING

vertices = []
vertices << (v1 = Vertex.new("Wash Markov"))
vertices << (v2 = Vertex.new("Feed Markov"))
vertices << (v3 = Vertex.new("Dry Markov"))
vertices << (v4 = Vertex.new("Brush Markov"))
Edge.new(v1, v2)
Edge.new(v1, v3)
Edge.new(v2, v4)
Edge.new(v3, v4)

solutions = [
  [v1, v2, v3, v4],
  [v1, v3, v2, v4]
]
20.times do
  fail unless solutions.include?(topological_sort(vertices.shuffle))
end
