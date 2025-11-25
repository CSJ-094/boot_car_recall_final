package com.boot.service;

import com.boot.dto.DefectReportDTO;
import com.boot.dto.RecallDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.ByteArrayOutputStream;
import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
public class PdfExportService {

    private static final float PAGE_MARGIN = 50f;
    private static final float TITLE_FONT_SIZE = 18f;
    private static final float SUBTITLE_FONT_SIZE = 12f;
    private static final float BODY_FONT_SIZE = 11f;
    private static final float SECTION_SPACING = 8f;
    private static final int DEFAULT_LINE_CHAR_LIMIT = 80;
    private static final DateTimeFormatter HEADER_DATE_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    private static final SimpleDateFormat REPORT_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    private final ResourceLoader resourceLoader;

    @Value("${app.pdf.font-path:}")
    private String configuredFontPath;

    /**
     * 리콜 데이터를 기반으로 PDF 파일을 생성합니다.
     */
    public byte[] generateRecallPdf(List<RecallDTO> recallList) throws IOException {
        List<RecallDTO> data = recallList == null ? Collections.emptyList() : recallList;
        try (PDDocument document = new PDDocument();
             PdfPageState pageState = new PdfPageState(document);
             ByteArrayOutputStream baos = new ByteArrayOutputStream()) {

            PDFont font = resolveFont(document);

            writeTitle(pageState, font, "자동차 리콜 내역 보고서", data.size());

            if (data.isEmpty()) {
                writeParagraph(pageState, font, "PDF로 내보낼 리콜 데이터가 없습니다.", BODY_FONT_SIZE);
            } else {
                int index = 1;
                for (RecallDTO recall : data) {
                    writeParagraph(pageState, font, index + ". 제조사: " + safeText(recall.getMaker()), BODY_FONT_SIZE);
                    writeParagraph(pageState, font, "   모델명: " + safeText(recall.getModelName()), BODY_FONT_SIZE);
                    writeParagraph(pageState, font, "   생산 기간: " + buildDateRange(recall.getMakeStart(), recall.getMakeEnd()), BODY_FONT_SIZE);
                    writeParagraph(pageState, font, "   리콜 일자: " + safeText(recall.getRecallDate()), BODY_FONT_SIZE);
                    writeParagraph(pageState, font, buildFieldLines("   리콜 사유: ", recall.getRecallReason()), BODY_FONT_SIZE);
                    addSectionSpacing(pageState);
                    index++;
                }
            }

            pageState.finish();
            document.save(baos);
            return baos.toByteArray();
        }
    }

    /**
     * 결함 신고 데이터를 기반으로 PDF 파일을 생성합니다.
     */
    public byte[] generateDefectReportPdf(List<DefectReportDTO> reportList) throws IOException {
        List<DefectReportDTO> data = reportList == null ? Collections.emptyList() : reportList;
        try (PDDocument document = new PDDocument();
             PdfPageState pageState = new PdfPageState(document);
             ByteArrayOutputStream baos = new ByteArrayOutputStream()) {

            PDFont font = resolveFont(document);

            writeTitle(pageState, font, "결함 신고 내역 보고서", data.size());

            if (data.isEmpty()) {
                writeParagraph(pageState, font, "PDF로 내보낼 신고 내역이 없습니다.", BODY_FONT_SIZE);
            } else {
                int index = 1;
                for (DefectReportDTO report : data) {
                    writeParagraph(pageState, font, index + ". 신고번호: " + safeText(report.getId()), BODY_FONT_SIZE);
                    writeParagraph(pageState, font, "   신고인: " + safeText(report.getReporterName()), BODY_FONT_SIZE);
                    writeParagraph(pageState, font, "   연락처: " + safeText(report.getContact()), BODY_FONT_SIZE);
                    writeParagraph(pageState, font, "   차량 모델: " + safeText(report.getCarModel()), BODY_FONT_SIZE);
                    writeParagraph(pageState, font, "   차대번호: " + safeText(report.getVin()), BODY_FONT_SIZE);
                    writeParagraph(pageState, font, buildFieldLines("   결함 내용: ", report.getDefectDetails()), BODY_FONT_SIZE);
                    writeParagraph(pageState, font, "   신고일시: " + formatReportDate(report), BODY_FONT_SIZE);
                    addSectionSpacing(pageState);
                    index++;
                }
            }

            pageState.finish();
            document.save(baos);
            return baos.toByteArray();
        }
    }

