package bean;

import java.io.Serializable;

public class Subject implements Serializable {

    private static final long serialVersionUID = 1L;

    // フィールド（テーブル定義書 SUBJECT より）
    private String schoolCd;   // SCHOOL_CD（学校コード）
    private String cd;         // CD（科目コード）
    private String name;       // NAME（科目名）

    // --- getter / setter ---

    public String getSchoolCd() {
        return schoolCd;
    }

    public void setSchoolCd(String schoolCd) {
        this.schoolCd = schoolCd;
    }

    public String getCd() {
        return cd;
    }

    public void setCd(String cd) {
        this.cd = cd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
