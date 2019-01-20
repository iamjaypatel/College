import java.io.*;

// HashItem: the hash element/data storage class
class HashItem
{
   // key, data and deletion flag declaration
   private String key;
   private String val;
   private boolean deleted;
   
   // constructor
   HashItem(String key, String val)
   {
      this.key = key;
      this.val = data;
      deleted = false;
   }
   
   // deletion set method
   public void setDeleted()
   {
      deleted = true;
   }
   
   // deleted check method
   public boolean isDeleted()
   {
      return deleted;
   }
   
   // key accessor
   public String getKey()
   {
      return key;
   }
   
   // data accessor
   public String getData()
   {
      return val;
   }
}

// LinearTable: a simple linear probing hash table implementation
class LinearTable
{
   // declare table size and element array
   public final int TABLESIZE = 7;
   private HashItem[] table = new HashItem[TABLESIZE];
   
   // calculate a hash code for a given string
   public int code(String key)
   {
      return (Math.abs(key.hashCode()) % TABLESIZE);
   }
   
   //add():  add a key-data pair to the table
   public boolean add(String key, String val)
   {
      // probe place variable
      int probe;
      
      // calculate hashcode from key
      int code = code(key);
      
      // if hash item is empty, add straight away
      if ((table[code] == null) || table[code].isDeleted())
      {
         table[code] = new HashItem(key, val);
         probe = -1;
      }
      // otherwise, probe through the list for a free spot
      else
      {
         // initialise probe to next spot
         if (code == (table.length - 1) )
            probe = 0;
         else
            probe = code + 1;
      }
      
      // keep probing while data hasn't been stored, and it
      // hasn't looped back to the original item
      while ((probe != -1) && (probe != code))
      {
         // if the probed element is null
         if ((table[probe] == null) || table[probe].isDeleted())
         {
            // add the data and mark as being stored
            table[probe] = new HashItem(key, val);
            probe = -1;
         }
         // otherwise probe to the next item
         else
         {
            if (probe == (table.length -1) )
               probe = 0;
            else
               probe++;
         }
      }

      // return operation success
      // if data was stored, return true, otherwise false
      if (probe != -1)
         return false;
      else
         return true;
   }
   
   // retrieve(): retrieve the data for a given key
   public String retrieve(String key)
   {
      // probe place variable
      int probe;
      
      // calculate hashcode from key
      int code = code(key);
      System.out.println("Code: " + code);
      
      // if its empty to start, return false
      if (table[code] == null)
      {
         System.out.println("Straight null");
         return null;
      }
      // if hash item is a match, return straight away
      else if (table[code].getKey().equals(key))
      {
         System.out.println("Straight find");
         return table[code].getData();
      }
      // otherwise, probe through the list for a free spot
      else
      {
         // initialise probe to next spot
         if (code == (table.length - 1) )
            probe = 0;
         else
            probe = code + 1;

         System.out.println("Probing at " + probe);
      }
      
      // keep probing while data hasn't been stored, and it
      // hasn't looped back to the original item
      while ((probe != -1) && (probe != code))
      {
         // if the probed element is COMPLETELY empty, return
         if (table[probe] == null)
            return null;
         // if the probed element is a match
         else if (table[probe].getKey().equals(key))
         {
            // return the data
            return table[probe].getData();
         }
         // otherwise probe to the next item
         else
         {
            if (probe == (table.length - 1) )
               probe = 0;
            else
               probe++;

            System.out.println("Probing at " + probe);
         }
      }

      // if nothing has been returned, data is not present.
      // return null
      System.out.println("Very end, null");
      return null;
   }
   
   // delete(): delete the data corresponding to a key
   public boolean delete(String key)
   {
      // probe place variable
      int probe;
      
      // calculate hashcode from key
      int code = code(key);
      System.out.println("Code: " + code);

      // if hash item is empty, fail straight away
      if (table[code] == null)
      {
         System.out.println("Straight null");
         return false;
      }
      // otherwise match for a key
      // if it's a straight match, delete straight away
      else if (table[code].getKey().equals(key))
      {
         System.out.println("Straight find");
         table[code].setDeleted();
         probe = -1;
         return true;
      }
      // otherwise, probe through the list for the next spot
      else
      {
         // initialise probe to next spot
         if (code == (table.length - 1) )
            probe = 0;
         else
            probe = code + 1;

         System.out.println("Probing at " + probe);
      }
      
      // keep probing while data hasn't been stored, and it
      // hasn't looped back to the original item
      while ((probe != -1) && (probe != code))
      {
         // if the probed element is COMPLETELY empty, return failure
         if (table[probe] == null)
            return false;
         // otherwise match for the key
         else if (table[probe].getKey().equals(key))
         {
            // flag as deleted
            table[code].setDeleted();
            probe = -1;
            return true;
         }
         // otherwise probe to the next item
         else
         {
            if (probe == (table.length -1) )
               probe = 0;
            else
               probe++;

            System.out.println("Probing at " + probe);
         }
      }

      // if nothing has been deleted, data is not present.
      // return failure
      return false;
   }
   
   public void dump()
   {
      for (int i = 0; i < table.length; i++)
      {
         if (table[i] == null)
            System.out.println(i + ": empty");
         else
         {
            if (table[i].isDeleted())
               System.out.println(i + ": deleted");
            else
               System.out.println(i + ": " + table[i].getKey() + " -- " + table[i].getData());
         }
      }
   }
}

class Hashtest
{
   public static void main(String[] args) throws IOException
   {
      LinearTable table = new LinearTable();
      
      BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in));
      
      boolean success, quit = false;
      String key, val;
      
      while (!quit)
      {
         System.out.println();
         System.out.println("1. Add");
         System.out.println("2. Retrieve");
         System.out.println("3. Delete");
         System.out.println("4. Dump");
         System.out.println("5. Quit");
         System.out.println();
         System.out.print("Option: ");
         
         int option = Integer.parseInt(stdin.readLine());
         
         switch (option)
         {
            // add option
            case 1:
            
               // get key and data
               System.out.print("Key: ");
               key = stdin.readLine();
               
               System.out.print("Value: ");
               val = stdin.readLine();
               
               // attempt to add to table
               success = table.add(key, val);
               
               // print response
               if (success)
                  System.out.println("Add OK");
               else
                  System.out.println("Could not add.");
               break;
            
            // retrieve option
            case 2:
               // get key
               System.out.print("Key: ");
               key = stdin.readLine();

               // attempt to retrieve
               String result = table.retrieve(key);
               
               // print response
               if (result == null)
                  System.out.println("Not found.");
               else
                  System.out.println("Data: " + result);
               break;
            
            // delete option
            case 3:
               // get key
               System.out.print("Key: ");
               key = stdin.readLine();

               // attempt to delete
               success = table.delete(key);
               
               // print response
               if (success)
                  System.out.println("Deleted OK.");
               else
                  System.out.println("Not found.");
               break;

            // dump option
            case 4:
               table.dump();
               break;
            
            // quit option
            case 5:
               quit = true;
               break;
         }
      }
   }
}