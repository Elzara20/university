class Node:

    def __init__(self, data):

        self.left = None
        self.right = None
        self.data = data

    def add_node(self, data):
        if self.data:
            if data < self.data:
                if self.left is None:
                    self.left = Node(data)
                else:
                    self.left.add_node(data)
            elif data > self.data:
                if self.right is None:
                    self.right = Node(data)
                else:
                    self.right.add_node(data)
        else:
            self.data = data


    def print_tree(self):
        print( self.data)
        if self.left:
            print("left")
            self.left.print_tree()
        if self.right:
            print("right")
            self.right.print_tree()


    def find_node(self, x, res):    
        #res: 1-left, 0-right
        if x < self.data:
            res.append(1)
            if self.left is None:
                # not fount
                return 0            
            return self.left.find_node(x, res)

        elif x > self.data:
            res.append(0)
            if self.right is None:
                #not found
                return 0            
            return self.right.find_node(x, res)

        else:
            #found
            print(res) #check
            return 1
        

    def in_order(self, node, x,res):
      
        if node:
            # if (node.data!=x):
            #     # print(node.data, end="->")
            #     self.in_order(node.left,x)            
            #     self.in_order(node.right,x)
            # else:
            res.append(1)
            self.in_order(node.left,x,res)

            print(node.data, end="->")

            res.append(0)          
            self.in_order(node.right,x,res)
            print(res)


    def pre_order(self, node, x,res):
      
        if node:
            print(node.data, end="->")

            res.append(1)
            self.in_order(node.left,x,res)

            res.append(0)          
            self.in_order(node.right,x,res)

            print(res)
    def post_order(self, node, x,res):
      
        if node:
            res.append(1)
            self.in_order(node.left,x,res)

            res.append(0)          
            self.in_order(node.right,x,res)

            print(node.data, end="->")

            print(res)


root = Node(50)

root.add_node(10)

root.add_node(8)
root.add_node(12)
root.add_node(11)

root.add_node(15)


root.add_node(80)

root.add_node(55)
root.add_node(54)
root.add_node(60)
root.add_node(52)
root.add_node(61)
root.add_node(51)
root.add_node(63)
# print(root.find(7))
# print(root.find(14))
root.print_tree()
r=[]
root.in_order(root,63,[])
print("+++++++++++++++")
root.find_node(15,[])

# if (root.find(15)==1):
#     root1=Node(15)
#     root1.PrintTree()
