import java.io.FileWriter;

public class Main {

    // http://99-bottles-of-beer.net/lyrics.html
    public static void main(String[] args) {

























        String str2 = "Take one down and pass it around, ";

        for (int i = 99; i > -1; i--) {
            if (i == 0) {
                System.out.println("No more bottles of beer on the wall, no more bottles of beer.");
                System.out.println("Go to the store and buy some more, 99 bottles of beer on the wall.");
            } else if (i == 1) {
                System.out.println(String.format("%d bottles of beer on the wall, %d bottles of beer.", i, i));
                System.out.print(str2);
                System.out.println("no more bottles of beer on the wall.");
            } else {
                System.out.println(String.format("%d bottles of beer on the wall, %d bottles of beer.",i,i));
                System.out.println(i + " bottles of beer on the wall," + i + "bottles of beer.");
                System.out.print(str2);
                System.out.println((i - 1) + " bottles of beer on the wall.");
            }
            System.out.println();
        }
    }
}
