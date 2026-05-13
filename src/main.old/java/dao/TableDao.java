package dao;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class TableDao extends Dao {

    // テーブル一覧取得
    public List<String> getTables() throws Exception {
        List<String> list = new ArrayList<>();

        try (Connection conn = getConnection()) {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rs = meta.getTables(null, null, "%", new String[]{"TABLE"});

            while (rs.next()) {
                list.add(rs.getString("TABLE_NAME"));
            }
        }
        return list;
    }

    // テーブル中身（先頭数件だけ）
    public List<Map<String, Object>> getData(String table) throws Exception {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT * FROM " + table;

        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            ResultSetMetaData meta = rs.getMetaData();
            int cols = meta.getColumnCount();

            int count = 0;
            while (rs.next() && count < 10) { // ←10件だけ
                Map<String, Object> row = new LinkedHashMap<>();

                for (int i = 1; i <= cols; i++) {
                    row.put(meta.getColumnName(i), rs.getObject(i));
                }

                list.add(row);
                count++;
            }
        }
        return list;
    }
}