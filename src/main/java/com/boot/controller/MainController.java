package com.boot.controller;

import com.boot.dto.*;
import com.boot.service.*;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable; // PathVariable 임포트
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class MainController {

    private final ResourceLoader resourceLoader;
    private final RecallService recallService;
    private final DefectReportService defectReportService;
    private final NoticeService noticeService;
    private final BoardService boardService;
    private final SearchService searchService;

    // -------------------------------------------------------------------
    // 1. 메인 페이지
    // -------------------------------------------------------------------
    @GetMapping("/")
    public String main(Model model) {
        Criteria noticeCri = new Criteria(1, 5);
        List<NoticeDTO> noticeList = noticeService.listWithPaging(noticeCri);
        model.addAttribute("noticeList", noticeList);

        Criteria pressCri = new Criteria(1, 5);
        List<BoardDTO> pressList = boardService.listWithPaging(pressCri);
        model.addAttribute("pressList", pressList);

        return "main";
    }

    // -------------------------------------------------------------------
    // 통합 검색 처리
    // -------------------------------------------------------------------
    @GetMapping("/search")
    public String search(@RequestParam(value = "query") String query, Model model) {
        SearchResultsDTO results = searchService.searchAll(query);
        model.addAttribute("results", results);
        return "search_results";
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
    public String defectReportSubmit(DefectReportDTO report, @RequestParam(value = "defectImages", required = false) List<MultipartFile> files, RedirectAttributes rttr, Principal principal) {
        try {
            if (principal != null) {
                report.setUsername(principal.getName());
            }
            defectReportService.saveReport(report, files);
            rttr.addFlashAttribute("message", "결함 신고가 성공적으로 접수되었습니다. 신고 내역에서 확인해 주세요.");
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("errorMessage", "오류가 발생하여 신고가 접수되지 않았습니다: " + e.getMessage());
        }
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
        return "redirect:/report/history";
    }

    // -------------------------------------------------------------------
    // 11. 리콜 상세 조회
    // URL: /recall/detail/{id}
    // -------------------------------------------------------------------
    @GetMapping("/recall/detail/{id}")
    public String recallDetail(@PathVariable("id") Long id, Model model) {
        RecallDTO recall = recallService.getRecallById(id);
        model.addAttribute("recall", recall);
        return "recall_detail"; // recall_detail.jsp 뷰 반환
    }
}
