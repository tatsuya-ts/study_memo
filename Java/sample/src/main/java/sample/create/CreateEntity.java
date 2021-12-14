package sample.create;

/**
 * Entityクラスの自動生成
 */
public class CreateEntity {

//    String columsStr = {"a", "b"};

    String entityName = "EntitySample";

    //    追加機能
    //　主キー
    //
//
    private final String anotation = "@Column";
    private final String[] columns = {"a", "b"};


    public static void main(String[] args) {

        CreateEntity createEntity = new CreateEntity();

        for (String column : createEntity.columns) {

            String getterStr = "";


        }
    }

    // create文の自動生成
    public void outputEntity(String[] columns) {



    }


}
