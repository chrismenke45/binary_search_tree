require "./lib/binary_search_tree.rb"

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = BinarySearchTree.new(arr)
tree.pretty_print
tree.insert(53)
tree.insert(54)
tree.insert(55)
tree.insert(50)
tree.insert(51)
tree.insert(49)
tree.pretty_print
p tree.height(tree.find(53))
p tree.depth(tree.find(53))
p tree.height(tree.find(55))
p tree.depth(tree.find(55))
p tree.height(tree.find(5))
p tree.depth(tree.find(5))
p tree.height(tree.find(7))
p tree.depth(tree.find(7))
