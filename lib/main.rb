require "./lib/binary_search_tree.rb"

arr = (Array.new(15) { rand(1..100) })

tree = BinarySearchTree.new(arr)
p tree.balanced?
tree.pretty_print
add_array = (Array.new(100) { rand(1..100) })
for value in add_array
  tree.insert(value)
end
p tree.balanced?
tree.pretty_print
tree.rebalance
p tree.balanced?
tree.pretty_print
p tree.preorder
p tree.inorder
p tree.postorder
