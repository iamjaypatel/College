import java.util.*;
import java.awt.*;

/**
 * A class that will be used to display a coded message
 * Make all methods synchronized
 * 
 * @author Charles Hoot
 * @version 4.0
 */
    
public class Code  
{
    
    private ArrayList<String> lines;
    private int currentLine;
    private Character currentCharacter;

    /**
     * Constructor for objects of class Code
     */
    public Code()
    {
      
        lines = new ArrayList<String>();
        currentLine = 0;
        lines.add(new String());
        currentCharacter = null;

    }
    
    
    public static final int CHARACTERS_PER_LINE = 30;
    /**
     * Add a new character to the code. 
     * 
     * @param  c   A character to add. 
     */ 
    public synchronized void addCharacter(Character c)
    {
        String line = lines.get(currentLine);
        if(line.length() >= CHARACTERS_PER_LINE)
        {
            currentLine++;
            line = new String();
            lines.add(line);
        }
        
        if(currentCharacter != null)
        {
            line = line + currentCharacter;
            lines.set(currentLine, line);
        }
        
        currentCharacter = c;
    }




    



    public static final int LINE_HEIGHT = 15;
    public static final int SHOW_LINES = 2;
    public static final int INDENT = 20;
    
    /**
     * drawOn - draw a representation of the Code at the given location
     * 
     * @param   g  The graphics context to draw on.   
     * @param   leftX  The x position of the left margin.
     * @param   topY  The y position of the top.
     * 
     */
    synchronized public void drawOn(Graphics g, int leftX, int topY)
    {
        String toDraw;
        int startLine;
        if(currentCharacter == null)
        {
            toDraw = "Code: no characters yet";
            g.setColor(Color.black);
            g.drawString(toDraw, leftX, topY+LINE_HEIGHT);
        }
        else
        {
            if(lines.size() < SHOW_LINES)
                startLine = 0;
            else
                startLine = currentLine-SHOW_LINES+1;
            toDraw = "Code: Line " + startLine + " to " + currentLine;
            
            // Draw a header line
            FontMetrics fm = g.getFontMetrics();
            g.setColor(Color.black);
            g.drawString(toDraw, leftX+INDENT, topY+LINE_HEIGHT);
            
            int yPos = topY+2*LINE_HEIGHT;
            // loop over the lines
            for(int i= startLine; i<=currentLine; i++)
            {
                toDraw = (String) lines.get(i);
                g.drawString(toDraw, leftX+INDENT, yPos);
                yPos += LINE_HEIGHT;
            }
            
            int offset = fm.stringWidth(toDraw);
            
            if(currentCharacter != null)
            {
                toDraw = "" + currentCharacter;
                // draw the current character in red at the end of the last line
                g.setColor(Color.red);
                g.drawString(toDraw, leftX+INDENT+offset, yPos-LINE_HEIGHT);
            }
        }
        
    }
    
    /** Return a printable string representation of the object.
     * @return A string.
     */
    public String toString()
    {
        String result = "The code lines are:\n";
        Iterator<String> iter = lines.iterator();
        while(iter.hasNext())
        {
            String line = iter.next();
            result = result + line;
            
            if(!iter.hasNext())
            {
                // on the last line, don't forget the last character
                if(currentCharacter != null)
                {
                    if (line.length() < CHARACTERS_PER_LINE) 
                        result = result + currentCharacter;
                    else
                        result = result + "\n" + currentCharacter;
                }
            }
            
            // end the line
            result = result + "\n";
 
        }
        return result;
    }
}
