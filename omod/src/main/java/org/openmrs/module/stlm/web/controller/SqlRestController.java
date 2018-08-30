package org.openmrs.module.stlm.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/rest/v1/stlm/sqltablecolumn")
public class SqlRestController {
	
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	protected List<String> getTableColumn() throws Exception {
		List<String> tableColumnList = new ArrayList<String>();
		Class.forName("com.mysql.jdbc.Driver");
		String connectionURL = "jdbc:mysql://localhost:3306/server";
		Connection con = DriverManager.getConnection(connectionURL, "root", "root");
		DatabaseMetaData md = con.getMetaData();
		ResultSet rsTable = md.getTables(null, null, "%", null);
		while (rsTable.next()) {
			String tableName = rsTable.getString(3);
			System.out.println(tableName);
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM " + tableName);
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			for (int i = 1; i < columnCount + 1; i++) {
				System.out.println(tableName + "-" + rsmd.getColumnName(i));
				tableColumnList.add(tableName + "-" + rsmd.getColumnName(i));
			}
		}
		return tableColumnList;
	}
}
