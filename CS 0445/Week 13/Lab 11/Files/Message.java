import java.util.*;
import java.awt.*;

/**
 * A class that will be used to display the message that will be encoded.
 * Make all methods synchronized
 * 
 * @author Charles Hoot
 * @version 4.0
 */
    
public class Message implements Iterator<Character>
{
    
    private ArrayList<String> lines;
    private int currentLine;
    private int lastCharacterProduced;

    /**
     * Constructor for objects of class Message
     */
    public Message()
    {
      
        lines = new ArrayList<String>();
        currentLine = 0;
        lastCharacterProduced = -1;

    }
    
    /**
     * Add a new string to the Lines.  (don't add empty strings).
     * 
     * @param  s   a string 
     */ 
    public synchronized void addLine(String s)
    {
        if(s.length() > 0)
            lines.add(s);
        
    }

    private synchronized boolean hasAnotherLine()
    {
        return currentLine < lines.size() - 1 ;
    }


    private synchronized boolean hasAnotherCharacterInLine()
    {
            return (lastCharacterProduced < lines.get(currentLine).length() - 1 );
    }
    
    /**
     * Is there another character that can be retrieved.  Satisfies the iterator interface.
     * @return true if there is another character
     */
    public synchronized boolean hasNext()
    {
        return hasAnotherLine() || hasAnotherCharacterInLine();
    }
    
    /**
     * this method is needed for the iterator interface, but it is not implemented by this class
     * 
     */
    public synchronized void remove()
    {
        throw new RuntimeException("Remove not supported");
    }

    /**
     * Reset the message buffer iteration back to the beginning.
     */
    public synchronized void reset()
    {
        currentLine = 0;
        lastCharacterProduced = -1;
    }

    
    /**
     * get the next character
     * if the end of a line has been reached, increment the current line and set the current
     * character to the first character in the next line.Satisfies the iterator interface.
     *  @return the next character
     */
    public synchronized Character next()
    {
    
        Character result = null;
        
        if(hasAnotherCharacterInLine())
        {
            lastCharacterProduced++;            
            result = new Character((lines.get(currentLine)).charAt(lastCharacterProduced));
        } 
        else if(hasAnotherLine())
        {
            // Check to see if we can go to the next line
            currentLine++;
            lastCharacterProduced = 0;
            
            result = new Character((lines.get(currentLine)).charAt(lastCharacterProduced));
        }
       
        return result;

    }    
    
    
    
    public static final int LINE_HEIGHT = 15;
    public static final int INDENT = 20;

    /**
     * drawOn - draw a representation of the Message at the given location
     * 
     * @param   g  the graphics context to draw on   
     * @param   leftX  x position of the left margin
     * @param   topY  y position of the top
     * 
     */

    synchronized public void drawOn(Graphics g, int leftX, int topY)
    {
        String toDraw;
        if(lines.size() == 0)
        {
            toDraw = "Message: no lines yet";
            g.setColor(Color.black);
            g.drawString(toDraw, leftX, topY+LINE_HEIGHT);
        }
        else
        {
            if(hasAnotherLine())
                toDraw = "Message: Lines " + currentLine + " to " + (currentLine+1);
            else
                toDraw = "Message: Line " + currentLine + " (last line)";
            
            // Draw a header line
            FontMetrics fm = g.getFontMetrics();
            g.setColor(Color.black);
            g.drawString(toDraw, leftX, topY+LINE_HEIGHT);
            
            String line = (String) lines.get(currentLine);
            
            // start all the pieces as empty
            String leftSubstring = new String("");
            String middleSubstring = new String("");
            String rightSubstring = new String("");

            // Draw the current line -- last produced character in red
            if(lastCharacterProduced > 0)
            {
                // Have a left substring
                leftSubstring = line.substring(0,lastCharacterProduced);
            }
            
            if(lastCharacterProduced < line.length() - 1)
            {
                // Have a right substring
                rightSubstring = line.substring(lastCharacterProduced+1, line.length());
            }
            
            if(lastCharacterProduced > -1 && lastCharacterProduced < line.length())
            {
                 // Have a middle substring
                middleSubstring = line.substring(lastCharacterProduced,lastCharacterProduced+1);
            }
            
            
            int xPos = leftX+INDENT;
            
            g.drawString(leftSubstring, xPos, topY+2*LINE_HEIGHT);
            xPos += fm.stringWidth(leftSubstring);
    
            g.setColor(Color.red);
            g.drawString(middleSubstring, xPos, topY+2*LINE_HEIGHT);
            xPos += fm.stringWidth(middleSubstring);
    
            g.setColor(Color.black);
            g.drawString(rightSubstring, xPos, topY+2*LINE_HEIGHT);
           
            if(hasAnotherLine())
            {
                line = (String) lines.get(currentLine+1);
                g.drawString(line, leftX+INDENT, topY+3*LINE_HEIGHT);
            }
        }
    }
    
    public String toString()
    {
        String result = "The message lines are:\n";
        Iterator iter = lines.iterator();
        while(iter.hasNext())
        {
            result = result + ((String) iter.next()) + "\n";
        }
        return result;
    }
}
