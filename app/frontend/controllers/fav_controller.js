// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello"> 在最外層
//   <h1 data-target="hello.output"></h1>
//   data-target : hello是Controller名稱，output類似Ruby裡的變數，若要截取變數並需要先寫Controller名稱後，再用點呼叫output
//   <a href="#" data-action="hello#pushme">按我</a>
//   <a href="#" data-target="hi" data-action="hello#pushme">按他</a>
//   data-action : 
// </div>

import { Controller } from "stimulus"
import ax from 'helpers/ax';

export default class extends Controller {
  static targets = ["icon"]

  // initialize() {
  // }

  toggle(evt) {
    evt.preventDefault();
    let id = this.data.get('id');
    let icon = this.iconTarget;
    let button = evt.currentTarget;

    button.classList.add('is-loading');


    // console.log(this.element);
    // console.log(this.data.get('id')); // has, set
    // console.log(this.element.dataset('bookId'));

    // const token = document.querySelector("meta[name=csrf-token]") || {content: 'no-csrf-token'}; // 從原始碼檢視找到csrf-token
    
    // var ax = axios.create({
    //   header: {
    //     common: {
    //       'X-CSRF-TOKEN': token.content
    //     },
    //   },
    // });

    ax.post(`/api/books/${id}/favorite`, {})
      .then(function(response) {
        let favorited = response.data.favorited;

        if (favorited) {
          icon.classList.remove("far");
          icon.classList.add("fas");
        } else {
          icon.classList.remove("fas");
          icon.classList.add("far");
        }
      })

      .catch(function(error) {
        if (error.response.status === 401){
          alert('請先登入會員');
        } else {
          alert ('發生錯誤，請稍後重試')
        }
      })
      .finally(function(){
        button.classList.remove('is-loading')
      })

    // let icon = this.iconTarget;

    // if(icon.classList.contains("fas")) {
    //   icon.classList.remove("fas");
    //   icon.classList.add("far");
    // } else {
    //   icon.classList.remove("far");
    //   icon.classList.add("fas");
    // }
  }
}
