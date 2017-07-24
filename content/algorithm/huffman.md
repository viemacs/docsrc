---
weight: 20
title: Algorithm
draft: false
---

## Huffman Encoding

```python
class Node(object):
    def __init__(self, symbol = '', weight = 0, left = None, right = None):
        self.symbol, self.weight, self.left, self.right = symbol, weight, left, right
        if (left and right):
            self.weight = left.weight + right.weight

    def result(self, code = ''):
        r = []
        self.symbol and r.append((self.symbol, self.weight, code))
        self.left and r.extend(self.left.result(code + '0'))
        self.right and r.extend(self.right.result(code + '1'))
        return r


def genHuffman(char, freq):
    nodeList = []
    for i in range(len(char)):
        nodeList.append(Node(char[i], freq[i]))

    while (len(nodeList) >= 2):
        nodeList.sort(key = lambda x: x.weight, reverse = True)
        nodeList.append(Node(left = nodeList.pop(), right = nodeList.pop()))

    return nodeList[0] if nodeList else Node()


def getFrequency(freq):
    total = sum(freq)
    return list(map(lambda x:x/total, freq))

# test
symbol = ['A', 'B', 'C', 'D', 'E']
counts = [15, 7, 6, 6, 5]
print(genHuffman(symbol, counts).result())

# output
# space	7	111
# a	4	010
# e	4	000
# f	3	1101
# h	2	1010
# i	2	1000
# m	2	0111
# n	2	0010
# s	2	1011
# t	2	0110
# l	1	11001
# o	1	00110
# p	1	10011
# r	1	11000
# u	1	00111
# x	1	10010

symbol = ['space','a','e','f','h','i','m','n','s','t','l','o','p','r','u','x']
counts = [7, 4, 4, 3, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1]
for e in sorted(genHuffman(symbol, counts).result(), key = lambda x:x[1], reverse = True):
    print (e[0], e[1], e[2])
```

Huffman encoding goes from leaves to root, unlike Shanno-Fano encoding which goes from root to leaves.

A simple alg using a priority queue.

1. Create a leaf-node for each symbol, with the info of the symbol's frequency.
2. Loop while there are more than 1 node in the queue
    - Replace the 2 nodes of lowest probability, with 1 node that takes the 2 nodes as children and its weight is the sum of the 2 nodes' weight.
3. The last one node is the root of the completed tree.

