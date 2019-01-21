import java.util.Iterator;

/** 
   A driver that demonstrates the class BinaryTree.
   
   @author Frank M. Carrano
   @author Timothy M. Henry
   @version 4.2
*/
public class DriverBT 
{
	public static void main(String[] args)
	{
        // Represent each leaf as a one-node tree
		BinaryTreeInterface<String> dTree = new BinaryTree<>();
		dTree.setTree("D");
		BinaryTreeInterface<String> fTree = new BinaryTree<>();
		fTree.setTree("F");
		BinaryTreeInterface<String> gTree = new BinaryTree<>();
		gTree.setTree("G");
		BinaryTreeInterface<String> hTree = new BinaryTree<>();
		hTree.setTree("H");
		BinaryTreeInterface<String> emptyTree = new BinaryTree<>();
      
		// Form larger subtrees
		BinaryTreeInterface<String> eTree = new BinaryTree<>();
		eTree.setTree("E", fTree, gTree); // subtree rooted at E
      
		BinaryTreeInterface<String> bTree = new BinaryTree<>();
		bTree.setTree("B", dTree, eTree); // subtree rooted at B
      
		BinaryTreeInterface<String> cTree = new BinaryTree<>();
		cTree.setTree("C", emptyTree, hTree); // subtree rooted at C
      
		BinaryTreeInterface<String> aTree = new BinaryTree<>();
		aTree.setTree("A", bTree, cTree); // desired tree rooted at A
      
		// Display root, height, number of nodes
		System.out.println("Root of tree contains " + aTree.getRootData());
		System.out.println("Height of tree is " + aTree.getHeight());
		System.out.println("Tree has " + aTree.getNumberOfNodes() + " nodes");
      
		// Display nodes in preorder
		System.out.println("A preorder traversal visits nodes in this order:");
		Iterator<String> preorder = aTree.getPreorderIterator();
		while (preorder.hasNext())
         System.out.print(preorder.next() + " ");
		System.out.println();
      
		System.out.println("Should be \n" + "A B D E F G C H \n");
	   
	}  // end main
}

	
  