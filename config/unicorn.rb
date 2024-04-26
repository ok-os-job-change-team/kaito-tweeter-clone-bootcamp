# 実行プロセス数
worker_processes 2

# unicornプロセスIDのパス

pid '/var/run/unicorn.pid'

# Unixドメインソケットのパス(nginx.confの設定と合わせる必要がある)
listen '/var/tmp/unicorn.sock'

# unicornサーバーの標準出力ログのパス
stdout_path './log/unicorn.stdout.log'

# unicornサーバーの標準エラーログのパス
stderr_path './log/unicorn.stderr.log'
