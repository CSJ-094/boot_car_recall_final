document.addEventListener('DOMContentLoaded', function () {
    const userBtn = document.getElementById('user-btn');
    const adminBtn = document.getElementById('admin-btn');
    const loginTypeInput = document.getElementById('login-type');
    const loginForm = document.getElementById('login-form');

    function switchRole(role) {
        if (role === 'user') {
            userBtn.classList.add('active');
            adminBtn.classList.remove('active');
            loginTypeInput.value = 'user';
            loginForm.action = '/login'; // 사용자 로그인 처리 URL
        } else {
            adminBtn.classList.add('active');
            userBtn.classList.remove('active');
            loginTypeInput.value = 'admin';
            loginForm.action = '/admin/login'; // 관리자 로그인 처리 URL
        }
    }

    userBtn.addEventListener('click', () => switchRole('user'));
    adminBtn.addEventListener('click', () => switchRole('admin'));

    // 초기 로드 시 기본값 설정
    switchRole('user');
});