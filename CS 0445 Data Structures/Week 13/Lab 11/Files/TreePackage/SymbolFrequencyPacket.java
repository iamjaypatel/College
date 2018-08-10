package TreePackage;



import java.util.*;
import java.awt.Graphics;
import java.awt.FontMetrics;
import java.awt.Color;

  /**
 * Used to store a list of symbols and their combined frequency for use
 * in a Huffman code tree.
 * 
 * @author Charles Hoot
 * @version 4.0
 * @param T The type of symbol to be stored on the nodes.
 */

public class SymbolFrequencyPacket<T>
{
    List<T> symbolList;
    long totalFrequency;
    boolean isHighLighted;

    /**
     * Constructor for objects of class SymbolFreqencyPacket.
     * @param symbols A list of symbols to store in the node.
     * @param frequency The combined frequency for the symbols on the list.
     */
    public SymbolFrequencyPacket(List<T> symbols, long frequency)
    {
        symbolList = symbols;
        totalFrequency = frequency;
        isHighLighted = false;
    }

    /**
     * Get the combined frequency of all the symbols.
     * 
     * @return     The total frequency. 
     */
    synchronized public long getFrequency()
    {
        return totalFrequency;
    }
    
    
    /**
     * Get the List of all the symbols.
     * 
     * @return     The list of symbols. 
     */
    synchronized public List<T> getSymbols()
    {
        return symbolList;
    }
    
    
    /**
     * Determine if a symbol is in the list.
      *
      * @param  symbol   The symbol to look for.
      * @return     True if the symbol is in the list.
      */
    synchronized public boolean inList(T symbol)
    {
        return symbolList.contains(symbol);
    }


    /**
     * Set the highlighting.
     * 
     * @param highlight If true, highlight the node. 
     */
    synchronized public void setHighLighting(boolean highlight)
    {
        isHighLighted = highlight;
    }
    
    
    public static final int TEXTHEIGHT = 15;
    
    
     /**
     * Draw a representation of the symbol frequency packet centered at
     * the given location.
     * 
     * @param   g  The graphics context to draw on.   
     * @param   centerX  The x position of text to draw.
     * @param   centerY  The y position of text to draw.
     * 
     */
    synchronized public void drawOn(Graphics g, int centerX, int centerY)
    {
        String toDraw = new String("");;
        
        
        FontMetrics fm = g.getFontMetrics();

        if (symbolList.size() == 1)
        {
            // only one symbol draw it
            toDraw = symbolList.get(0).toString();
        }
        else
        {
            // draw the frequency
            toDraw = (new Long(totalFrequency)).toString();
        }
        
        int width = fm.stringWidth(toDraw);
        
        int startX = centerX - width/2;
        int startY = centerY - TEXTHEIGHT/2;

        // Blank the back ground
        g.setColor(Color.white);
        g.fillRect(startX, startY, width, TEXTHEIGHT);
        
        if(isHighLighted)
             g.setColor(Color.red);
        else
             g.setColor(Color.black);
        
        int baseLineY = centerY + TEXTHEIGHT/2;
        // draw the string
        g.drawString(toDraw, startX, baseLineY);
        
    } // end drawOn
 
}
