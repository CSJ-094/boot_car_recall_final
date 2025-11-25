package com.boot.service;

import com.boot.dto.SearchResultsDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SearchService {

    private final RecallService recallService;
    private final NoticeService noticeService;
    private final BoardService boardService;
    private final FaqService faqService;

    public SearchResultsDTO searchAll(String query) {
        SearchResultsDTO results = new SearchResultsDTO(query);

        // 각 서비스의 검색 메서드 호출
        results.setRecalls(recallService.searchRecallsByModelName(query));
        results.setNotices(noticeService.searchByKeyword(query));
        results.setPressReleases(boardService.searchByKeyword(query));
        results.setFaqs(faqService.searchByKeyword(query));

        return results;
    }
}