    private void writeTitle(PdfPageState pageState, PDFont font, String title, int totalCount) throws IOException {
        String generatedAt = HEADER_DATE_FORMAT.format(LocalDateTime.now());
        writeParagraph(pageState, font, title, TITLE_FONT_SIZE);
        writeParagraph(pageState, font, "총 " + totalCount + "건 · 생성일시 " + generatedAt, SUBTITLE_FONT_SIZE);
        addSectionSpacing(pageState);
    }

    private void writeParagraph(PdfPageState pageState, PDFont font, String text, float fontSize) throws IOException {
        writeParagraph(pageState, font, Collections.singletonList(text), fontSize);
    }

    private void writeParagraph(PdfPageState pageState, PDFont font, List<String> lines, float fontSize) throws IOException {
        List<String> safeLines = lines == null ? Collections.singletonList("") : lines;
        for (String line : safeLines) {
            writeLine(pageState, font, fontSize, line);
        }
    }

    private void writeLine(PdfPageState pageState, PDFont font, float fontSize, String text) throws IOException {
        float lineHeight = fontSize + 4f;
        pageState.ensureSpace(lineHeight);
        PDPageContentStream contentStream = pageState.getContentStream();
        contentStream.beginText();
        contentStream.setFont(font, fontSize);
        contentStream.newLineAtOffset(PAGE_MARGIN, pageState.getCursorY());
        if (StringUtils.hasLength(text)) {
            contentStream.showText(sanitizeForPdf(text));
        }
        contentStream.endText();
        pageState.moveCursor(lineHeight);
    }

    /**
     * 폰트가 지원하지 않는 제어문자(특히 탭)를 안전한 문자로 치환합니다.
     */
    private String sanitizeForPdf(String text) {
        if (text == null) {
            return "";
        }
        // 탭을 스페이스 4개로 대체
        String replaced = text.replace("\t", "    ");
        // CR은 이미 제거되어 있음; 혹시 남아있는 다른 제어문자는 제거
        StringBuilder sb = new StringBuilder(replaced.length());
        for (int i = 0; i < replaced.length(); i++) {
            char c = replaced.charAt(i);
            if (c >= 0x20 || c == '\n') {
                sb.append(c);
            } else {
                // 제어문자는 공백으로 대체
                sb.append(' ');
            }
        }
        return sb.toString();
    }

    private void addSectionSpacing(PdfPageState pageState) throws IOException {
        pageState.ensureSpace(SECTION_SPACING);
        pageState.moveCursor(SECTION_SPACING);
    }

    private String buildDateRange(String start, String end) {
        String safeStart = StringUtils.hasText(start) ? start : "-";
        String safeEnd = StringUtils.hasText(end) ? end : "-";
        return safeStart + " ~ " + safeEnd;
    }

    private List<String> buildFieldLines(String label, String value) {
        String safeValue = safeText(value);
        int maxValueLength = Math.max(10, DEFAULT_LINE_CHAR_LIMIT - label.length());
        List<String> splitted = splitByLength(safeValue, maxValueLength);
        List<String> result = new ArrayList<>();

        if (splitted.isEmpty()) {
            result.add(label + "-");
            return result;
        }

        result.add(label + splitted.get(0));
        String padding = repeatSpace(label.length());
        for (int i = 1; i < splitted.size(); i++) {
            result.add(padding + splitted.get(i));
        }
        return result;
    }

