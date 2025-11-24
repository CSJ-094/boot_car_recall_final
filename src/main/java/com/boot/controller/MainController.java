package com.boot.controller;

import com.boot.dto.Criteria;
import com.boot.dto.NoticeDTO;
import com.boot.dto.BoardDTO;
import com.boot.dto.DefectReportDTO;
import com.boot.dto.PageDTO;
import com.boot.dto.RecallDTO;
import com.boot.dto.SearchResultsDTO;
import com.boot.service.DefectReportService;
import com.boot.service.NoticeService;
import com.boot.service.BoardService;
import com.boot.service.RecallService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class MainController {

    private final ResourceLoader resourceLoader;
    private final RecallService recallService;
    private final DefectReportService defectReportService;
    private final NoticeService noticeService;
    private final BoardService boardService;

    // -------------------------------------------------------------------
    // 1. 메인 페이지 (리콜 검색 기능 포함)
    // -------------------------------------------------------------------
    @GetMapping("/")
    public String main(Model model, @RequestParam(value = "query", required = false) String query) {
        // 최근 공지사항 5개 조회
        Criteria noticeCri = new Criteria(1, 5);
        List<NoticeDTO> noticeList = noticeService.listWithPaging(noticeCri);
        model.addAttribute("noticeList", noticeList);

        // 최근 보도자료 5개 조회
        Criteria pressCri = new Criteria(1, 5);
        List<BoardDTO> pressList = boardService.listWithPaging(pressCri);
        model.addAttribute("pressList", pressList);


        if (query != null && !query.trim().isEmpty()) {
            List<RecallDTO> searchResults = recallService.searchRecallsByModelName(query.trim());
            model.addAttribute("searchQuery", query);
            model.addAttribute("searchResults", new SearchResultsDTO(query, searchResults));
        }
        return "main";
    }

    // -------------------------------------------------------------------
    // 2. 리콜 현황 페이지 (페이징 기능 포함)
    // URL: /recall-status
    // -------------------------------------------------------------------
    @GetMapping("/recall-status")
    public String recallStatus(Criteria cri, Model model) {
        List<RecallDTO> recallList = recallService.getAllRecalls(cri);
        model.addAttribute("recallList", recallList);

        int total = recallService.getRecallCount(cri);

        PageDTO pageDTO = new PageDTO(cri, total);
        model.addAttribute("pageMaker", pageDTO);

        if (total == 0) {
            model.addAttribute("errorMessage", "데이터베이스에 리콜 데이터가 없습니다. 먼저 데이터를 로드해주세요.");
        }
        return "recall_status";
    }

    // -------------------------------------------------------------------
    // 3. 데이터 로드 및 초기화 기능
    // -------------------------------------------------------------------
    @GetMapping("/load-data")
    public String loadData(Model model) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            Resource resource = resourceLoader.getResource("classpath:integrated_recall_data.json");
            InputStream inputStream = resource.getInputStream();
            List<RecallDTO> recallList = objectMapper.readValue(inputStream, new TypeReference<List<RecallDTO>>() {});

            recallService.saveRecallData(recallList);

            // 데이터 로드 후 전체 카운트 재확인
            int count = recallService.getRecallCount(new Criteria());
            model.addAttribute("message", "성공적으로 " + count + "개의 리콜 데이터를 데이터베이스에 저장했습니다.");

        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("message", "데이터 로드 및 저장 중 오류가 발생했습니다: " + e.getMessage());
        }
        return "load_result";
    }

    // -------------------------------------------------------------------
    // 4. 결함 신고 접수 (폼)
    // URL: /report/write
    // -------------------------------------------------------------------
    @GetMapping("/report/write")
    public String defectReportForm() {
        return "defect_report";
    }

    // -------------------------------------------------------------------
    // 5. 결함 신고 접수 처리
    // URL: /defect-report (POST)
    // -------------------------------------------------------------------
    @PostMapping("/defect-report")
    public String defectReportSubmit(DefectReportDTO report, @RequestParam(value = "defectImages", required = false) List<MultipartFile> files, RedirectAttributes rttr) {
        try {
            defectReportService.saveReport(report, files);
            rttr.addFlashAttribute("message", "결함 신고가 성공적으로 접수되었습니다. 신고 내역에서 확인해 주세요.");
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("errorMessage", "오류가 발생하여 신고가 접수되지 않았습니다: " + e.getMessage());
        }
        // 리다이렉션 경로 수정: /defect_report_list -> /report/history
        return "redirect:/report/history";
    }

    // -------------------------------------------------------------------
    // 6. 결함 신고 목록 조회 (페이징 기능 포함)
    // URL: /report/history
    // -------------------------------------------------------------------
    @GetMapping("/report/history")
    public String defectReportList(Criteria cri, Model model) {
        List<DefectReportDTO> reportList = defectReportService.getAllReports(cri);
        model.addAttribute("reportList", reportList);

        int total = defectReportService.getTotalCount(cri);
        PageDTO pageDTO = new PageDTO(cri, total);
        model.addAttribute("pageMaker", pageDTO);

        return "defect_report_list";
    }

    // -------------------------------------------------------------------
    // 7. 결함 신고 상세 조회
    // URL: /report/detail
    // -------------------------------------------------------------------
    @GetMapping("/report/detail")
    public String defectReportDetail(@RequestParam("id") Long id, Model model) {
        DefectReportDTO report = defectReportService.getReportById(id);
        model.addAttribute("report", report);
        return "defect_report_detail";
    }

    // -------------------------------------------------------------------
    // 8. 결함 신고 수정 폼 요청 (비밀번호 검증 포함)
    // URL: /report/edit
    // -------------------------------------------------------------------
    @GetMapping("/report/edit")
    public String defectReportEditForm(@RequestParam("id") Long id, @RequestParam("password") String password, Model model, RedirectAttributes rttr) {
        if (!defectReportService.checkPassword(id, password)) {
            rttr.addFlashAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
            return "redirect:/report/detail?id=" + id;
        }
        DefectReportDTO report = defectReportService.getReportById(id);
        model.addAttribute("report", report);
        return "defect_report_edit";
    }

    // -------------------------------------------------------------------
    // 9. 결함 신고 수정 처리
    // URL: /report/edit (POST)
    // -------------------------------------------------------------------
    @PostMapping("/report/edit")
    public String defectReportEditSubmit(DefectReportDTO report,
                                         @RequestParam(value = "newDefectImages", required = false) List<MultipartFile> newFiles,
                                         @RequestParam(value = "existingImageFileNames", required = false) List<String> existingFileNames,
                                         RedirectAttributes rttr) {
        try {
            defectReportService.updateReport(report, newFiles, existingFileNames);
            rttr.addFlashAttribute("message", "결함 신고가 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("errorMessage", "오류가 발생하여 신고 수정에 실패했습니다: " + e.getMessage());
        }
        return "redirect:/report/detail?id=" + report.getId();
    }

    // -------------------------------------------------------------------
    // 10. 결함 신고 삭제 처리
    // URL: /report/delete (POST)
    // -------------------------------------------------------------------
    @PostMapping("/report/delete")
    public String defectReportDelete(@RequestParam("id") Long id, @RequestParam("password") String password, RedirectAttributes rttr) {
        try {
            if (!defectReportService.checkPassword(id, password)) {
                rttr.addFlashAttribute("errorMessage", "비밀번호가 일치하지 않아 삭제에 실패했습니다.");
                return "redirect:/report/detail?id=" + id;
            }
            defectReportService.deleteReport(id);
            rttr.addFlashAttribute("message", "결함 신고가 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("errorMessage", "오류가 발생하여 신고 삭제에 실패했습니다: " + e.getMessage());
        }
        // 리다이렉션 경로 수정: /defect-report-list -> /report/history
        return "redirect:/report/history";
    }
}