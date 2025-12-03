package model;

public class Unite {
    String id;
    String val;
    String desce;

    public Unite(){}
    public Unite(String id, String val, String desce) throws Exception{
        try {
            setId(id);
            setVal(val);
            setDesce(desce);
        } catch (Exception e) {
            throw e;
        }
    }
    public String getDesce() {
        return desce;
    }
    public String getId() {
        return id;
    }
    public String getVal() {
        return val;
    }
    public void setDesce(String desce) {
        this.desce = desce;
    }
    public void setId(String id) throws Exception{
        if (id == null) {
            throw new Exception("ID Unite NULL");
        } else{
            this.id = id;
        }
    }
    public void setVal(String val) {
        this.val = val;
    }

}