    private List<String> splitByLength(String value, int maxLength) {
        if (maxLength <= 0) {
            maxLength = DEFAULT_LINE_CHAR_LIMIT;
        }
        if (!StringUtils.hasText(value)) {
            return Collections.singletonList("-");
        }

        String normalized = value.replace("\r", "");
        String[] paragraphs = normalized.split("\n");
        List<String> result = new ArrayList<>();
        for (String paragraph : paragraphs) {
            if (paragraph.isEmpty()) {
                result.add("");
                continue;
            }
            int start = 0;
            while (start < paragraph.length()) {
                int end = Math.min(start + maxLength, paragraph.length());
                result.add(paragraph.substring(start, end));
                start = end;
            }
        }
        return result;
    }

    private String repeatSpace(int count) {
        if (count <= 0) {
            return "";
        }
        StringBuilder builder = new StringBuilder(count);
        for (int i = 0; i < count; i++) {
            builder.append(' ');
        }
        return builder.toString();
    }

    private String safeText(Object value) {
        if (value == null) {
            return "-";
        }
        String text = String.valueOf(value);
        return text.trim().isEmpty() ? "-" : text.trim();
    }

    private String formatReportDate(DefectReportDTO report) {
        return report != null && report.getReportDate() != null
                ? REPORT_DATE_FORMAT.format(report.getReportDate())
                : "-";
    }

    private PDFont resolveFont(PDDocument document) throws IOException {
        List<String> candidates = new ArrayList<>();
        if (StringUtils.hasText(configuredFontPath)) {
            candidates.add(configuredFontPath);
        }
        candidates.add("classpath:fonts/NanumGothic.ttf");
        candidates.add("C:/Windows/Fonts/malgun.ttf");
        candidates.add("/usr/share/fonts/truetype/nanum/NanumGothic.ttf");

        for (String candidate : candidates) {
            PDFont font = tryLoadFont(document, candidate);
            if (font != null) {
                log.debug("Loaded PDF font from {}", candidate);
                return font;
            }
        }

        log.warn("한글을 지원하는 폰트를 찾지 못해 기본 서체(Helvetica)로 대체합니다. " +
                "필요 시 app.pdf.font-path 속성으로 폰트를 지정해 주세요.");
        return PDType1Font.HELVETICA;
    }

    private PDFont tryLoadFont(PDDocument document, String location) {
        if (!StringUtils.hasText(location)) {
            return null;
        }
        try {
            if (location.startsWith("classpath:")) {
                Resource resource = resourceLoader.getResource(location);
                if (resource.exists()) {
                    try (InputStream is = resource.getInputStream()) {
                        return PDType0Font.load(document, is);
                    }
                }
            } else {
                Path path = Paths.get(location);
                if (Files.exists(path)) {
                    try (InputStream is = Files.newInputStream(path)) {
                        return PDType0Font.load(document, is);
                    }
                }
            }
        } catch (Exception e) {
            log.debug("Failed to load font from {}", location, e);
        }
        return null;
    }

    /**
     * 페이지 상태를 관리하는 헬퍼 클래스입니다.
     */
    private static class PdfPageState implements Closeable {
        private final PDDocument document;
        private PDPage page;
        private PDPageContentStream contentStream;
        private float cursorY;

        PdfPageState(PDDocument document) {
            this.document = Objects.requireNonNull(document, "document");
        }

        void ensureSpace(float requiredHeight) throws IOException {
            if (page == null) {
                startNewPage();
                return;
            }
            if (cursorY - requiredHeight < PAGE_MARGIN) {
                startNewPage();
            }
        }

        PDPageContentStream getContentStream() {
            return contentStream;
        }

        float getCursorY() {
            return cursorY;
        }

        void moveCursor(float height) {
            cursorY -= height;
        }

        void finish() throws IOException {
            closeContentStream();
        }

        private void startNewPage() throws IOException {
            closeContentStream();
            page = new PDPage(PDRectangle.A4);
            document.addPage(page);
            contentStream = new PDPageContentStream(document, page);
            cursorY = page.getMediaBox().getHeight() - PAGE_MARGIN;
        }

        private void closeContentStream() throws IOException {
            if (contentStream != null) {
                contentStream.close();
                contentStream = null;
            }
        }

        @Override
        public void close() throws IOException {
            closeContentStream();
        }
    }
}

