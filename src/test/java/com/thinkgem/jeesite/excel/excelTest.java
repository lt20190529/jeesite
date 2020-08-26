package com.thinkgem.jeesite.excel;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.Test;

import java.io.FileOutputStream;
import java.io.IOException;

public class excelTest {

    @Test
    public void test() throws IOException {
        XSSFWorkbook wb = new XSSFWorkbook();

        CreationHelper factory = wb.getCreationHelper();

        XSSFSheet sheet = wb.createSheet();
        Drawing drawing = sheet.createDrawingPatriarch();
        ClientAnchor anchor = factory.createClientAnchor();

        Cell cell0 = sheet.createRow(0).createCell(0);
        cell0.setCellValue("Cell0");

        Comment comment0 = drawing.createCellComment(anchor);
        RichTextString str0 = factory.createRichTextString("Hello, World!");
        comment0.setString(str0);
        comment0.setAuthor("Apache POI");
        anchor = factory.createClientAnchor();
        anchor.setCol1(2);
        anchor.setCol2(3);
        anchor.setRow1(1);
        anchor.setRow2(2);
        cell0.setCellComment(comment0);

        Cell cell1 = sheet.createRow(3).createCell(5);
        cell1.setCellValue("F4");
        Comment comment1 = drawing.createCellComment(anchor);
        RichTextString str1 = factory.createRichTextString("Hello, World!");
        comment1.setString(str1);
        comment1.setAuthor("Apache POI");
        anchor = factory.createClientAnchor();
        anchor.setCol1(2);
        anchor.setCol2(3);
        anchor.setRow1(1);
        anchor.setRow2(2);
        cell1.setCellComment(comment1);

        Cell cell2 = sheet.createRow(2).createCell(2);
        cell2.setCellValue("C3");

        Comment comment2 = drawing.createCellComment(anchor);
        RichTextString str2 = factory.createRichTextString("XSSF can set cell comments");
        //apply custom font to the text in the comment
        Font font = wb.createFont();
        font.setFontName("Arial");
        font.setFontHeightInPoints((short)14);
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);
        font.setColor(IndexedColors.RED.getIndex());
        str2.applyFont(font);

        comment2.setString(str2);
        comment2.setAuthor("Apache POI");
        comment2.setColumn(2);
        comment2.setRow(2);

        String fname = "comments.xlsx";
        FileOutputStream out = new FileOutputStream(fname);
        wb.write(out);
        out.close();

    }

}
