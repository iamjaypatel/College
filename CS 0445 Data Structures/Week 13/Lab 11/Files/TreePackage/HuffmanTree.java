package TreePackage;

/** 
 * An implementation of a binary tree that will be used for constructing
 * a Huffman code.
 *
 * This code is based on BinaryTree from Chapter 24 of
 * Data Structures and Abstractions with Java 4/e
 *      by Carrano
 *      
 * @author Charles Hoot 
 * @version 4.0
 */

import java.util.*;
import java.awt.Graphics;
import java.awt.Color;
    
public class HuffmanTree<T> implements BinaryTreeInterface<SymbolFrequencyPacket<T>>, HuffmanTreeInterface<T>,
java.io.Serializable
{
    private HuffmanNode<T> root;
    public HuffmanTree()
    {
        root = null;
        resetCurrentNode();
    } // end default constructor

    public HuffmanTree(SymbolFrequencyPacket<T> rootData)
    {
        root = new HuffmanNode<T>(rootData);
        resetCurrentNode();
    } // end constructor

    public HuffmanTree(SymbolFrequencyPacket<T> rootData, HuffmanTree<T> leftTree,
                   HuffmanTree<T> rightTree)
    {
        privateSetTree(rootData, leftTree, rightTree);
        resetCurrentNode();
    } // end constructor

    synchronized 
    public void setTree(SymbolFrequencyPacket<T> rootData)
    {
        root = new HuffmanNode<T>(rootData);
    } // end setTree
    
    
    synchronized 
    public void setTree(SymbolFrequencyPacket<T> rootData, 
                    BinaryTreeInterface<SymbolFrequencyPacket<T>> leftTree,
                    BinaryTreeInterface<SymbolFrequencyPacket<T>> rightTree)
    {
        privateSetTree(rootData, (HuffmanTree<T>)leftTree, (HuffmanTree<T>)rightTree);
    } // end setTree


    

    synchronized
    private void privateSetTree(SymbolFrequencyPacket<T> rootData,
                             HuffmanTree<T> leftTree, HuffmanTree<T> rightTree)
    {
        root = new HuffmanNode<T>(rootData);

        if ((leftTree != null) && !leftTree.isEmpty())
            root.setLeftChild(leftTree.root);

        if ((rightTree != null) && !rightTree.isEmpty())
        {
            if (rightTree != leftTree)
                root.setRightChild(rightTree.root);
            else
                root.setRightChild(rightTree.root.copy());
        } // end if

        if ((leftTree != null) && (this != leftTree))
            leftTree.clear();

        if ((rightTree != null) && (this != rightTree))
                rightTree.clear();
    } // end privateSetTree


    synchronized
    public SymbolFrequencyPacket<T> getRootData()
    {
        SymbolFrequencyPacket<T> rootData = null;
        if (root != null)
            rootData = root.getData();
        return rootData;
    } // end getRootData

    synchronized
    public boolean isEmpty()
    {
        return root == null;
    } // end isEmpty

    synchronized
    public void clear()
    {
        root = null;
    } // end clear

    synchronized
    protected void setRootData(SymbolFrequencyPacket<T> rootData)
    {
        root.setData(rootData);
    } // end setRootData

    synchronized
    protected void setRootNode(HuffmanNode<T> rootNode)
    {
        root = rootNode;
    } // end setRootNode

    synchronized
    protected HuffmanNode<T> getRootNode()
    {
        return root;
    } // end getRootNode

    synchronized
    public int getHeight()
    {
        // Modified from Carrano to return 0 if the tree is empty
        if(root== null)
            return 0;
        else
            return root.getHeight();    
    } // end getHeight

    synchronized
    public int getNumberOfNodes()
    {
        // Modified from Carrano to return 0 if the tree is empty
        if(root== null)
            return 0;
        else
            return root.getNumberOfNodes();
    } // end getNumberOfNodes

    synchronized
    public void inorderTraverse()
    {
        inorderTraverse(root);
    } // end inorderTraverse

    synchronized
    private void inorderTraverse(HuffmanNode<T> node)
    {
        if (node != null)
        {
            inorderTraverse(node.getLeftChild());
            System.out.println(node.getData());
            inorderTraverse(node.getRightChild());
        } // end if
    } // end inorderTraverse
    
    
    private class InorderIterator implements Iterator<SymbolFrequencyPacket<T>>
    {
        private Stack<HuffmanNode<T>> nodeStack;
        private HuffmanNode<T> currentNode;

        public InorderIterator()
        {
            nodeStack = new Stack<HuffmanNode<T>>();
            currentNode = root;
        } // end default constructor

        synchronized
        public boolean hasNext()
        {
            return !nodeStack.isEmpty() || (currentNode != null);
        } // end hasNext

        synchronized
        public SymbolFrequencyPacket<T> next()
        {
            HuffmanNode<T> nextNode = null;

            // Find leftmost node with no left child
            while (currentNode != null)
            {
                nodeStack.push(currentNode);
                currentNode = (HuffmanNode<T>)currentNode.getLeftChild();
            } // end while

            // Get leftmost node, then move to its right subtree
            if (!nodeStack.isEmpty())
            {
                nextNode = nodeStack.pop();
                assert nextNode != null; // Since nodeStack was not empty
                                        // before the pop
                currentNode = (HuffmanNode<T>) nextNode.getRightChild();
            }
            else
                throw new NoSuchElementException();

            return nextNode.getData();
        } // end next

        synchronized
        public void remove()
        {
            throw new UnsupportedOperationException();
        } // end remove

    } // end InorderIterator
    
    /* Create an inorder iterator.
    * @return The iterator.
    */
    synchronized
    public Iterator<SymbolFrequencyPacket<T>> getInorderIterator()
    {
        return new InorderIterator();
    }
    
    // Only the one iterator will be implemented by this code
    synchronized
    public Iterator<SymbolFrequencyPacket<T>> getPreorderIterator()
    {
        throw new RuntimeException("Post order iterators not yet supported by this class");   
    }
    
    
    synchronized
    public Iterator<SymbolFrequencyPacket<T>> getPostorderIterator()
    {
        throw new RuntimeException("Post order iterators not yet supported by this class");
    }
    
    
    synchronized
    public Iterator<SymbolFrequencyPacket<T>> getLevelOrderIterator()
    {
        throw new RuntimeException("Post order iterators not yet supported by this class");    
    }
    
    
    
    // All the methods that make it work for coding. 
    private HuffmanNode<T> current;

    /** 
     * Get the symbol/frequency for the current node in the Huffman tree.
     * @return The object of type SymbolFrequencyPacket being held at the current node.
    * */  
    synchronized
    public SymbolFrequencyPacket<T> getCurrentData()
    {
        SymbolFrequencyPacket<T> result = null;
        
        if(current != null)
        {
            result = current.getData();
        }
        return result;
    }
    
    /** 
     * Determine whether current node contains a single code letter.
    * @return True if the current node is a leaf. 
    * */
    synchronized
    public boolean isSingleSymbol()
    {
        return (current.getLeftChild() == null
                &&  current.getRightChild() == null);
    }
    
    /**
     * Moves the current node to the left child of
    * the current node. 
    * */
    synchronized
    public void advanceLeft()
    {
        current = (HuffmanNode<T>) current.getLeftChild();
        current.getData().setHighLighting(true);
    }

    /**
     * Moves the current node to the right child of
    * the current node. 
    * */
    synchronized
    public void advanceRight()
    {
        current = (HuffmanNode<T>) current.getRightChild();
        current.getData().setHighLighting(true);
    }

    /** 
     * Check the node to the left of the current node to see if a symbol is there.
     * @param symbol The symbol to look for. 
     * @return True if the symbol is on the left.
     * */
    synchronized
    public boolean checkLeft(T symbol)
    {
        boolean result = false;
        HuffmanNode<T> toCheck = (HuffmanNode<T>) current.getLeftChild();
        if(toCheck != null)
        {
            result = toCheck.getData().inList(symbol);
        }
        return result;
    }
    
    /** 
     * Check the node to the right of the current node to see if a symbol is there.
     * @param symbol The symbol to look for. 
     * @return True if the symbol is on the right.
     * */    
    synchronized
    public boolean checkRight(T symbol)
    {
        boolean result = false;
        HuffmanNode<T> toCheck = (HuffmanNode<T>) current.getRightChild();
        if(toCheck != null)
        {
            result = toCheck.getData().inList(symbol);
        }
        return result;
    }
    
    /** 
     * Sets the current node to the root of the tree.
     * */
    synchronized
    public void resetCurrentNode()
    {
        current = root;
        clearHighLights();
        current.getData().setHighLighting(true);
    }


    /** 
     * Clear the highLights of the tree.
     * */
    synchronized
    public void clearHighLights()
    {
        Iterator iter = new InorderIterator();
        while(iter.hasNext())
        {
            SymbolFrequencyPacket n = (SymbolFrequencyPacket) iter.next();
            n.setHighLighting(false);
        }
    }
    
    /**
     * Draw a representation of the Huffman tree at
     * the given location.
     * 
     * @param   g  The graphics context to draw on.   
     * @param   leftX  The x left boundary to use.
     * @param   rightX  The x right boundary to use.
     * @param   topCenterY   The y position of center of top node.
     * 
     */
    synchronized public void drawOn(Graphics g, int leftX, int rightX, int topCenterY)
    {       
        drawOnAux(g, getRootNode(), leftX, rightX, topCenterY);  
    } // end drawOn
 
 
    static public final int LEVELHEIGHT = 30;
    /**
     * Recursively draw the nodes and structure of the tree.
     * 
     * @param   g  The graphics context to draw on.
     * @param   top The top of the current tree in the recursion.
     * @param   leftX  The x left boundary to use.
     * @param   rightX  The x right boundary to use.
     * @param   topCenterY  The y position of center of top node.
     * 
     */    
    synchronized 
    private void drawOnAux(Graphics g, HuffmanNode top, int leftX, int rightX, int topCenterY)
    {
        // post order traversal
        int centerX = (leftX + rightX)/2;
        
        if(top != null)
        {
            // Do the left
            if(top.hasLeftChild())
            {
                // draw the spine
                g.setColor(Color.black);
                int centerNextX = (leftX + centerX)/2;
                g.drawLine(centerX, topCenterY, centerNextX, topCenterY+LEVELHEIGHT);
                
                // do recursion
                drawOnAux(g, (HuffmanNode)top.getLeftChild(), leftX, centerX, topCenterY+LEVELHEIGHT);              
            }
            // Do the right
            if(top.hasRightChild())
            {
                // draw the spine
                g.setColor(Color.black);
                int centerNextX = (rightX + centerX)/2;
                g.drawLine(centerX, topCenterY, centerNextX, topCenterY+LEVELHEIGHT);
                
                // do recursion
                drawOnAux(g, (HuffmanNode)top.getRightChild(), centerX, rightX, topCenterY+LEVELHEIGHT);
             }
            // Do the node
            ((SymbolFrequencyPacket)(top.getData())).drawOn(g, centerX, topCenterY);
        }
        
    } // end drawOnAux
}

	