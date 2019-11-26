import 'flatpickr/dist/flatpickr.min.css'

import flatpickr from 'flatpickr'
// import可以直接寫檔名最主要原因是在此套件中"package.json"中的main有指定
// e.g. "main": "dist/flatpickr.js"

document.addEventListener('turbolinks:load', function(){
  flatpickr('#book_published_at', {})
})