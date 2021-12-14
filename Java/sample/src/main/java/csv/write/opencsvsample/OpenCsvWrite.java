package csv.write.opencsvsample;

import com.opencsv.CSVWriter;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class OpenCsvWrite {
    public static void main(String[] args) throws IOException {


        FileWriter fileWriter = null;
        CSVWriter csvWriter = null;
        try {
            fileWriter = new FileWriter("testfile.csv");
            csvWriter = new CSVWriter(fileWriter);

            // ヘッダー
            List<String> header = new ArrayList<String>();
            header.add("MEMBER_NO");
            header.add("MEMBER_NAME");
            csvWriter.writeNext(header.toArray(new String[header.size()]));

            // レコードの作成
            List<String> record = new ArrayList<String>();
            record.add("00001");
            record.add("鈴木一郎");
            csvWriter.writeNext(record.toArray(new String[record.size()]));
            record = new ArrayList<String>();
            record.add("00002");
            record.add("佐藤二郎");
            csvWriter.writeNext(record.toArray(new String[record.size()]));
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (csvWriter != null) {
                csvWriter.close();
            }
        }
    }
}

