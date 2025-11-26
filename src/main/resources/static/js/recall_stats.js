let currentGroupBy = 'MANUFACTURER';
let chartInstance = null;
let fullData = [];
let showModelCol = false;   // ← 모델명 컬럼 표시 여부

document.addEventListener('DOMContentLoaded', () => {
    // 집계 기준 탭
    document.querySelectorAll('.groupby-tabs .tab-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.groupby-tabs .tab-btn')
                .forEach(b => b.classList.remove('is-active'));
            btn.classList.add('is-active');
            currentGroupBy = btn.dataset.groupby;
        });
    });

    // 결과 탭
    document.querySelectorAll('.result-tab').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.result-tab').forEach(b => b.classList.remove('is-active'));
            btn.classList.add('is-active');

            const tab = btn.dataset.tab;
            document.querySelectorAll('.result-view').forEach(v => v.classList.remove('is-active'));
            document.getElementById(tab + 'View').classList.add('is-active');
        });
    });

    // 검색 버튼
    document.getElementById('btnSearch').addEventListener('click', loadStats);

    // 전체 보기 버튼
    document.getElementById('btnShowAll').addEventListener('click', () => {
        renderTable(fullData);
    });
});

function loadStats() {
    const params = new URLSearchParams();

    params.append('groupBy', currentGroupBy);
    params.append('timeUnit', document.getElementById('timeUnit').value);
    params.append('startDate', document.getElementById('startDate').value);
    params.append('endDate', document.getElementById('endDate').value);

    const maker = document.getElementById('maker').value;
    if (maker) params.append('maker', maker);

    const modelKeyword = document.getElementById('modelKeyword').value.trim();
    if (modelKeyword) params.append('modelKeyword', modelKeyword);

    // 🔹 모델 기준이거나, 모델 검색어가 있으면 컬럼 보이게
    showModelCol = (currentGroupBy === 'MODEL' || !!modelKeyword);

    fetch('/recall/stats/data?' + params.toString())
        .then(res => res.json())
        .then(data => {
            fullData = data || [];

            const top10 = fullData.slice(0, 10);
            renderTable(top10);
            renderChart(fullData);
        })
        .catch(err => {
            console.error(err);
            alert('통계 조회 중 오류가 발생했습니다.');
        });
}


function renderTable(rows) {
    const tbody = document.getElementById('statsTableBody');
    tbody.innerHTML = '';

    rows.forEach(row => {
        const tr = document.createElement('tr');
        const displayModelName = row.modelName || '';

        tr.innerHTML = `
            <td>${row.maker}</td>
            <td class="col-model" title="${displayModelName}">
                ${displayModelName}
            </td>
            <td>${row.periodLabel}</td>
            <td>${row.recallCount}</td>
        `;
        tbody.appendChild(tr);
    });

    toggleModelColumn();   // 아래에서 만들 함수 호출
}




function renderChart(rows) {
    const ctx = document.getElementById('statsChart').getContext('2d');

    if (chartInstance) {
        chartInstance.destroy();
    }

    if (!rows || !rows.length) {
        return;
    }

    // 1) 기간 라벨
    const labels = [...new Set(rows.map(r => r.periodLabel))];

    // 2) 제조사 목록 (너무 많으면 보기 지저분하니 상위 5개까지만)
    let groups = [...new Set(rows.map(r => r.groupName))];
    groups = groups.slice(0, 5);

    // 3) 선택된 제조사만 사용
    const filteredRows = rows.filter(r => groups.includes(r.groupName));

    // 4) dataset 구성
    const datasets = groups.map(g => {
        const dataForGroup = labels.map(label => {
            const found = filteredRows.find(
                r => r.groupName === g && r.periodLabel === label
            );
            return found ? found.recallCount : 0;
        });
        return {
            label: g,
            data: dataForGroup
            // 색상은 Chart.js 기본값 사용
        };
    });

    chartInstance = new Chart(ctx, {
        type: 'bar',   // ★ 라인 → 막대
        data: {
            labels,
            datasets
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'bottom' }
            },
            scales: {
                x: { stacked: false },
                y: { beginAtZero: true }
            }
        }
    });
}

function toggleModelColumn() {
    const thModel = document.getElementById('thModelName');
    if (!thModel) return;

    if (showModelCol) {
        thModel.style.display = '';
        document.querySelectorAll('.col-model').forEach(td => {
            td.style.display = '';
        });
    } else {
        thModel.style.display = 'none';
        document.querySelectorAll('.col-model').forEach(td => {
            td.style.display = 'none';
        });
    }
}


