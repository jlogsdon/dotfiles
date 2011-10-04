augroup filetypedetect
    au BufNewFile,BufRead *.xt setf xt
    au BufNewFile,BufRead /usr/local/nginx/conf/* setf nginx
    au BufNewFile,BufRead /etc/nginx/* setf nginx
augroup END
