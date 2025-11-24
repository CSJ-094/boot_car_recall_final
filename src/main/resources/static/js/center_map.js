const selectedManufacturerFromServer = '${selectedManufacturer}';

let map, places, infowindow;
let myMarker;
let markers = [];
let listItems = [];

function initMap() {
    const container = document.getElementById('map');
    const options = {
        center: new kakao.maps.LatLng(37.5665, 126.9780),
        level: 5
    };
    map = new kakao.maps.Map(container, options);
    places = new kakao.maps.services.Places();
    infowindow = new kakao.maps.InfoWindow({zIndex: 1});
}

function getSearchKeyword(manufacturer) {
    // CSV/DB의 제조사 값 기준으로 매핑해 주면 됨
    switch (manufacturer) {
        case 'HYUNDAI':
        case '현대':
            return '현대자동차 서비스센터 블루핸즈';
        case 'KIA':
        case '기아':
            return '기아오토큐 서비스센터';
        case 'RENAULT':
        case '르노':
            return '르노코리아 서비스센터';
        case 'SSANGYONG':
        case '쌍용':
            return '쌍용자동차 서비스센터';
        default:
            return '자동차 정비소';
    }
}

function clearMarkers() {
    markers.forEach(m => m.setMap(null));
    markers = [];
}

function clearListActive() {
    listItems.forEach(el => el.classList.remove('active'));
}

function searchNearbyCenters(lat, lng) {
    const manufacturer = document.getElementById('manufacturerSelect').value;
    const radius = parseInt(document.getElementById('radiusSelect').value, 10);
    const keyword = getSearchKeyword(manufacturer);

    const center = new kakao.maps.LatLng(lat, lng);
    map.setCenter(center);

    if (myMarker) myMarker.setMap(null);
    myMarker = new kakao.maps.Marker({ map: map, position: center });

    clearMarkers();

    const searchOptions = {
        location: center,
        radius: radius
    };

    places.keywordSearch(keyword, function(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            renderCenterList(data);
            data.forEach((place, idx) => addMarker(place, idx));
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            document.getElementById('centerList').innerHTML = '주변에 검색되는 센터가 없습니다.';
        } else {
            document.getElementById('centerList').innerHTML = '검색 중 오류가 발생했습니다.';
        }
    }, searchOptions);
}

function addMarker(place, index) {
    const position = new kakao.maps.LatLng(place.y, place.x);
    const marker = new kakao.maps.Marker({
        map: map,
        position: position
    });

    kakao.maps.event.addListener(marker, 'click', function () {
        const content =
            '<div style="padding:8px 12px;font-size:13px;">' +
            '<strong>' + place.place_name + '</strong><br>' +
            (place.road_address_name ? place.road_address_name + '<br>' : place.address_name + '<br>') +
            (place.phone ? 'TEL: ' + place.phone + '<br>' : '') +
            '<a href="https://map.kakao.com/link/to/' + place.id + '" target="_blank">카카오맵 길찾기</a>' +
            '</div>';
        infowindow.setContent(content);
        infowindow.open(map, marker);

        clearListActive();
        const listItem = listItems[index];
        if (listItem) {
            listItem.classList.add('active');
            listItem.scrollIntoView({behavior: 'smooth', block: 'center'});
        }
    });

    markers.push(marker);
}

function renderCenterList(data) {
    const listEl = document.getElementById('centerList');
    listEl.innerHTML = '';
    listItems = [];

    data.forEach((place, index) => {
        const item = document.createElement('div');
        item.className = 'center-item';
        item.innerHTML =
            '<div class="center-item-name">[' + (index + 1) + '] ' + place.place_name + '</div>' +
            '<div class="center-item-addr">' +
            (place.road_address_name || place.address_name || '') +
            '</div>' +
            (place.phone ? '<div class="center-item-tel">TEL: ' + place.phone + '</div>' : '');

        item.addEventListener('click', function () {
            clearListActive();
            item.classList.add('active');

            const pos = new kakao.maps.LatLng(place.y, place.x);
            map.setCenter(pos);
            map.setLevel(4);

            const content =
                '<div style="padding:8px 12px;font-size:13px;">' +
                '<strong>' + place.place_name + '</strong><br>' +
                (place.road_address_name ? place.road_address_name + '<br>' : place.address_name + '<br>') +
                (place.phone ? 'TEL: ' + place.phone + '<br>' : '') +
                '<a href="https://map.kakao.com/link/to/' + place.id + '" target="_blank">카카오맵 길찾기</a>' +
                '</div>';
            infowindow.setContent(content);
            infowindow.setPosition(pos);
            infowindow.open(map);
        });

        listEl.appendChild(item);
        listItems.push(item);
    });
}

document.addEventListener('DOMContentLoaded', function () {
    initMap();

    // 리콜정보 상세에서 manufacturer 파라미터로 넘어온 경우
    if (selectedManufacturerFromServer) {
        const sel = document.getElementById('manufacturerSelect');
        sel.value = selectedManufacturerFromServer;
    }

    document.getElementById('btnMyLocation').addEventListener('click', function () {
        if (!navigator.geolocation) {
            alert('이 브라우저에서는 위치 정보를 지원하지 않습니다.');
            return;
        }
        navigator.geolocation.getCurrentPosition(function (pos) {
            searchNearbyCenters(pos.coords.latitude, pos.coords.longitude);
        }, function () {
            alert('위치 정보를 가져올 수 없습니다. 브라우저 권한을 확인해 주세요.');
        });
    });
});