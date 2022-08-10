require "./lib/node.rb"

class BinarySearchTree
  def initialize(arr)
    @root = nil
    build_tree(arr)
  end

  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
  end

  def insert(data, current_node = @root)
    new_node(data)
  end

  def delete(data, current_node = @root)
    if current_node.right&.data == data
      if current_node.right&.right && current_node.right&.left
        replacement_node = current_node.right.left
        replacement_node_right_bottom_node = max_right_branch_node(replacement_node)
        replacement_node == replacement_node_right_bottom_node ? replacement_node.right = current_node.left.right : replacement_node_right_bottom_node.right = current_node.right.right
        current_node.right = replacement_node
      elsif current_node.right&.right
        current_node.right = current_node.right.right
      elsif current_node.right&.left
        current_node.right = current_node.right.left
      else
        current_node.right = nil
      end
    elsif current_node.left&.data == data
      if current_node.left&.right && current_node.left&.left
        replacement_node = current_node.left.left
        replacement_node_right_bottom_node = max_right_branch_node(replacement_node)
        replacement_node == replacement_node_right_bottom_node ? replacement_node.right = current_node.left.right : replacement_node_right_bottom_node.right = current_node.left.right
        current_node.left = replacement_node
      elsif current_node.left&.right
        current_node.left = current_node.left.right
      elsif current_node.left&.left
        current_node.left = current_node.left.left
      else
        current_node.left = nil
      end
    elsif current_node.data == nil
      nil
    else
      current_node.data > data ? delete(data, current_node.left) : delete(data, current_node.right)
    end
  end

  def find(value, current_node = @root)
    return current_node if current_node.data == value
    return nil if current_node.right == nil && current_node.left == nil
    current_node.data > value ? find(value, current_node.left) : find(value, current_node.right)
  end

  def level_order(nodes_array = [@root], return_array = [], &block)
    current_node = nodes_array.shift
    nodes_array.push(current_node.left) if current_node.left
    nodes_array.push(current_node.right) if current_node.right
    return_array.push(block_given? ? block.call(current_node) : current_node.data)
    nodes_array.empty? ? return_array : level_order(nodes_array, return_array, &block)
  end

  def inorder(current_node = @root, return_array = [], &block)
    inorder(current_node.left, return_array, &block) if current_node.left
    return_array.push(block_given? ? block.call(current_node) : current_node.data)
    inorder(current_node.right, return_array, &block) if current_node.right
    return_array
  end

  def preorder(current_node = @root, return_array = [], &block)
    return_array.push(block_given? ? block.call(current_node) : current_node.data)
    preorder(current_node.left, return_array, &block) if current_node.left
    preorder(current_node.right, return_array, &block) if current_node.right
    return_array
  end

  def postorder(current_node = @root, return_array = [], &block)
    postorder(current_node.left, return_array, &block) if current_node.left
    postorder(current_node.right, return_array, &block) if current_node.right
    return_array.push(block_given? ? block.call(current_node) : current_node.data)
  end

  def height(current_node = @root)
    branch_left_height = current_node.left ? 1 + height(current_node.left) : 0
    branch_right_height = current_node.right ? 1 + height(current_node.right) : 0
    branch_left_height > branch_right_height ? branch_left_height : branch_right_height
  end

  def depth(the_node, current_node = @root)
    return 0 if the_node == @root
    if current_node == the_node
      return 0
    elsif current_node.left && current_node.right
      left_depth = depth(the_node, current_node.left) ? depth(the_node, current_node.left) + 1 : false
      right_depth = depth(the_node, current_node.right) ? depth(the_node, current_node.right) + 1 : false
      left_depth ? left_depth : right_depth
    elsif current_node.left
      depth(the_node, current_node.left) ? depth(the_node, current_node.left) + 1 : false
    elsif current_node.right
      depth(the_node, current_node.right) ? depth(the_node, current_node.right) + 1 : false
    else
      false
    end
  end

  # BELOW IS "level_order" METHOD MADE ITERATIVELY
  #def level_orderr(&block)
  #nodes_array = [@root]
  #return_array = []
  #until nodes_array.empty?
  #current_node = nodes_array.shift
  #odes_array.push(current_node.left) if current_node.left
  #nodes_array.push(current_node.right) if current_node.right
  #return_array.push(block_given? ? block.call(current_node) : current_node.data)
  #end
  #return_array
  #end

  private

  def min_left_branch_node(node = @root)
    node = node.left while node.left
    node
  end

  def max_right_branch_node(node = @root)
    node = node.right while node.right
    node
  end

  def build_tree(arr)
    arr.each do |value|
      if @root
        new_node(value)
      else
        @root = Node.new(value) unless @root
      end
    end
  end

  def new_node(data, current_node = @root)
    if current_node.data > data
      current_node.left ? new_node(data, current_node.left) : current_node.left = Node.new(data)
    else
      current_node.right ? new_node(data, current_node.right) : current_node.right = Node.new(data)
    end
  end
end
