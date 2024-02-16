document.addEventListener('turbo:load', () => {
    // モーダルウィンドウを表示
    const show = document.getElementById('logout-button');
    show.addEventListener('click', () => {
      const modal = document.getElementById('modal-window');
      modal.classList.add('is-active');
    });
    
    // ×ボタンでモーダルウィンドウを閉じる
    const close_delete = document.getElementById('close-modal-delete');
    close_delete.addEventListener('click', () => {
      const modal = document.getElementById('modal-window');
      modal.classList.remove('is-active');
    });

    // いいえボタンでモーダルウィンドウを閉じる
    const close_cancel = document.getElementById('close-modal-cancel');
    close_cancel.addEventListener('click', () => {
      const modal = document.getElementById('modal-window');
      modal.classList.remove('is-active');
    });
  });
