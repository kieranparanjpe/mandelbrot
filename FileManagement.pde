import java.io.File;  // Import the File class
import java.io.IOException;  // Import the IOException class to handle errors
import java.io.FileWriter;   // Import the FileWriter class
import java.io.FileNotFoundException;// Import this class to handle errors
import java.util.Scanner; // Import the Scanner class to read text files

public String ReadFile(String name) {
  try {
    File myObj = new File(name);
    Scanner myReader = new Scanner(myObj);
    String r = "";
    while (myReader.hasNextLine()) {
      String data = myReader.nextLine();
      r+=data;
      //System.out.println(data);
    }
    System.out.println("Absolute path: " + myObj.getAbsolutePath());
    myReader.close();
    return r;

  } catch (FileNotFoundException e) {
    System.out.println("An error occurred.");
    e.printStackTrace();
  }
  
  return "";
}
 
public void CreateFile(String name) {
  try {
    File myObj = new File(name);
    if (myObj.createNewFile()) {
      System.out.println("File created: " + myObj.getName());
      System.out.println("Absolute path: " + myObj.getAbsolutePath());  
    } else {
      System.out.println("File already exists.");
    }
  } catch (IOException e) {
    System.out.println("An error occurred.");
    e.printStackTrace();
  }
}

public void WriteToFile(String name, String content) {
  try {
    FileWriter myWriter = new FileWriter(name);
    myWriter.write(content);
    myWriter.close();
    System.out.println("Successfully wrote to the file.");
  } catch (IOException e) {
    System.out.println("An error occurred.");
    e.printStackTrace();
  }
}

public ArrayList<coord> BubbleSort(ArrayList<coord> arr){
    int records= arr.size()-1;
    boolean notSorted= true;   // first pass
    while (notSorted) {
        notSorted= false;    //set flag to false awaiting a possible swap
        for(int count=0;  count < records;  count++ ) {
            if (arr.get(count).x < arr.get(count+1).x) {  // change to > for ascending sort
                coord temp = arr.get(count);
                arr.set(count, arr.get(count+1));
                arr.set(count+1, temp);
                notSorted= true;     //Need to further check        
            }
        }
    }
    return arr;
} 
