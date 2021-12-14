package csv.write.opencsvsample;

import com.opencsv.CSVReader;
import com.opencsv.CSVWriter;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ReadOpenCsv {

    public static void main(String[] args) throws IOException {


        FileReader fileReader = null;
        CSVReader csvReader = null;
        try {
            fileReader = new FileReader("testfile.csv");
            csvReader = new CSVReader(fileReader);
            String[] record = null;
            while ((record = csvReader.readNext()) != null) {
                System.out.println(record[0] + "," + record[1]);
            }
        } finally {
            if (fileReader != null) {
                fileReader.close();
            }
            if (csvReader != null) {
                csvReader.close();
            }
        }
    }


}
