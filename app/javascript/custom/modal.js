document.addEventListener('DOMContentLoaded', () => {
    // モーダルウィンドウを表示
    const $show = document.getElementById('logout-button');
    $show.addEventListener('click', () => {
      const $modal = document.getElementById('modal-window');
      $modal.classList.add('is-active');
    });
    
    // ×ボタンでモーダルウィンドウを閉じる
    const $close_1 = document.getElementById('close-modal-1');
    $close_1.addEventListener('click', () => {
      const $modal = document.getElementById('modal-window');
      $modal.classList.remove('is-active');
    });

    // いいえボタンでモーダルウィンドウを閉じる
    const $close_2 = document.getElementById('close-modal-2');
    $close_2.addEventListener('click', () => {
      const $modal = document.getElementById('modal-window');
      $modal.classList.remove('is-active');
    });
  });