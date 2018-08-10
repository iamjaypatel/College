package TreePackage;

/** An implementation of the ADT Binary Node with synchronization
 * and the ability to invoke a draw on its data.
*
* This code is based on BinaryNode from Chapter 24 of
* Data Structures and Abstractions with Java 4/e
*      by Carrano
*/
import java.util.*;
import java.awt.Graphics;

    
class HuffmanNode<T> 
{
	private SymbolFrequencyPacket<T> data;
	private HuffmanNode<T> leftChild;
	private HuffmanNode<T> rightChild;

	public HuffmanNode()
	{
		this(null); // call next constructor
	} // end default constructor
	
	public HuffmanNode(SymbolFrequencyPacket<T> dataPortion)
	{
		this(dataPortion, null, null); // call next constructor
	} // end constructor

	public HuffmanNode(SymbolFrequencyPacket<T> dataPortion, HuffmanNode<T> newLeftChild,
				   HuffmanNode<T> newRightChild)
	{
		data = dataPortion;
		leftChild = newLeftChild;
		rightChild = newRightChild;
	} // end constructor

	synchronized
	public SymbolFrequencyPacket<T> getData()
	{
		return data;
	} // end getData

	synchronized
	public void setData(SymbolFrequencyPacket<T> newData)
	{
		data = newData;
	} // end setData

	synchronized
	public HuffmanNode<T> getLeftChild()
	{
		return leftChild;
	} // end getLeftChild

	synchronized
	public void setLeftChild(HuffmanNode<T> newLeftChild)
	{
		leftChild = newLeftChild;
	} // end setLeftChild

	synchronized
	public boolean hasLeftChild()
	{
		return leftChild != null;
	} // end hasLeftChild

	synchronized
	public HuffmanNode<T> getRightChild()
	{
		return rightChild;
	} // end getRightChild

	synchronized
	public void setRightChild(HuffmanNode<T> newRightChild)
	{
		rightChild = newRightChild;
	} // end setRightChild

	synchronized
	public boolean hasRightChild()
	{
		return rightChild != null;
	} // end hasRightChild

	synchronized
	public boolean isLeaf()
	{
		return (leftChild == null) && (rightChild == null);
	} // end isLeaf

	synchronized
	public int getHeight()
	{
		return getHeight(this); // call private getHeight
	} // end getHeight

	synchronized
	private int getHeight(HuffmanNode<T> node)
	{
		int height = 0;
		if (node != null)
			height = 1 + Math.max(getHeight(node.getLeftChild()),
				              getHeight(node.getRightChild()));
		return height;
	} // end getHeight

	synchronized
	public int getNumberOfNodes()
	{
		int leftNumber = 0;
		int rightNumber = 0;

		if (leftChild != null)
			leftNumber = leftChild.getNumberOfNodes();

		if (rightChild != null)
			rightNumber = rightChild.getNumberOfNodes();

		return 1 + leftNumber + rightNumber;
	} // end getNumberOfNodes


    synchronized
    public HuffmanNode<T> copy()
    {
        HuffmanNode<T> newRoot = new HuffmanNode<T>(data);
        if (leftChild != null)
            newRoot.leftChild = (HuffmanNode<T>)leftChild.copy();
        if (rightChild != null)
            newRoot.rightChild = (HuffmanNode<T>)rightChild.copy();
        return newRoot;
    } // end copy


     /**
     * draw a representation of the node centered at
     * the given location  (pass it onto the data)
     * 
     * @param   g  the graphics context to draw on   
     * @param   centerX  x position of text to draw
     * @param   centerY  y position of text to draw
     * 
     */
 
    synchronized
    public void drawOn(Graphics g, int centerX, int centerY)
    {
        data.drawOn(g, centerX, centerY);        
    } // end drawOn

} // end HuffmanNode
