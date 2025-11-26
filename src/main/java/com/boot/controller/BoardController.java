package com.boot.controller;

import com.boot.dto.BoardDTO;
import com.boot.dto.Criteria;
import com.boot.dto.PageDTO;
import com.boot.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService service;

    @GetMapping("/list")
    public String list(Criteria cri, Model model) {
        log.info("@# Board list");
        log.info("@# cri => " + cri);

        List<BoardDTO> list = service.listWithPaging(cri);
        int total = service.getTotalCount(cri);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", new PageDTO(cri, total));
        return "report_recallInfo"; // 확장자 없음 - OK
    }

    @PostMapping("/write")
    public String write(@RequestParam HashMap<String, String> param) {
        log.info("@# write()");
        log.info("@# param=>"+param);

        service.write(param);

        return "redirect:/board/list";
    }

    @GetMapping("/write_view")
    public String write_view() {
        log.info("@# write_view()");
        return "report_write_view"; // 확장자 없음 - OK
    }

    @GetMapping("/report_content_view")
    public String content_view(@RequestParam("boardNo") int boardNo,
                               @RequestParam("pageNum") int pageNum,
                               @RequestParam("amount") int amount,
                               Model model) {
        log.info("@# report_content_view()");

        // BoardServiceImpl의 contentView에서 조회수 증가를 처리하므로 hitUp 호출 제거
        BoardDTO dto = service.contentView(boardNo);
        model.addAttribute("content_view", dto);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("amount", amount);
        return "report_content_view"; // 확장자 없음 - OK
    }

    @GetMapping("/report_modify_view")
    public String report_modify_view(@RequestParam("boardNo") int boardNo,
                                     @RequestParam("pageNum") int pageNum,
                                     @RequestParam("amount") int amount,
                                     Model model) {
        log.info("@# report_modify_view()");
        // 수정 폼에서는 조회수가 오르면 안되므로, 별도의 메서드가 필요하지만 일단 contentView 사용
        BoardDTO dto = service.contentView(boardNo);
        model.addAttribute("content_view", dto);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("amount", amount); // 확장자 없음 - OK
        return "report_modify_view";
    }

    @PostMapping("/report_modify")
    public String report_modify(@RequestParam HashMap<String, String> param, RedirectAttributes rttr) {
        log.info("@# report_modify()");
        service.modify(param);
        rttr.addAttribute("pageNum", param.get("pageNum"));
        rttr.addAttribute("amount", param.get("amount"));
        return "redirect:/board/list";
    }

    @PostMapping("/report_delete")
    public String report_delete(@RequestParam HashMap<String, String> param, RedirectAttributes rttr) {
        log.info("@# report_delete()");
        service.delete(param);
        rttr.addAttribute("pageNum", param.get("pageNum"));
        rttr.addAttribute("amount", param.get("amount"));
        return "redirect:/board/list";
    }
}
