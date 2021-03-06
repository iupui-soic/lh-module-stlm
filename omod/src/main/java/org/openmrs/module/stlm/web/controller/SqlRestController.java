package org.openmrs.module.stlm.web.controller;

import org.openmrs.api.context.Context;
import org.openmrs.util.OpenmrsUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.*;
import java.util.*;

@Controller
public class SqlRestController {
	
	@RequestMapping(value = "/rest/v1/stlm/sqltablecolumn", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, List<String>> getTableColumn() throws Exception {
        Map<String, List<String>> tableCol = new HashMap<>();
        Class.forName("com.mysql.jdbc.Driver");
        Properties props = OpenmrsUtil.getRuntimeProperties("openmrs");
        String curl = props.getProperty("connection.url");
        String user = Context.getUserContext().getAuthenticatedUser().getUsername();
        if (user.equals("") || null != user) {
            user = Context.getUserContext().getAuthenticatedUser().getSystemId();
        }
        String mysqlUrl = curl.substring(0, curl.lastIndexOf('/')) + "/" + user + "_db";
        System.out.print(mysqlUrl);
        Connection con = DriverManager.getConnection(mysqlUrl,
                props.getProperty("connection.username"), props.getProperty("connection.password"));
        DatabaseMetaData md = con.getMetaData();
        ResultSet rsTable = md.getTables(null, null, "%", null);
        while (rsTable.next()) {
            List<String> tableColumnList = new ArrayList<>();
            String tableName = rsTable.getString(3);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM " + tableName + " LIMIT 1");
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            for (int i = 1; i < columnCount + 1; i++) {
                tableColumnList.add(rsmd.getColumnName(i));
            }
            tableCol.put(tableName, tableColumnList);
        }
        rsTable.close();
        con.close();
        return tableCol;
    }
	
	@RequestMapping(value = "/rest/v1/stlm/sqlexecute", method = RequestMethod.POST)
    @ResponseBody
    public List<List<String>> SqlQuery(@RequestParam("queryText") String queryText) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Properties props = OpenmrsUtil.getRuntimeProperties("openmrs");
        String curl = props.getProperty("connection.url");
        String user = Context.getUserContext().getAuthenticatedUser().getUsername();
        if (user.equals("") || null != user) {
            user = Context.getUserContext().getAuthenticatedUser().getSystemId();
        }
        String mysqlUrl = curl.substring(0, curl.lastIndexOf('/')) + "/" + user + "_db";
        System.out.print(mysqlUrl);
        Connection con = DriverManager.getConnection(mysqlUrl,
                props.getProperty("connection.username"), props.getProperty("connection.password"));
        Statement stmt = con.createStatement();
        List<List<String>> results = new ArrayList<>();
        List<String> columnNames = new ArrayList<>();

        try {
        boolean status = stmt.execute(queryText);

            if (status) {
                ResultSet rs = stmt.getResultSet();
                ResultSetMetaData rsmd = rs.getMetaData();

                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    String column_name = rsmd.getColumnName(i);
                    columnNames.add(column_name);
                }
                results.add(columnNames);
                while (rs.next()) {
                    int numColumns = rsmd.getColumnCount();
                    List<String> row = new ArrayList<>();
                    for (int i = 1; i <= numColumns; i++) {
                        String column_name = rsmd.getColumnName(i);
                        row.add(rs.getObject(column_name).toString());
                    }
                    results.add(row);
                }
                rs.close();
            } else {
                int count = stmt.getUpdateCount();
                String outputResult = "The no of column effected is " + count;
                List<String> list = new ArrayList<>();
                list.add(outputResult);
                results.add(list);
            }
        } catch (SQLException e) {
            List<String> list = new ArrayList<>();
            list.add(e.getMessage());
            results.add(list);
            return(results);
        } finally {
            con.close();
        }


        return results;
    }
}
