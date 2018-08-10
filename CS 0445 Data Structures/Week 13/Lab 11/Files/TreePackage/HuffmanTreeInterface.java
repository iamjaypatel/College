package TreePackage;


/**
 * Operations are provided to interact with a Huffman encoding tree.  
 * This is similar to the DecisionTreeInterface 
 * from Chapter 23 of
 * Data Structures and Abstractions with Java 4/e
 *      by Carrano
 * 
 * @author Charles Hoot 
 * @version 4.0
 */
    
public interface HuffmanTreeInterface<T> extends BinaryTreeInterface<SymbolFrequencyPacket<T>>
{
    /** 
     * Gets the symbol/frequency for the current node in the Huffman tree.
     * @return The object of type SymbolFrequencyPacket being held at the current node, or
     *         null if the current node is null.
     */  
    public SymbolFrequencyPacket<T> getCurrentData();
    
    /** 
     * Determine whether current node contains a single code letter.
     * @return True if the current node is a leaf. 
     */
    public boolean isSingleSymbol();
    
    /**
     * Moves the current node to the left child of
     * the current node. 
     */
    public void advanceLeft();

    /**
     * Moves the current node to the right child of
     * the current node. 
     */
    public void advanceRight();

    /** 
     * Check the node to the left of the current node to see if a symbol is there.
     * @param symbol The symbol to look for. 
     * @return True if the symbol is on the left.
     */
     public boolean checkLeft(T symbol);

    /** 
     * Check the node to the right of the current node to see if a symbol is there.
     * @param symbol The symbol to look for.
     * @return True if the symbol is on the right.
     */    
     public boolean checkRight(T symbol);
    
    /** 
     * Makes the root of the tree the current node.
     */
    public void resetCurrentNode();
} // end HuffmanTreeInterface